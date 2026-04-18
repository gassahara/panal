#!/bin/bash
nolleva=0
if [ "$#" -gt "1" ];then
    entradas=("$@")
else
    entradas=()
    a=$#
    while read line;do
	entradas[$a]=$line
	a=$((a+1))
    done
    echo $a
fi
if [ ${#entradas[@]} -eq 2 ];then
    if [ -f "${entradas[0]}" ];then
	archivo="${entradas[0]}"
	nolleva=0
    else
	if [ -f "${entradas[1]}" ];then
	    archivo="${entradas[1]}"
	    nolleva=1
	fi
    fi
fi

if [ ${#entradas[@]} -gt 2 ];then
    for entrada in "${!entradas[@]}";do
	if [ -f "${entradas[$entrada]}" ];then
	    archivo="${entradas[entrada]}"
	    nolleva=$entrada
	    break;
	fi
    done
fi
a=0;
d=""
if [ ! -z "$archivo" ];then
    for cadena in "${!entradas[@]}"
    do
	if [ $cadena -ne $nolleva ]
	then
	    b=`pdftotext -q "$archivo" -  | grep -in -H --label="$archivo" "${entradas[$cadena]}"`
	    d="$b\n$d"
	    if [ -z "$b" ]
	    then
		exit 1;
		break
	    fi
	fi
    done
    echo $archivo
    exit 0
fi
