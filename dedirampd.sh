#!/bin/bash
archivos=()
if [ -z $1 -o $1 -lt 1 ];then
    date2=0
while read -r -d '';do
    archivos+=("$REPLY")
    date=$(find "$REPLY" -maxdepth 0 -printf "%TY%Tm%Td%TH%TM")
    if [ $date -gt $date2 ];then
	date2=$((date+1))
    fi
done < <(find $2 -type f -newer $0 -print0)
if [ $date2 -gt 0 ];then
    touch $0 -t "$date2"
fi
else
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find $2 -type f -print0)
fi
echo "....."
visores=()
IFS="\n"
for p in "${!archivos[@]}";do
    echo "${archivos[$p]}" 
    archivo=$(./comepeliculas.sh "${archivos[$p]}" )
    if [ ! -z "$archivo" ];then
	echo -e "___/\_____\n${archivos[$p]}\n---\/-------"
	./convierteamp4.sh "${archivos[$p]}"
    fi
done
if [ -z $1 -o $1 ];then
    sleep 160
    setsid $0 $1 "$2" &
    disown 
fi
