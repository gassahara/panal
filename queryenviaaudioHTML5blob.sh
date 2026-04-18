#!/bin/bash
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
pasa=0
if [ -z "$1" -o 0$1 -eq 0 ];then
    sleep 0.1
    ps1=3
    nomprograma=$0
    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/" ) -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    done
    while [ 0$ps1 -gt 1 ];do
	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
	sleep 0.1
    done
    lista=$(cat $nomprograma.memoria |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntoposts|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
	$0 &
	disown
    else
	echo "..."
	cp -v puntoposts $nomprograma.memoria
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    cuant=$($PrPWD/datapuntopostcdrn 0$1 | $PrPWD/stdbuscaarg_donde_hasta 0A)
    if [ 0$cuant -gt 0 ];then
	cuant=$(echo $cuant+0$1|bc)
    else
	cuant=0;
    fi
    $0 "0$cuant" &
    disown
    sleep 0.1
    fn=$($PrPWD/datapuntopostcdrn 0$1 | $PrPWD/stdcarn 0$cuant |$PrPWD/stdfromhex | $PrPWD/stdcarsin ".in" )
    if [ -n "$fn" ];then
	echo "0 $cuant $fn"
 	sha=$(cat "$fn.in" | sha256sum|$PrPWD/stdcarsin " " )
	shaf=$(cat procesados/*|$PrPWD/stdbuscaarg "$sha;$0;$fn;" )
	if [ -z "$shaf" ];then
    	    nomprograma=$fn
    	    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    		nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    	    done
    	    echo "$sha;$0;$fn;" >> "procesados/$nomprograma"	    
	    campof=$(cat $fn.in |$PrPWD/stdhttpcontent |$PrPWD/stdcdr "boundary=" | $PrPWD/stdtohex | $PrPWD/stdcarsin 0A | $PrPWD/stdcarsin 0D)
	    dashes=$(echo -n "---" | $PrPWD/stdtohex )
	    ka=999
	    while [ $ka -gt 2 ];do
		ka=$(echo "$campof"|$PrPWD/stdbuscaarg_count "$dashes")
		campof=$(echo "$campof"|$PrPWD/stdcdr $dashes)
		echo "$campof"
	    done
	    
	    name1=$(echo -n 'name="' | $PrPWD/stdtohex )
	    i=1
	    n=0
	    cat $fn.in  | $PrPWD/stdtohex > $fn.hex
	    dondes=$(cat $fn.in  | $PrPWD/stdtohex | $PrPWD/stdbuscaarg_donde "$campof" )
	    diccionario=2
	    

   	    #campo=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof" |$PrPWD/stdcarsin "$campof" |$PrPWD/stdcarsin "$dashes" | $PrPWD/stdcarsin "0A 0D 0A 0D" | $PrPWD/stdcdr "$name1" | $PrPWD/stdcarsin 22 |$PrPWD/stdfromhex )

	    while [ -n "$dondes" ];do
		dondei=$(echo "$dondes"|$PrPWD/stdcarsin " ")
		dondes=$(echo "$dondes" | $PrPWD/stdcdr " ")
		dondef=$(echo "$dondes"|$PrPWD/stdcarsin " ")
		echo "<$dondei $dondef>"
		campo=$(cat $fn.hex | $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei)) | $PrPWD/stdcarsin "0D 0A 0D 0A" | $PrPWD/stdcdr "$name1" | $PrPWD/stdcarsin 22|$PrPWD/stdfromhex)
		echo "--<$campo>--"
		echo "$campo=$field>"
		if [ "$campo" = "audio" ];then
		    audio=1
		    r=$((r+1))
		fi
		if [ "$campo" = "formato" ];then
		    formato=$(cat $fn.hex | $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei)) |$PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex|$PrPWD/stdcdr "audio/")
		    echo "<< FORMATO $formato >>"
		    r=$((r+1))
		fi
		if [ "$campo" = "archivo" ];then
    		    cat $fn.hex | $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei)) |$PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A $campof"|$PrPWD/stdfromhex > $fn.audio
		    echo ">>BINARIO $(ls -l $fn.audio)<<"
		    r=$((r+1))
		fi
		i=$((i+1))
	    done
	    echo -e "\n\n\nr=$r i=$i"
	    nn=$fn
    	    while [ $(echo $nn | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    		nn=$(echo $nn | $PrPWD/stdcdr "/" )
    	    done

 	    if [ 0$r -eq 3 -a $audio -eq 1 ];then
		mv $fn.audio $fn.$formato
		ffmpeg -i $fn.$formato $nn.wav
		if [ -f $nn.wav -a $(stat -c "%s" $nn.wav) -gt 100 ];then
		    sox $nn.wav -n trim 0 1 noiseprof speech.noise-profile
		    noise=1
		    noisep="0.1"
		    while [ $noise -gt 0 ];do
			err=1
			gain="1"
			while [ $err -gt 0 ];do
			    if [ $err -eq 2 ];then
 				gain=$(echo "$gain-0.1"|bc -l)
			    fi
			    sox $nn.wav $nn-7.wav gain -n $gain noisered speech.noise-profile $noisep 2>$nn_sox_err.txt
			    echo $gain
			    if [ $(cat $nn_sox_err.txt | grep -c "clipped") -gt 1 ];then
 				err=2
			    else
 				err=0
			    fi
			done
			sox $nn-7.wav  -b 16 z.wav trim 0 1 channels 1 rate 16000 #speed 0.9
			zeros=$(dd if=z.wav bs=1 skip=44 count=3600 2>/dev/null| ../stdtohex | sed "s/FF\|01/00/g"| ../stddelcar " "|../stdbuscaarg_count "00")
			echo "noise=$noisep gain=$gain zeros=$zeros"
			if [ "$zeros" != "3600" ];then
			    noisep=$(echo "$noisep+0.1"|bc -l)
			    noise=1
			else
			    noise=0;
			fi
		    done
		    sox $nn-7.wav -b 16 $nn-6.wav vad channels 1 rate 16000 #speed 0.9
		    gcc -o $PrPWD/pocketsphinxrecogfromwav $PrPWD/pocketsphinxrecogfromwav.c -lpocketsphinx -lsphinxad -lsphinxbase -I/usr/include/include -g -O2 -Wall -I/usr/include/sphinxbase -I/usr/include/pocketsphinx -L/usr/lib


		    hmm1="$PrPWD/comp/sphinx/cmusphinx-es-5.2/model_parameters/voxforge_es_sphinx.cd_ptm_4000/"
		    lm1="$PrPWD/comp/sphinx/cmusphinx-es-5.2/etc/es-20k.lm"
		    dic1="$PrPWD/comp/sphinx/cmusphinx-es-5.2/etc/voxforge_es_sphinx.dic"
		    echo "Reconociendo..."
		    $PrPWD/pocketsphinxrecogfromwav -infile $nn-6.wav  -lm $lm1 -time yes -hmm $hmm1 -dict "$dic1" -verbose yes  -agc noise -cmn live -backtrace yes -fsgusefiller no -bestpath yes -varnorm yes -vad_threshold 3 1> $nn-resultados.txt 2>/dev/null
		    echo "R..."
		    echo "<HTML><BODY>"> $nn-cabecera.txt
		    echo "<audio src=\"$nn-6.wav\" controls></audio><br><div style=\"position:relative;width:80%;left:10%;\"><pre>" > $nn-body.html
		    if [ $(stat -c "%s" $nn-resultados.txt) -gt 4 ];then
			cat $nn-resultados.txt >>  $nn-body.html
		    else
			echo "NO ENTENDI"  >>  $nn-body.html
		    fi
		    echo "</pre></div></BODY></HTML>" > $nn-tail.txt
		    cat $nn-cabecera.txt  $nn-body.html $nn-tail.txt > $fn.html
		else
		    echo "<HTML><BODY><h2>PROBLEMA AL CONVERTIR</h2></BODY></HTML>" > $fn.html
		fi
		
	    fi
	fi
    fi
fi

