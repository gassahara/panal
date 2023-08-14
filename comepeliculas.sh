#!/bin/bash
ffmpeg="ffmpeg " #comando para ejecutar ffmpeg
entrada="-i " #parametro para definir la entrada
salida=" " #parametro para definir la salida
archivo="$1"
while [ "${archivo:0:1}" == " " ];do
    archivo=${archivo:1:${#archivo}}
done
if [ -f "$archivo" ];then
    video=$(ffmpeg $entrada "$archivo" 2>&1 | grep "Video")
    if [ -n "$video" ];then
	ansi=$(ffmpeg $entrada "$archivo" 2>&1 | grep "ansi")
	if [ -z "$ansi" ];then
	durat=$(ffmpeg $entrada "$archivo" 2>&1 | grep "Durat" | grep -v "00\:00\:00")
	duratl=$(echo $durat | grep -bo "[0-9]\:[0-9][0-9]" | cut -d ":" -f1)
	durat=$(echo $durat | dd bs=1 skip=$duratl 2>/dev/null  | cut -d " " -f1)
	if [ "0$duratl" -gt "1" ]; then
	    echo " $archivo es una pelicula ($durat)"
	fi
	fi
    fi
fi
