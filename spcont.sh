#!/usr/bin/bash
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd

hmm1="$PrPWD/comp/sphinx/cmusphinx-es-5.2/model_parameters/voxforge_es_sphinx.cd_ptm_4000/"
lm1="$PrPWD/comp/sphinx/cmusphinx-es-5.2/etc/es-20k.lm"
dic1="$PrPWD/comp/sphinx/cmusphinx-es-5.2/etc/voxforge_es_sphinx.dic"
#dic1="$PrPWD/~/temp.dic"
hmm2="$PrPWD/comp/sphinx/cmusphinx-code-r13291-trunk/sphinx4/sphinx4-data/src/main/resources/edu/cmu/sphinx/models/en-us/en-us"
lm2="$PrPWD/comp/sphinx/cmusphinx-code-r13291-trunk/sphinx4/sphinx4-data/src/main/resources/edu/cmu/sphinx/models/en-us/en-us.lm.bin"
lm3="$PrPWD/comp/sphinx/pocketsphinx-5prealpha/model/en-us/en-us.lm.bin"
hmm3="$PrPWD/comp/sphinx/pocketsphinx-5prealpha/model/en-us/en-us/"
lm4="$PrPWD/comp/sphinx/pocketsphinx-master/model/en-us/en-us.lm.bin"
hmm4="$PrPWD/comp/sphinx/pocketsphinx-master/model/en-us/en-us/"
lm5="$PrPWD/comp/sphinx/sphinx4-5prealpha-src/sphinx4-data/src/main/resources/edu/cmu/sphinx/models/en-us/en-us.lm.bin"
hmm5="$PrPWD/comp/sphinx/sphinx4-5prealpha-src/sphinx4-data/src/main/resources/edu/cmu/sphinx/models/en-us/en-us/"

sox a.wav -n trim 0 1 noiseprof speech.noise-profile
noise=1
noisep="0.1"
while [ $noise -gt 0 ];do
    err=1
    gain="1"
    while [ $err -gt 0 ];do
	if [ $err -eq 2 ];then
 	    gain=$(echo "$gain-0.1"|bc -l)
	fi
	sox a.wav 7.wav gain -n $gain noisered speech.noise-profile $noisep 2>sox_err.txt
	if [ $(cat sox_err.txt | grep -c "clipped") -gt 1 ];then
 	    err=2
	else
 	    err=0
	fi
    done
    sox 7.wav  -b 16 z.wav trim 0 1 channels 1 rate 16000 #speed 0.9
    zeros=$(dd if=z.wav bs=1 skip=44 count=3600 | ../stdtohex | sed "s/FF\|01/00/g"| ../stddelcar " "|../stdbuscaarg_count "00")
    echo "$noisep $gain $zeros"
    if [ "$zeros" != "3600" ];then
	noisep=$(echo "$noisep+0.1"|bc -l)
	noise=1
    else
	noise=0;
    fi
done
sox 7.wav -b 16 6.wav vad channels 1 rate 16000 #speed 0.9
play 6.wav
gcc -o $PrPWD/pocketsphinxrecogfromwav $PrPWD/pocketsphinxrecogfromwav.c -lpocketsphinx -lsphinxad -lsphinxbase -I/usr/include/include -g -O2 -Wall -I/usr/include/sphinxbase -I/usr/include/pocketsphinx -L/usr/lib
$PrPWD/pocketsphinxrecogfromwav -infile 6.wav  -lm $lm1 -time yes -hmm $hmm1 -dict "$dic1" -verbose yes  -agc noise -cmn live -backtrace yes -fsgusefiller no -bestpath yes -varnorm yes -vad_threshold 3 2>/dev/null
