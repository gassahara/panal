#!/bin/bash
mkdir palabras
mkdir temporal
if [ -z "$1" ];then
    n="./"
else
    n="$1"
fi
while read nn;do

case "$nn" in
    *htm*|*txt|*xml)
if [ -n "$nn" ];then
    echo $nn
    cat "$nn" | ./stdseparapalabras | sort -u > ll.txt
    AFS=$IFS
    IFS="\n"
    while read ll;do
	esta=""
	if [ -f "palabras/$ll" ];then
	    n3=$(echo $nn )
	    esta=$(cat "$palabras/$ll"  | ./stdbuscaarg "$n3" )
	    echo "{$esta}"
	fi
	if [ -z "$esta" ];then
	echo escribe $nn en $ll
	cat "palabras/$ll" > "temporal/$ll"
	echo -e "$nn\n$ll\n" >> "temporal/$ll"
	cat "temporal/$ll" | sort -u > "palabras/$ll"
	rm -v temporal/$ll
	fi
    done < <(cat ll.txt)
    IFS=$AFS
fi
	nn=""
        ;;
esac
done < <(./listadodirectorio.sh $n)
