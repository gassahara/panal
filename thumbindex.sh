echo "" >> thumbindex.log
if [ ! -e "index.html" ];then
    rm thumbindex.log
    touch thumbindex.log
fi
sort -ru thumbindex.log > thumbindex.2.log
mv -v thumbindex.2.log  thumbindex.log
find . -type f -exec stat --format=%n\&%s\&%y '{}' \; | sort -ru > thumbindex.2.log;
archivos=""
c=1
while read d
do
    archivos="$d;$archivos"
done< <(diff --left-column --suppress-common-lines thumbindex.log thumbindex.2.log | grep "<\|>\|" | grep -v "thumbindex\.log" )
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
	archivo=$(echo "$archivo" | sed "s/ /\\\ /g; s/\.\///g")
	if [ -f "$archivo" ];then
	    echo $archivo
	    erchivo=$(./esthumbdepelicula.sh "$archivo" )
	    if [ ! -z "$erchivo" ];then
		echo -e "$archivo de $erchivo\n"
		if [ -f "$erchivo" ];then
		    if [ -e "index.html" ];then
			echo "ERCHI $erchivo"
 			SEPARADOR=$(echo ">$erchivo</a>" )
			ind2=${#SEPARADOR}
 			SEPARADOR=$(echo "$SEPARADOR" | sed "s/\./\\\\\./g; s/\//\\\\\//g; s/\"/\\\\\"/g; ")
			busca=$(grep -bon "$SEPARADOR" index.html)
			if [ ! -z "$busca" ];then
			    html1="<li><img src=\"$archivo\"></li>"
			    busca=$(grep -bon "$html1" index.html)
			    if [ -z "$busca" ];then
				ind=$(cat index.html | grep -nob "$SEPARADOR" | cut -d ":" -f2)
				SEPARADOR=$(echo -e $SEPARADOR)
				echo "<<< $SEPARADOR >>>"
				ind2=$((ind+$ind2))
				ind=$(dd if=index.html bs=1 count=$ind2 2>/dev/null)
				ind3=$(dd if=index.html bs=1 skip=$ind2 2>/dev/null)
				echo ">>> ${ind3:0:4} <<<<"
				if [ "${ind3:0:4}" == "<ul>" ];then
				    ind3=${ind3:4}
				    html1="<ul>   $html1"
				else
				    html1="<ul>   $html1</ul>"
				fi
				html1="$ind$html1$ind3"
				echo $html1
				echo $html1 > index.html
			    else
				echo "Thumb repetido"
			    fi
			else
			    echo "No encontre $SEPARADOR"			    
			fi
		    fi
		fi
	    fi
	fi
    fi
    #echo "%% $archivo";
    echo $a
    SEPARADOR=$( echo "$a" | grep -o "<\|>" )
    if [ ! -z "$SEPARADOR" ];then
	b=$(echo "$a" | cut -d "$SEPARADOR" -f2  | sed "s/\t/ /g;")
	while [ "${b:0:1}" == " " ];do
	    b=${b:1}
	done
	echo $b
	echo "$b" >> thumbindex.log
    fi
done
