#!/bin/bash
dir="peliculas"
echo "" >> agarracomandconvdoc.log
if [ ! -e "index.html" ];then
    rm agarracomandconvdoc.log
    touch agarracomandconvdoc.log
fi
sort -ru agarracomandconvdoc.log > agarracomandconvdoc.2.log
mv -v agarracomandconvdoc.2.log  agarracomandconvdoc.log
find . -type f -exec stat --format=%n\&%s\&%y '{}' \; | sort -ru > agarracomandconvdoc.2.log;
archivos=""
c=1
while read d
do
    archivos="$d;$archivos"
done< <(diff --left-column --suppress-common-lines agarracomandconvdoc.log agarracomandconvdoc.2.log | grep "<\|>\|$dir\/" | grep -v "agarracomandconvdoc\.log" )
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
	    visor=$(./buscatodos.sh "$archivo" "convdocx.sh"  "\.docx\|\.odt" "\.html" )
	    if [ ! -z "$visor" ]
	    then
		linea=$(./buscatodosenunalinea.sh  "$archivo" "convdocx.sh"  "\.docx\|\.odt" "\.html"  | tail -n1 )
		if [ ! -z "$linea" ];then
		    echo -e "\n MIRA $archivo ES UN log de Conversion\n";
		    input1=$(echo $linea | cut -d "\"" -f2 | sed "s/\.\///g")
		    output1=$(echo $linea | cut -d "\"" -f6  | sed "s/\.\///g")
		    diroutput1=$(echo $linea | cut -d "\"" -f4  | sed "s/\.\///g")
		    visor=$(./esodoc.sh $input1);
		    echo "visor: $visor de $input1"
		    salio=0
		    if [ ! -z "$visor" ];then
			if [ -f "$diroutput1/$output1" ];then
			    echo $diroutput1/$output1;
			    desde=$(grep --color -bon "<b[ >][^<]*" $diroutput1/$output1 | cut -d ":" -f2 | tr "\n" ";" )
			    hasta1=$(grep --color -bon "</b>" $diroutput1/$output1 | cut -d ":" -f2 | tr "\n" ";" )
			    if [ ! -z "$desde" ];then
				wdesde="......"
				whasta="......"
				while [ ! -z "$wdesde" ];do
				    wdesde=$(echo $desde | grep -obn "\;" | head -n1 | cut -d ":" -f2 )
				    desdee=${desde:0:$wdesde};
				    desde=${desde:$((wdesde+1))}
				    hasta=$hasta1;
				    while [ ! -z "$whasta" ];do
					whasta=$(echo $hasta | grep -obn "\;" | head -n1 | cut -d ":" -f2 )
					hastaa=${hasta:0:$whasta};
					hasta=${hasta:$((whasta+1))}
					if [ "0$hastaa" -gt "$desdee" ];then
					    texto=$(dd if="$diroutput1/$output1" bs=1 skip=$desdee count=$(($hastaa-$desdee+4)) 2>/dev/null | sed "s/<[0-z\/][^>]*//g" | tr -d ">" )
					    break;
					fi
				    done
				    if [ "${#texto}" -gt "15" ];then
					salio=1
					break;
				    fi
				done
			    fi
			    if [ $salio -ne 1 ];then
				desde=$(grep --color -bon "<p\|<span[ >][^<]*" $diroutput1/$output1 | cut -d ":" -f2 | head -n1 )
				td=20;
				texto=""
				while [ "${#texto}" -lt "30" ];do
				    texto=$( dd if="$diroutput1/$output1" bs=1 skip=$desde count=$td 2>/dev/null | sed "s/<[0-z\/][^>]*\>//g" | tr -d "[\\>\/\?<\=\"\'")
				    td=$((td+1));
				done
			    fi
			    if [ -f "dindex.html" ];then
				html1=""
				html1="<div><p><a href=\"$diroutput1/$output1\">$input1</a><br>$texto<a href=\"$input1\">Descargar</a></p></div>"
				html1=$(echo $html1 | sed "s/ src=\"\"//g")
				busca=$(echo -e $html1 | sed " s/\"/\\\\\"/g" )
				busca=$(grep -bon "$busca" dindex.html | wc -l)
				if [ "0$busca" -lt "1" ];then
				    SEPARADOR="<div class=\"inner\">"
				    ind=$(cat dindex.html | grep -nob "$SEPARADOR" | cut -d ":" -f2)
				    ind2=$((ind+${#SEPARADOR}))
				    ind2=$(dd if=dindex.html bs=1 count=$ind 2>/dev/null)
				    html1="$ind2  $html1"
				    ind2=$(dd if=dindex.html bs=1 skip=$ind 2>/dev/null)
				    html1="$html1$ind2"
				    echo $html1
				    echo $html1 > dindex.html
				else
				    echo "Ya este visor esta registrado con esos mismos Thumbs"
				fi
			    fi
			fi
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
	echo "$b" >> agarracomandconvdoc.log
    fi
done
