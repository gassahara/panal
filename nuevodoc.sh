#!/bin/bash
fechaa="0000000000"
horaa="000000"
fechaam=$fechaa
horaam=$horaa

echo ">>$0<<<"
nf=$(echo $0 | wc -c)
nd=$((nf-1))
while [ "$nd" -gt "1" ];do
    fn=$0
    if [ "$(echo $0 | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
	ng=$nd;
	fn=$(echo $0 | dd bs=1 count=$ng  2>/dev/null)
    fi
    nd=$((nd-1))
done
patho=$fn

dir="peliculas"
archivos=""
c=1
while [ -z "$archivos" ];do
while read d
do
    dd=$(echo $d | cut -d "&" -f3);
    fecha=$(echo "$dd" | cut -d " " -f1 | sed "s/\-//g")
    hora=$(echo  "$dd" | cut -d "&" -f3 | cut -d " " -f2 | tr -d ":" | tr -d ".")
    if [ "$fecha" -ge "$fechaa" ];then
	if [ "$hora" -gt "$horaa" ];then
	    if [ -f "$erchivo" ];then
		archivo=$(./comepeliculas.sh "$erchivo" )
		if [ ! -z "$archivo" ];then
		    errores="....."
		    if [ -f "$archivo" ];then
			erchivo=$($patho/eshtml.sh "$archivo" )
			echo "$erchivo $archivo"
			if [ -n "$erchivo" ];then
			    echo ">>>>> $erchivo"
			fi
		    fi
		    if [ $fecha -ge $fechaam ];then
			if [ $hora -gt $horaam ];then
			    fechaam=$fecha
			    horaam=$hora
			    echo "ACTUALIZO $fechaam $horaam"
			fi
		    fi
		fi
	    fi
	fi
    fi
done< <(find . -type f  -exec stat -f "%N&%z&%Sm&;;;" -t "%d%m%Y %R.%S" "{}" \; )

