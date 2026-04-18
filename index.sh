#!/bin/bash
echo "" >> index.log
if [ ! -e "index.html" ];then
    rm index.log
    touch index.log
fi
indexa=$(find . -type f -exec stat --format=%n\&%s\&%z '{}' \; > index.2.log);
hay=$(diff -y --left-column --suppress-common-lines index.log index.2.log | grep -v "=\|index\.log" | tr "\n" "\"" | sed "s/\"/\\\n/g")
extensiones="html\|htm";
#echo -e "$hay"
if [ "${#hay}" -gt "0" ]
then
    while read a
    do
	#echo -e "$a"
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
		lenfn=${#archivo}
		while read b
		do
		    lenfn2=${#b}
		    lenfn2=$((lenfn-$lenfn2))
		    ext=${archivo:$lenfn2:$lenfn}
		    #echo -e "$ext != $b (desde$lenfn2 hasta $lenfn)\n"
		    if [ "$ext" == "$b" ]
		    then
			visor=$(grep -oe "<video"  $archivo | wc -l)
			if [ "0$visor" -gt "0" ]
			then
			    visor=$(grep -oe "\<source" $archivo | wc -l)
			    if [ "0$visor" -gt "0" ]
			    then
				visor=$(grep -oe "$extensiones"  $archivo  | wc -l)
				if [ "0$visor" -gt "0" ]
				then
				    echo -e "\n MIRA $archivo ES UN VISOR\n";
				    if [ -e "index.html" ];then
					desde=$(grep -nboni "<h1" $archivo | cut -d ":" -f2)
					hasta=$(grep -nboni "<\/h1" $archivo | cut -d ":" -f2)
					hasta=$((hasta-$desde))
					erchivo=$(dd if=$archivo bs=1 skip=$desde count=$hasta 2>/dev/null | tr " " "\n" | tail -n1)
					echo "ERCHI $erchivo"
					html1="<tr><td><a href=\"$archivo\">$erchivo</a></td><td><img src=\""				
					ind=$(find -iname "*$erchivo*.jpg" | tr "\n" "&" | sed "s/\&/\"\><\/td\><td\><td\><img src=\"/g" | sed "s/\.\///g" )
					html1="$html1$ind\"></td></tr>"
					html1=$(echo $html1 | sed "s/ src=\"\"//g")
					busca=$(echo -e $html1 | sed " s/\"/\\\\\"/g" )
					busca=$(grep -bon "$busca" index.html | wc -l)
					if [ "0$busca" -lt "1" ];then
					    ind=$(cat index.html | grep -nob "</table" | cut -d ":" -f2)
					    ind2=$(dd if=index.html bs=1 count=$ind 2>/dev/null)
					    html1="$ind2  $html1"
					    ind2=$(dd if=index.html bs=1 skip=$ind 2>/dev/null)
					    html1="$html1$ind2"
					    #echo $html1 > index.html
					else
					    echo "Ya este visor esta registtrado con esos mismos Thumbs"
					fi
				    fi
				fi
			    fi
			fi
		    fi
		done< <(echo -e "$extensiones" | sed "s/\\\\|/\"/g" | tr "\"" "\n" )
	    fi
	fi
	#echo "%% $archivo";
    done< <(echo -e $hay)
    echo "ARCHIVO"
    cp -v index.2.log index.log
fi
