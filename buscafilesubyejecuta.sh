#!/bin/bash
if [ -z "$1" ];then
    n="./"
else
    n="$1"
fi

while read nn;do
case "$nn" in
    *htm|*html)
if [ -n "$nn" ];then
    nombre=$(echo $nn | cut -d "_" -f1 )
    esta=$(cat $nn | ./stdbuscaarg "<td>filesub</td><td>")
    fn=0;
    if [ -n "$esta" ];then
	echo "ESTA"


    rec=$(cat "$nombre.yn" | ./stdhttpcontent)
    while [ -n "$campof" ];do
	campof=$(echo -n "$rec" | cut -d ";" -f$campo | sed "s/^ //g" | cut -d "=" -f1 )
	if [ "$campof" = "boundary" ];then
	    campof=$(echo -n "$rec" | cut -d ";" -f$campo | sed "s/^ //g" | cut -d "=" -f2 | tr -d "\r" )
	    echo "$campof"
	    break
	fi
	campo=$((campo+1))
    done
    echo $campof
    campoff=$(echo -e "$campof")
    campof2=$(echo "$campof" | sed "s/-/\\\\\\-/g")
    echo $campoff
    ff1=$(ggrep -boaw --binary-files=text "$campof2" $nombre.yn | cut -d ":" -f1 | head -n1 | tr -d "\n")
    dd bs=1 skip=$ff1 if=$nombre.yn
    echo ... $ff1
    dd bs=1 skip=$ff1 if=$nombre.yn | ./stdhttppostseparatefiles "$campoff"
    filesub=$(cat $nombre.yn | grep filesub | cut -d ";" -f3 | cut -d "\"" -f2)
    mv -v $filesub funciones/$nombre-$filesub
	
	query=$(cat $nn | grep "<td>query<" | sed "s/<td\>/;/g; s/<\/td\>/;/g " | tr "[\n\r\t]" ";" | cut -d ";" -f5)
	echo "<HTML><HEAD> <style>p, td, span { font-family: sans-serif; font-size: 12pt; }</style> </HEAD><BODY>SUBIENDO ARCHIVO></body></html>" >> $nombre.html
#	mv -v $nn $nn.log
    fi
fi
;;
esac
done < <(./listadodirectorio_files $n )
