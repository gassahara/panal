#!/bin/bash
archivo="$1"
case "$archivo" in
    *php|*htm|*html)
	visor=$(grep -oe "<video"  "$archivo" | wc -l  | sed "s/[[:space:]]\{2,\}/ /g" | cut -d " " -f2)
	if [ "0$visor" -gt "0" ];then
	    visor=$(grep -oe "<source" "$archivo" | wc -l | sed "s/[[:space:]]\{2,\}/ /g" | cut -d " " -f2)
	    if [ "0$visor" -gt "0" ]
	    then
		visor=$(grep -oe "dashjs\b[^j]*\.js"  "$archivo"  | wc -l |  sed "s/[[:space:]]\{2,\}/ /g" | cut -d " " -f2)
		if [ "0$visor" -gt "0" ]
		then
		    echo "$archivo";
		fi
	    fi
	fi;;
esac

