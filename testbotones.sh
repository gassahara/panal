#!/usr/bin/bash
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
echo $PrPWD
PWD2=$PWD
botones="$PrPWD/x11tests/"
dic1="$PrPWD/sphinx/cmusphinx-es-5.2/etc/voxforge_es_sphinx.dic"
longitud=5
echo "$dic1"

palabra="99999999999999999"
pale=1
letras="[abcdefgijklmnopqrstuvyñz]"
expre="^$letras$letras$letras"
letra=3
long=$(echo "$longitud-2"|bc)
while [ $letra -le $longitud ];do
    expre=$(echo "$expre \|$expre$letras ")
    letra=$((letra+1))
done
echo ".$expre."
echo "_________________________"
cat "$dic1" | grep "$expre" > testbotones.dic
head testbotones.dic|grep --color "^$expre"
dic1="testbotones.dic"
lineasdic=$(cat "$dic1" | wc -l)
echo "($lineasdic)"

while [ $pale -gt 0 ];do
#    while [ $(echo "$palabra"|wc -c) -gt 5 ];do
	nbits=1
	nh=1
	while [ 0$nh -lt 0$lineasdic ];do
	    n=$(dd if=/dev/urandom  bs=1 count=$nbits skip=$nbits 2>/dev/null | $PrPWD/stdtohex |$PrPWD/stddelcar " ")
	    nh=$(echo "ibase=16;$n"|bc)
	    nbits=$((nbits+1))
	done
	while [ 0$nh -gt 0$lineasdic ];do
	    nh2=$(echo "$nh-$lineasdic"|bc)
	    nh=$nh2
	done
	echo $nh2
	lineasdiclugares=$(cat "$dic1"|$PrPWD/stdbuscaarg_donde $'\n')
	palabra=$(head -n $nh2 "$dic1" | tail -n1 | $PrPWD/stdcarsin " " )
	echo "< $palabra >"
#    done

    cd $botones
    echo -n "$palabra" > $PWD2/texto1.in && tail -F $PWD2/texto1.in | ./textofijoaimagenbinaria|./xsolostretchdestdin &
    echo -n "" > $PWD2/cambiapalabra.in   && tail -F $PWD2/cambiapalabra.in   | ./xslflecha1  1> $PWD2/cambiopalabra.out &
    echo -n "" > $PWD2/correctopalabra.in && tail -F $PWD2/correctopalabra.in | ./xslcorrecto 1> $PWD2/correctapalabra.out &
    cd $PWD2
    prevb1o=$(cat cambiopalabra.out)
    prevb2o=$(cat correctapalabra.out)
    cambio=0
    while [ 1 ];do
	b1o=$(cat cambiopalabra.out)
	if [ "$b1o" != "$prevb1o" ];then
	    cambio=1
	    break
	else
	    bio1=$prevb1o
	fi
	b1o=$(cat correctapalabra.out)
	if [ "$b1o" != "$prevb1o" ];then
	    cambio=2
	    break
	else
	    bio1=$prevb1o
	fi
    done
    if [ $cambio = 2 ];then
	pale=0
    else
	pale=1
    fi

    if [ $cambio = 1 ];then
	pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "textofijoa"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
	kill $pid
	pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "xsolostret"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
	kill $pid
	palabra="9999999999999"
    fi
    pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "xslfle"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
    kill $pid
    pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "xslcorr"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
    kill $pid
done

cd $botones
echo -n "" > $PWD2/boton1.in && tail -F $PWD2/boton1.in | ./xsolobotonanim2 1> $PWD2/boton1.out &
cd $PWD2
prevb1o=$(cat boton1.out)
while [ 1 ];do
    b1o=$(cat boton1.out)
    if [ "$b1o" != "$prevb1o" ];then
	break
    else
	bio1=$prevb1o
    fi
done
echo -n "" > boton1.out

rec a.wav gain 0.5 &
pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "rec "|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
echo "$pid :"
prevb1o=$(cat boton1.out)
while [ 1 ];do
    b1o=$(cat boton1.out)
    if [ "$b1o" != "$prevb1o" ];then
	break
    else
	bio1=$prevb1o
    fi
done
kill $pid

hmm1="$PrPWD/sphinx/cmusphinx-es-5.2/model_parameters/voxforge_es_sphinx.cd_ptm_4000/"
lm1="$PrPWD/sphinx/cmusphinx-es-5.2/etc/es-20k.lm"
dic1="$PrPWD/sphinx/cmusphinx-es-5.2/etc/voxforge_es_sphinx.dic"
#dic1="$PrPWD/~/temp.dic"
hmm2="$PrPWD/sphinx/cmusphinx-code-r13291-trunk/sphinx4/sphinx4-data/src/main/resources/edu/cmu/sphinx/models/en-us/en-us"
lm2="$PrPWD/sphinx/cmusphinx-code-r13291-trunk/sphinx4/sphinx4-data/src/main/resources/edu/cmu/sphinx/models/en-us/en-us.lm.bin"
lm3="$PrPWD/sphinx/pocketsphinx-5prealpha/model/en-us/en-us.lm.bin"
hmm3="$PrPWD/sphinx/pocketsphinx-5prealpha/model/en-us/en-us/"
lm4="$PrPWD/sphinx/pocketsphinx-master/model/en-us/en-us.lm.bin"
hmm4="$PrPWD/sphinx/pocketsphinx-master/model/en-us/en-us/"
lm5="$PrPWD/sphinx/sphinx4-5prealpha-src/sphinx4-data/src/main/resources/edu/cmu/sphinx/models/en-us/en-us.lm.bin"
hmm5="$PrPWD/sphinx/sphinx4-5prealpha-src/sphinx4-data/src/main/resources/edu/cmu/sphinx/models/en-us/en-us/"

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
    if [ "$noisep" = "1.5" -o "$gain" = "-4.0" ];then
	kill $pid
	echo -n "" > boton1.out
	pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "xsolobotonanim2"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
	kill $pid
	pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "textofijoa"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
	kill $pid
	pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "xsolostret"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
	kill $pid
	exit 0
    fi
done
sox 7.wav -b 16 6.wav vad channels 1 rate 16000 #speed 0.9
play 6.wav
gcc -o $PrPWD/pocketsphinxrecogfromwav $PrPWD/pocketsphinxrecogfromwav.c -lpocketsphinx -lsphinxad -lsphinxbase -I/usr/include/include -g -O2 -Wall -I/usr/include/sphinxbase -I/usr/include/pocketsphinx -L/usr/lib
$PrPWD/pocketsphinxrecogfromwav -infile 6.wav  -lm $lm1 -time yes -hmm $hmm1 -dict "$dic1" -verbose yes  -agc noise -cmn live -backtrace yes -fsgusefiller no -bestpath yes -varnorm yes -vad_threshold 3 2>/dev/null



kill $pid
echo -n "" > boton1.out
pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "xsolobotonanim2"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
kill $pid
pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "textofijoa"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
kill $pid
pid=$(ps -Am -o "%c;%p;" | $PrPWD/stdcdr "xsolostret"|$PrPWD/stdcdr ";"|$PrPWD/stdcarsin ";" )
kill $pid
exit 0
