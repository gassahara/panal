#!/bin/bash
echo "" >> comepeliculas.sh.log
ffmpeg="ffmpeg " #comando para ejecutar ffmpeg
entrada="-i " #parametro para definir la entrada
salida=" " #parametro para definir la salida
webm=" -f webm -vcodec vp8 " #combinacion de parametros para el formato webm
mp4=" -vcodec libx264 -vb 448k -f mp4" #combinacion de parametros para el formato mp4
stream=" -re -g 52  -ab 64k -vb 448k -movflags frag_keyframe+empty_moov " #commbinacion de parametrso para stream fragmentado
index=$(cat comepeliculas.sh.log 2>/dev/null);
indexa=$(find $1 -type f -exec stat --format=%n\&%s\&%z '{}' \; > comepeliculas.sh.2.log);
hay=$(diff -y --left-column --suppress-common-lines comepeliculas.sh.log comepeliculas.sh.2.log | grep -v "=\|comepeliculas.sh\.log" | tr "\n" "\"" | sed "s/\"/\\\n/g")
if [ "${#hay}" -gt "0" ]
then
    while read a
    do
	archivo=$(echo $a | cut -d "&" -f1)
	while [ "${archivo:0:1}" == " " ];do
	    archivo=${archivo:1:${#archivo}}
	done
	if [ "${archivo:0:1}" == ">" ];then
	    archivo=${archivo:1:${#archivo}}
	    while [ "${archivo:0:1}" == " " ];do
		archivo=${archivo:1:${#archivo}}
	    done
	    if [ -f "$archivo" ];then
		repla=$(echo "$archivo" | sed "s/ /\\\ /g")
		video=$(cat "$archivo.comepeliculas.sh.log" | grep "Video")
		if [ ${#video} -gt 0 ];then
		    durat=$(cat "$archivo.comepeliculas.sh.log" | grep "Durat" | grep -v "00\:00\:00")
		    duratl=$(echo $durat | grep -bo "[0-9][0-9]\:[0-9][0-9]" | cut -d ":" -f1)
		    durat=$(echo $durat | dd bs=1 skip=$duratl 2>/dev/null  | cut -d " " -f1)
		    if [ "0$duratl" -gt "1" ]; then
			echo " $archivo es una pelicula ($durat)"
		    else
			rm -v "$archivo.comepeliculas.sh.log"
		    fi
		else
		    rm -v "$archivo.comepeliculas.sh.log"
		fi
	    fi
	fi
    done< <(echo -e $hay)
fi
