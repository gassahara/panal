#!/bin/bash
nolleva=0
while read line;do
    entradas[$a]=$line
    a=$((a+1))
done
echo $a

for cadena in "${entradas[@]}"
do
    pdftotext -q "$cadena" -  | grep -in -H --label="$cadena" "$1"
done
exit 0

