#!/bin/bash
a=0
for cadena in "$@"
do
    a=$((a+1));
    if [ "$a" -gt "1" ]
    then
	b=`grep -in "$cadena" "$1"`;
	if [ -z "$b" ]
	then
	    exit 1;
	    break
	fi
    fi
done
echo "ESTAN TODOS"
exit 0



