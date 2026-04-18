#!/bin/bash
a=0
e="ESTAN TODOS"
d=""
while read linea;do
rompe=0;
c=""
a=0
for cadena in "$@"
do
    a=$((a+1));
    if [ "$a" -gt "1" ]
    then
	b=`echo $linea | grep -n "$cadena"`;
	if [ "${#b}" -gt "1" ]
	then
	    c="$b"
	else
	    #echo -e "$a $cadena no esta en $linea\n"
	    rompe=1
	    break;
	fi
    fi
done
if [ "$rompe" -eq "0" ];then
    d="$d\n$c"
fi
done< <(cat "$1")
if ! [ -z "$d" ];then
    echo -e "$d"
fi
exit 0



