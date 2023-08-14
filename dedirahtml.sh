#!/bin/bash

#ROOT=/tmp/test
HTTP="/"
#OUTPUT="_includes/site-index.html" 
echo "<HTML><BODY>"
echo "<UL>" 
for filepath in `find . -maxdepth 1 -type f `; do
    path=`basename "$filepath"`
    nf=$(echo "$filepath" | wc -c)
    nd=$((nf-1))
    while [ "$nd" -gt "1" ];do
	fn="$arc"
	if [ "$(echo \"$filepath\" | dd bs=1 count=2 skip=$nd 2>/dev/null)" == "./" ];then
	    ng=$nd+1;
	    fn=$(echo $filepath | dd bs=1 count=$ng  2>/dev/null)
	    break;
	fi
	if [ "$(echo \"$filepath\" | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
	    ng=$nd;
	    fn=$(echo $filepath | dd bs=1 count=$ng  2>/dev/null)
	    break;
	fi
	nd=$((nd-1))
    done
    nombro=$(echo $filepath | dd bs=1 skip=$ng  2>/dev/null)
    filepath=$fn
    patho3=$(echo "$fn" | sed "s/\\\\\\\.\//\//g; s/\.\///g; s/\.//g")
    echo "  <UL>" 
    echo "    <LI><a href=\"$patho3$nombro\">$nombro</a></LI>" 
    echo "  </UL>" 
done
echo "</UL>" 
