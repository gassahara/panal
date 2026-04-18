#!/bin/bash
ffmpeg="ffmpeg " #comando para ejecutar ffmpeg
entrada="-i " #parametro para definir la entrada
salida=" " #parametro para definir la salida
a=0
if [ ! -z "$1" ];then
    entradas=("$@")
else
    entradas=()
    while read line;do
	entradas[$a]=$line
	a=$((a+1))
    done
fi
for archivo in "${entradas[@]}";do
    while [ "${archivo:0:1}" == " " ];do
	archivo=${archivo:1:${#archivo}}
    done
    if [ -f "$archivo" ];then
	repla=$(echo "$archivo" | sed "s/ /\\\ /g")
	comando="$ffmpeg $entrada $repla "
	$comando 1>"$archivo.comepeliculas.sh.log" 2>&1
	video=$(cat "$archivo.comepeliculas.sh.log" | grep "Video")
	if [ ${#video} -gt 0 ];then
	    durat=$(cat "$archivo.comepeliculas.sh.log" | grep "Durat" | grep -v "00\:00\:00")
	    duratl=$(echo $durat | grep -bo "[0-9][0-9]\:[0-9][0-9]" | cut -d ":" -f1)
	    durat=$(echo $durat | dd bs=1 skip=$duratl 2>/dev/null  | cut -d " " -f1)
	    if [ "0$duratl" -gt "1" ]; then
		echo "$archivo"
	    else
		rm "$archivo.comepeliculas.sh.log"
	    fi
	else
	    rm "$archivo.comepeliculas.sh.log"
	fi
    fi
done

