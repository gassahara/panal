#!/bin/bash
salte=0
#bites=$(wc -c $1.yn | sed "s/\(^ \{1,\}\)//g"  | cut -d " " -f1 )
__ln=( $( ls -Lon "$1.yn" ) )
bites=${__ln[3]}
echo "Size is: $bites bytes"
if [ $bites -gt 0 ];then
    mv "$fn.in" "$fn.ren"
    dd if=$1.ren oseek=$bites bs=1 of=$1.yn
else
    cp -v $1.in $1.yn
fi
rm -v $1.ren
#rm "$1.in" "$1.out" "$1.res" "$1.req"
