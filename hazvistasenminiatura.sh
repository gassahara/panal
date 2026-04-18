#!/bin/bash
dir="peliculas"
echo "" >> hazvistasenminiatura.log
if [ ! -f "index.html" ];then
    rm hazvistasenminiatura.log
    touch hazvistasenminiatura.log
fi
sort -ru hazvistasenminiatura.log > hazvistasenminiatura.2.log
mv -v hazvistasenminiatura.2.log  hazvistasenminiatura.log
find . -type f -exec stat --format=%n\&%s\&%y '{}' \; | sort -ru > hazvistasenminiatura.2.log;
archivos=""
c=1
while read d
do
    archivos="$d;$archivos"
done< <(diff --left-column --suppress-common-lines hazvistasenminiatura.log hazvistasenminiatura.2.log | grep "<\|>\|$dir\/" | grep -v "hazvistasenminiatura\.log" )
warchivos=1
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
	if [ -f "$erchivo" ];then
	    archivo=$(./comepeliculas.sh "$erchivo" )
	    if [ ! -z "$archivo" ];then
		exito=0;
		f=15;s=600;fps=0;fpss=()
		thumbsalida=$(echo "$erchivo-thumb-" | sed "s/\//-/g")
		while [ "$exito" -lt "1" ];do
		    ffmpeg -ss 3 -i $erchivo -frames:v 5 -vf "select=gt(scene\\,0.4)" -vsync vfr -vf fps=fps=$f/$s peliculas/$thumbsalida%02d.jpg -y 1>$erchivo.hazvistasenminiatura.log 2>&1
		    echo -e "\n ----------------\n ffmpeg -ss 3 -i $erchivo -frames:v 5 -vf \"select=gt(scene\\,0.4)\" -vsync vfr -vf fps=fps=$f/$s peliculas/$thumbsalida%02d.jpg -y 1>$erchivo.hazvistasenminiatura.log 2>&1 \n ----------------- \n"
		    thumbs=(peliculas/$thumbsalida*.jpg)
		    if [ "${#thumbs[@]}" -lt "3" -o "${#thumbs[@]}" -ge "9" ];then
			for rmfile in ${thumbs[@]};do
			    rm -v  $rmfile
			done
			
			fpsale=0;
			while [ $fpsale -eq 0 ];do
			    if [ "$s" -lt "3" ];then
				s=666;
				f=30;
			    fi
			    if [ "$f" -lt "2" ];then
				s=$(echo "a=$s*1.3;scale=0;a/=1;print a;" | bc -l)
				f=30;
			    fi
			    if [ "$f" -gt "60" ];then
				s=$(echo "a=$s/1.3;scale=0;a/=1;print a;" | bc -l)
				fps=30;
			    fi
			    if [ "${#thumbs[@]}" -lt "3" ];then
				f=$((f+1));
			    fi
			    if [ "${#thumbs[@]}" -ge "9" ];then
				f=$((f-1));
			    fi
			    if [ "$s" -gt "1500" ];then
				s=1000;
				break;
			    fi
			    rompe=0
			    for r in fpss;do
				if [ "r" == "$f/$s" ];then
				    rompe=1
				fi
			    done
			    if [ $rompe -eq 0 ];then
				fpsale=1
			    fi
			    fps=$((fps+1))

			    if [  "$fps" -ge "100" ];then
				exito=1
			    fi
			done
		    else
			exito=1
		    fi
		done
		echo -e "\n>>>>>>>>>>>>>>>>>>>>>>>>>\n${#thumbs[@]} thumbs de $erchivo\n<<<<<<<<<<<<<<<<<<<<<<<<\n"
	    fi
	fi
    fi
    #echo "%% $archivo";
    echo "hazvistasenminiatura >> $a"
    SEPARADOR=$( echo "$a" | grep -o "<\|>" )
    if [ ! -z "$SEPARADOR" ];then
	b=$(echo "$a" | cut -d "$SEPARADOR" -f2  | sed "s/\t/ /g;")
	while [ "${b:0:1}" == " " ];do
	    b=${b:1}
	done
	echo $b
	echo "$b" >> hazvistasenminiatura.log
    fi
done
setsid $0 &
