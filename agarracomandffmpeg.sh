#!/bin/bash
dir="peliculas"
echo "" >> agarracomandffmpeg.log
if [ ! -e "index.html" ];then
    rm agarracomandffmpeg.log
    touch agarracomandffmpeg.log
fi
sort -ru agarracomandffmpeg.log > agarracomandffmpeg.2.log
mv -v agarracomandffmpeg.2.log  agarracomandffmpeg.log
find . -type f -exec stat --format=%n\&%s\&%y '{}' \; | sort -ru > agarracomandffmpeg.2.log;
archivos=""
c=1
while read d
do
    archivos="$d;$archivos"
done< <(diff --left-column --suppress-common-lines agarracomandffmpeg.log agarracomandffmpeg.2.log | grep "<\|>\|$dir\/" | grep -v "agarracomandffmpeg\.log" )
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
	if [ -f "$archivo" ];then
	    visor=$(./buscatodos.sh "$archivo" "Output #"  "Input #" "ffmpeg " )
	    if [ ! -z "$visor" ]
	    then
		echo -e "\n MIRA $archivo ES UN log de Conversion\n";
		input1=$(grep "Input #" "$archivo" | tail -n1)
		desde=$(echo $input1 | grep -bon " " | tail -n1 | cut -d ":" -f2)
		input1=$(echo ${input1:$desde}  | cut -d "'" -f2)
		output=""
		while read output1;do
		    desde=$(echo $output1 | grep -bon " " | tail -n1 | cut -d ":" -f2)
		    output1=$(echo ${output1:$desde} | cut -d "'" -f2)
		    echo $output1
		    if [ -f "$output1" ];then
			espelicula=$(./comepeliculas.sh "$output1")
			if [ ! -z "$espelicula" ]; then
			    output="$output\n<source src=\"../$output1\">"
			fi
		    fi
		done< <(grep "Output #" "$archivo")
		echo -e "---$input1--\n"
		visores=$(find . -iname "$input1*html" | wc -l )
		if [ ! -z "$espelicula" ]; then
		    if [ "0$visores" -lt "1" ];then
			echo -e "<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte $input1 </title><script src=\"../../dashjs/dist/dash.all.debug.js\"></script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte </h1><div align=center style=\"width:80%;position: relative; top:20%;left:10%;\">\n<video autoplay preload=\"true\" controls=\"true\">$output</video>\n</div></body></html>" > "peliculas/$input1.html"
		    else
			while read visor;do
			    while read busca;do
				busca=$(echo $busca | sed "s/\./\\\\\./g; s/\"/\\\\\"/g; s/\//\\\\\//g; ")
				buscar=$(grep -bon "$busca" "$visor" | wc -l)
				if [ "$buscar" -lt "1" ];then
				    echo "s/<\/video/$busca<\/video/g"
				    sed "s/<\/video/$busca<\/video/g" $visor > $visor.temp.agarracommandffmpeg.sh
				    mv $visor.temp.agarracommandffmpeg.sh $visor
				else
				    echo -e "\n$busca ya esta en $visor\n"
				fi
			    done< <(echo -e $output)
			done< <(find . -iname "$input1*html")
		    fi
		fi
	    fi
	    
	fi
    fi
    #echo "%% $archivo";
    SEPARADOR=$( echo "$a" | grep -o "<\|>" )
    if [ ! -z "$SEPARADOR" ];then
	b=$(echo "$a" | cut -d "$SEPARADOR" -f2  | sed "s/\t/ /g;")
	while [ "${b:0:1}" == " " ];do
	    b=${b:1}
	done
	echo $b
	echo "$b" >> agarracomandffmpeg.log
    fi
done
