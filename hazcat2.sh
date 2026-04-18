#!/bin/bash
mkdir palabras2/
mkdir temporal2
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
    cat "$nn" | ./stdseparapalabrashtml | sort -u -r > ll2.txt
    AFS=$IFS
    IFS="\n"
    while read ll;do
	nesta=$(cat "$nn"  | ./stdbuscaarg_count "$ll" )
	esta=""
	if [ -f "palabras2/$ll" ];then
	    esta=$(cat "palabras2/$ll" | ./stdbuscaarg "$nn" )
	fi
	if [ -z "$esta" ];then
	    echo escribe $nn en $ll
	    cat "palabras2/$ll" > "temporal2/$ll"
	    echo -e "$nesta;$ll;$nn" >> "temporal2/$ll"
	    cat "temporal2/$ll" | sort -u -r > "palabras2/$ll"
	    rm -v "temporal2/$ll"
	fi
    done < <(cat ll2.txt)
    IFS=$AFS
fi
	nn=""
        ;;
esac
#done < <(./listadodirectorio.sh $n)
done < <(./listadodirectorio_files $n)
