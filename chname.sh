#!/usr/bin/bash
b=$(echo "$1" | tr -d '#')
c=$(echo "$b" | tr -d '!')
b=$(echo "$c" | tr ' ' '_' )
c=$(echo "$b" | tr '&' '_' )
b=$(echo "$c" | ./stdcarsin ".txt" )
mv -v  "$1" "$b"
#mv -v "$1" "$c"

