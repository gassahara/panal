#!/bin/bash
dir="peliculas"
echo "" >> hazmp4depeliculas.log
if [ ! -e "index.html" ];then
    rm hazmp4depeliculas.log
    touch hazmp4depeliculas.log
fi
sort -ru hazmp4depeliculas.log > hazmp4depeliculas.2.log
mv -v hazmp4depeliculas.2.log  hazmp4depeliculas.log
find . -type f -exec stat --format=%n\&%s\&%y '{}' \; | sort -ru > hazmp4depeliculas.2.log;
archivos=""
c=1
while read d
do
    archivos="$d;$archivos"
done< <(diff --left-column --suppress-common-lines hazmp4depeliculas.log hazmp4depeliculas.2.log | grep "<\|>\|$dir\/" | grep -v "hazmp4depeliculas\.log" )
warchivos=1
echo $archivos;
while [ ! -z "$warchivos" ]; do
    warchivos=$(echo $archivos | grep -obn "\;" | head -n1 | cut -d ":" -f2 )
    a=${archivos:0:$warchivos}
    archivos=${archivos:$((warchivos+1))}
    archivo=$(echo $a | cut -d "&" -f1)
    while [ "${archivo:0:1}" == " " ];do
	archivo=${archivo:1:${#archivo}}
    done
    if [ "${archivo:0:1}" == ">" ];then
	archivo=${archivo:1:${#archivo}}
	while [ "${archivo:0:1}" == " " ];do
	    archivo=${archivo:1:${#archivo}}
	done
	echo "$archivo" >> hazmp4depeliculass.log
	erchivo=$(echo "$archivo" | sed "s/ /\\\ /g; s/\.\///g;")
	if [ -f "$erchivo" ];then
	    archivo=$(./comepeliculas.sh "$erchivo" )
	    if [ ! -z "$archivo" ];then
		errores="....."
		while [ ! -z "$errores" ];do
		    echo -e "ffmpeg -re -i $erchivo -g 52 -ab 64k -f mp4 -vcodec libx264 -vb 448k -movflags frag_keyframe+empty_moov peliculas/$erchivo.mp4 -y 1>$erchivo.hazmp4depeliculass.log 2>&1"
		    ffmpeg -re -i $erchivo -g 52 -ab 64k -f mp4 -vcodec libx264 -vb 448k -movflags frag_keyframe+empty_moov peliculas/$erchivo.mp4 -y 1>$erchivo.hazmp4depeliculass.log 2>&1
		    errores=$(grep "[0-f][0-f] [0-f][0-f] " $erchivo.hazmp4depeliculass.log)
		done
		echo -e "$erchivo -> mp4"
	    fi
	fi
    fi
    echo $a
    SEPARADOR=$( echo "$a" | grep -o "<\|>" )
    if [ ! -z "$SEPARADOR" ];then
	b=$(echo "$a" | cut -d "$SEPARADOR" -f2  | sed "s/\t/ /g;")
	while [ "${b:0:1}" == " " ];do
	    b=${b:1}
	done
	echo $b
	echo "$b" >> hazmp4depeliculas.log
    fi
done
