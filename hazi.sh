#!/bin/bash

archivos=()
if [ -z $1 ];then
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find peliculas/ -iname "*.html" -type f -newer $0 -print0)
else
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find peliculas/  -iname "*.html" -type f -print0)
fi

visores=()
IFS="\n"
for p in "${!archivos[@]}";do
    esvisor=$(grep "<video" "${archivos[$p]}")
    if [ -n "$esvisor" ]; then
	esvisor=$(grep "<source" "${archivos[$p]}")
	if [ -n "$esvisor" ]; then
	    echo %% $esvisor %%%%%
	    visores[$p]="${archivos[$p]}"
	fi
    fi
done
p=1
for p in "${!visores[@]}";do
    nombre=$(echo "${peliculas[$p]}" | sed "s/\.webm\|\.mp4//g")
    encuentra=$(grep "\"${visores[$p]}\">" index.html)
    echo $encuentra
    if [ -z "$encuentra" ];then
	linea=$(grep -n "id=\"inner\"" index.html |  cut -d ":" -f1)
	if [ -n "$linea" ];then
	    cabeza=$(head -n$linea index.html);
	    cuantail=$(wc -l "index.html" | cut -d " " -f1)
	    cuantail=$((cuantail - $linea))
	    taill=$(tail -n$cuantail "index.html");
	    nf=$(echo ${visores[$p]} | wc -c)
	    nd=$((nf-1))
	    while [ "$nd" -gt "1" ];do
		fn=${visores[$p]}
		if [ "$(echo ${visores[$p]} | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
		    ng=$nd;		
		    fn=$(echo "${visores[$p]}" | dd bs=1 skip=$((ng+1))  2>/dev/null)
		    break;
		fi
		nd=$((nd-1))
	    done
	    patho=$fn
	    inserto="<div><a href=\"${visores[$p]}\">$patho</a></div>"
	    echo -e "$cabeza\n$inserto$taill" > index.html
	    echo $patho
	fi
    fi
done
touch $0
#setsid $0 &

