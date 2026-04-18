/* -*- c-basic-offset: 4; indent-tabs-mode: nil -*- */
/* ====================================================================
 * Copyright (c) 1999-2010 Carnegie Mellon University.  All rights
 * reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer. 
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * This work was supported in part by funding from the Defense Advanced 
 * Research Projects Agency and the National Science Foundation of the 
 * United States of America, and the CMU Sphinx Speech Consortium.
 *
 * THIS SOFTWARE IS PROVIDED BY CARNEGIE MELLON UNIVERSITY ``AS IS'' AND 
 * ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL CARNEGIE MELLON UNIVERSITY
 * NOR ITS EMPLOYEES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * ====================================================================
 *
 */
/*
 * continuous.c - Simple pocketsphinx command-line application to test
 *                both continuous listening/silence filtering from microphone
 *                and continuous file transcription.
 */

/*
 * This is a simple example of pocketsphinx application that uses continuous listening
 * with silence filtering to automatically segment a continuous stream of audio input
 * into utterances that are then decoded.
 * 
 * Remarks:
 *   - Each utterance is ended when a silence segment of at least 1 sec is recognized.
 *   - Single-threaded implementation for portability.
 *   - Uses audio library; can be replaced with an equivalent custom library.
 */

#include <stdio.h>
#include <string.h>
#include <sphinxbase/err.h>
#include "pocketsphinx.h"
#include <unistd.h>

static const arg_t cont_args_def[] = {
    POCKETSPHINX_OPTIONS,
    /* Argument file. */
    {"-argfile",
     ARG_STRING,
     NULL,
     "Argument file giving extra arguments."},
    {"-adcdev",
     ARG_STRING,
     NULL,
     "Name of audio device to use for input."},
    {"-infile",
     ARG_STRING,
     NULL,
     "Audio file to transcribe."},
    {"-inmic",
     ARG_BOOLEAN,
     "no",
     "Transcribe audio from microphone."},
    {"-time",
     ARG_BOOLEAN,
     "no",
     "Print word times in file transcription."},
    CMDLN_EMPTY_OPTION
};

static ps_decoder_t *ps;
static cmd_ln_t *config;
static FILE *rawfd;


static int check_wav_header(char *header, int expected_sr) {
    int sr;

    if (header[34] != 0x10) {
        E_ERROR("Input audio file has [%d] bits per sample instead of 16\n", header[34]);
        return 0;
    }
    if (header[20] != 0x1) {
        E_ERROR("Input audio file has compression [%d] and not required PCM\n", header[20]);
        return 0;
    }
    if (header[22] != 0x1) {
        E_ERROR("Input audio file has [%d] channels, expected single channel mono\n", header[22]);
        return 0;
    }
    sr = ((header[24] & 0xFF) | ((header[25] & 0xFF) << 8) | ((header[26] & 0xFF) << 16) | ((header[27] & 0xFF) << 24));
    if (sr != expected_sr) {
        E_ERROR("Input audio file has sample rate [%d], but decoder expects [%d]\n", sr, expected_sr);
        return 0;
    }
    return 1;
}


/*
 * Continuous recognition from a file
 */
static void recognize_from_file() {
    int ssize=2048;
    int16 adbuf[ssize];
    const char *fname;
    const char *hyp;
    int32 k;
    uint8 utt_started, in_speech;

    fname = cmd_ln_str_r(config, "-infile");
    if ((rawfd = fopen(fname, "rb")) == NULL) {
        E_FATAL_SYSTEM("Failed to open file '%s' for reading",
                       fname);
    }
    
    if (strlen(fname) > 4 && strcmp(fname + strlen(fname) - 4, ".wav") == 0) {
        char waveheader[44];
	fread(waveheader, 1, 44, rawfd);
	if (!check_wav_header(waveheader, (int)cmd_ln_float32_r(config, "-samprate")))
    	    E_FATAL("Failed to process file '%s' due to format mismatch.\n", fname);
    }

    if (strlen(fname) > 4 && strcmp(fname + strlen(fname) - 4, ".mp3") == 0) {
	E_FATAL("Can not decode mp3 files, convert input file to WAV 16kHz 16-bit mono before decoding.\n");
    }
    
    ps_start_utt(ps);
    utt_started = FALSE;
    int y=0;
    ps_nbest_t *psnbst;
    
    int m=0;
    int pa=0;
    int posg=ftell(rawfd);
    int sil=0;
    int paso=0;
    int iniciosil=0;
    int seekd=0;
    while ((k = fread(adbuf, sizeof(int16), ssize, rawfd)) > 0) {
        //    while ((k = read(fileno(rawfd), adbuf, sizeof(int16)*ssize)) > 0) {
        m=0;
        paso=0;
        sil=0;
        pa=0;
        seekd=0;
        while(m<ssize && k==ssize) {
            if(m>1 && (pa==0||pa==1 || pa==0xff) && ((uint8)adbuf[m]==0 || (uint8)adbuf[m]==1 || (uint8)adbuf[m]==0xff) ) {
                sil++;
            } else {
                paso=1;
                sil=0;
                pa=adbuf[m];
            }
            if(sil>6 && paso) {
                iniciosil=m;
                while(m<ssize && ((uint8)adbuf[m]==0 || (uint8)adbuf[m]==1 || (uint8)adbuf[m]==0xff)) m++;
                if(m-12>iniciosil) m-=12;
                //                printf("<%d %ld ->", posg, ftell(rawfd));
                posg+=(m+1);
                fseek(rawfd, posg, 0);
                //                printf("salto %d %ld>", posg, ftell(rawfd));
                m=iniciosil;
                while(m<ssize) {
                    adbuf[m]=0;
                    if(m%8==0) m=0xffffl;
                    m++;
                }
                seekd=1;
                break;
            }
            m++;
        }
        ps_process_raw(ps, adbuf, k, FALSE, FALSE);
        in_speech = ps_get_in_speech(ps);
        if(!seekd) posg+=k;
        else in_speech=0;
        //        printf(" %d(%d:%08d)\n", in_speech, k, posg);
        if (in_speech && !utt_started) {
            utt_started = TRUE;
        }
        
        if (!in_speech && utt_started) {
            ps_end_utt(ps);
            psnbst=ps_nbest ( ps);
	    y=0;
            while (psnbst!=NULL && y<10) {
		printf("[ %s ]\n",  ps_nbest_hyp ( psnbst, NULL));
	        psnbst=ps_nbest_next(psnbst);
		y++;
            }
            hyp = ps_get_hyp(ps, NULL);
            if (hyp != NULL){
        	printf("*%s*\n ", hyp);
                y++;
            }
            fflush(stdout);
            ps_start_utt(ps);
            utt_started = FALSE;
        }
        
    }
    ps_end_utt(ps);
    y=0;
    if (utt_started) {
        psnbst=ps_nbest ( ps);
        hyp = ps_get_hyp(ps, NULL);
        while (psnbst!=NULL && y<10) {
            printf("[ %s ]\n",  ps_nbest_hyp ( psnbst, NULL));
            psnbst=ps_nbest_next(psnbst);
            y++;
        }
        if (hyp != NULL) {
    	    printf("*%s*\n", hyp);
            y++;
	}
    }
    
    fclose(rawfd);
}

/*
 * Main utterance processing loop:
 *     for (;;) {
 *        start utterance and wait for speech to process
 *        decoding till end-of-utterance silence will be detected
 *        print utterance result;
 *     }
 */
int main(int argc, char *argv[]) {
    config = cmd_ln_parse_r(NULL, cont_args_def, argc, argv, TRUE);

    if (config == NULL || (cmd_ln_str_r(config, "-infile") == NULL && cmd_ln_boolean_r(config, "-inmic") == FALSE)) {
	E_INFO("Specify '-infile <file.wav>' to recognize from file or '-inmic yes' to recognize from microphone.\n");
        cmd_ln_free_r(config);
	return 1;
    }

    ps_default_search_args(config);
    ps = ps_init(config);
    if (ps == NULL) {
        cmd_ln_free_r(config);
        return 1;
    }

    E_INFO("%s COMPILED ON: %s, AT: %s\n\n", argv[0], __DATE__, __TIME__);

    if (cmd_ln_str_r(config, "-infile") != NULL) {
        recognize_from_file();
    }

    ps_free(ps);
    cmd_ln_free_r(config);

    return 0;
}

