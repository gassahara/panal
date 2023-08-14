#!/bin/bash
archivo="$1"
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
case "$archivo" in
    *php|*htm|*html)
	eshtml=$($patho/stdbuscatodos.sh "<HTML>" "<BODY>" "$archivo")
	if [ -n "$eshtml" ];then
	    echo "$archivo"
	fi
	;;
esac

