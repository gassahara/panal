#!/bin/bash
patho="/var/www/html/nube/"
while read puerto;do
    while read d
    do
	nf=$(echo $d | wc -c)
	nd=$((nf-1))
	while [ "$nd" -gt "1" ];do
	    if [ "$(echo $d | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
		ng=$nd;
		while [ "$ng" -gt "1" ];do
		    if [ "$(echo $d | dd bs=1 count=1 skip=$ng 2>/dev/null)" == " " ];then
			break;
		    fi
		    ng=$((ng-1))
		done
		fn=$(echo $d | dd bs=1 skip=$((ng+1)) count=$((nd-$ng-1)) 2>/dev/null)
		fn=$(ps -emf | grep "$fn" | grep -v "grep " | head -n1 | sed "s/ [^0-9A-Za-z]*/ /g" | cut -d " " -f8 | sed "s/\.\///g" )
		ffn=$(find -name "$fn")
		if [ -n "$ffn" -o "$fn" == "nc" ];then
		    puerto=$(echo $d | grep -o "[0-9]\:[1-9][^ ]*"  | dd bs=1 skip=2 2>/dev/null)
		    echo "$ffn" | sed "s/$fn//g"
		fi
		break;
	    fi
	    nd=$((nd-1))
	done
    done< <(netstat -nap 2>/dev/null | grep $puerto)
done

