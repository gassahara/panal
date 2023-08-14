#!/bin/bash
ffmpeg="ffmpeg " #comando para ejecutar ffmpeg
entrada="-i " #parametro para definir la entrada
salida=" " #parametro para definir la salida
archivo="$1"
while [ "${archivo:0:1}" == " " ];do
    archivo=${archivo:1:${#archivo}}
done
if [ -f "$archivo" ];then
    video=$(grep "urn:mpeg:DASH:schema:MPD" "$archivo" )
    if [ -n "$video" ];then
	video=$(grep "mp4" "$archivo" )
	if [ -n "$video" ];then
	    echo " $archivo es un MPEG-DASH"
	fi
    fi
fi
