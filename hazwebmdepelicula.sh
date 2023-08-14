#!/bin/bash
dir="peliculas"
echo "" >> hazwebmdepelicula.log
if [ ! -e "index.html" ];then
    rm hazwebmdepelicula.log
    touch hazwebmdepelicula.log
fi
sort -ru hazwebmdepelicula.log > hazwebmdepelicula.2.log
mv -v hazwebmdepelicula.2.log  hazwebmdepelicula.log
find . -type f -exec stat --format=%n\&%s\&%y '{}' \; | sort -ru > hazwebmdepelicula.2.log;
archivos=""
c=1
while read d
do
    archivos="$d;$archivos"
done< <(diff --left-column --suppress-common-lines hazwebmdepelicula.log hazwebmdepelicula.2.log | grep "<\|>\|$dir\/" | grep -v "hazwebmdepelicula\.log" )
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
	erchivo=$(echo "$archivo" | sed "s/ /\\\ /g; s/\.\///g;")
	echo -e "---------\n$archivo"
	if [ -e "$erchivo" ];then
	    archivo=$(./comepeliculas.sh "$erchivo" )
	    if [ ! -z "$archivo" ];then
		errores="....."
		while [ ! -z "$errores" ];do
		    echo "ffmpeg -re -i $erchivo -g 52 -ab 64k -f webm -vcodec vp8 -vb 448k -movflags frag_keyframe+empty_moov peliculas/$erchivo.webm -y 1>$erchivo.hazwebmdepelicula.log 2>&1"
		    ffmpeg -re -i $erchivo -g 52 -ab 64k -f webm -vcodec vp8 -vb 448k -movflags frag_keyframe+empty_moov $dir/$erchivo.webm -y 1>$erchivo.hazwebmdepelicula.log 2>&1
		    errores=$(grep " [0-f][0-f] [0-f][0-f] " $erchivo.hazwebmdepelicula.log)
		    sleep 1
		done
		echo "$erchivo -> webm"
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
	echo "$b" >> hazwebmdepelicula.log
    fi
done
