#!/bin/bash
echo "" >> comedocs.log
if [ ! -e "index.html" ];then
    rm comedocs.log
    touch comedocs.log
fi
indexa=$(find . -type f -exec stat --format=%n\&%s\&%z '{}' \; > comedocs.2.log);
hay=$(diff -y --left-column --suppress-common-lines comedocs.log comedocs.2.log | grep -v "=\|index\.log" | tr "\n" "\"" | sed "s/\"/\\\n/g")
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
	    archivo=$(echo "$archivo" | sed "s/ /\\\ /g")
	    if [ -f "$archivo" ];then
		erchivo=$(./esodoc.sh "$archivo" )
		if [ ! -z "$erchivo" ];then
		    dirsalida=$(echo "$archivo convertido" | tr " " "_")
		    mkdir "$dirsalida"
		    ./convdocx.sh "$archivo" "$dirsalida" "$archivo.html"
		    echo "./convdocx.sh \"$archivo\" \"$dirsalida\" \"$archivo.html\"" >> $archivo.comedocs.log
		fi
	    fi
	fi
	#echo "%% $archivo";
    done< <(echo -e $hay)
    echo "ARCHIVO"
    cp -v comedocs.2.log comedocs.log
fi
