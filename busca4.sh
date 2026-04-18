#!/bin/bash
query=$1
if [ -f "palabras3/$query" ];then
    cabeza=$(head -n1 palabras3/$query)
    tienedicreccion=0;
    esarc=0
    esdir=0
    ind=1
    while read t;do
	if [ -f "$t" ];then
	    indice=$s2
	    esarc=1;
	    s2=0
	else
	    if [ ${#t} -ge 7 ];then
		if [ "${t:1:7}" == "http://" -o "${t:1:6}" == "ftp://" ];then
		    ts=$(sed "s/ftp\:\/\///g; s/http\:\/\///g; " | sed "s/\/.*//g" )
		    nnn=$(./agarragethttp "$ts" | wc -c | tr -d " ")
		    if [ "0$nnn" -gt "0" -a "${t:1:1}" != "0" ];then
			indice=$s2
			esdir=1
			s2=0
		    fi
		fi
	    fi
	fi
	s2=$((s2-1))
    done < <(cat palabras3/$query | ./stdseparadirecciones)

    if [ $((esdir+$esarc)) -gt 0 ];then
	tienedireccion=1
    fi
    
    if [ $tienedireccion -gt 0 ];then
	while read n;do
	    i=1
		    if [ $esdir -gt 0 ];then
			t=$(echo $n | cut -d ";" -f$indice)
			./hazgethttp "$t" | grep "$query"
		    fi
		    if [ $esarc -gt 0 ];then
			t=$(echo $n | cut -d ";" -f$indice)
			echo -e "<p><a href=\"$t\"> $t </a></p>\n<p>"
			grep "$query" "$t" | dd bs=1 count=150 2>/dev/null
			echo -e "</p>\n";
		    fi
		i=$((i+1))
	done < <(cat palabras3/$query)
    fi
else
    i=0;
    while read arc;do
	nf=$(echo "$arc" | wc -c)
	nd=$((nf-1))
	while [ "$nd" -gt "1" ];do
	    fn="$arc"
	    if [ "$(echo \"$arc\" | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
		ng=$nd;
		fn=$(echo $arc | dd bs=1 count=$ng  2>/dev/null)
		break;
	    fi
	    nd=$((nd-1))
	done
	patho=$fn
	patho2=$(echo "$fn" | sed "s/\//\\\\\//g; s/\./\\\\\\./g; ")
	nombro=$(echo $arc | dd bs=1 skip=$ng  2>/dev/null)
        echo "..$nombro __ $arc"
	./busca2.sh "$nombro"
	i=$((i+1))
    done < <(find palabras3/ -maxdepth 1 -iname "*$query*")
    if [ $i -lt 1 ];then
	echo -e "\n <p> LO SIENTO, ESA PALABRA NO ESTA INDIZADA </p>\n"
    fi
fi
