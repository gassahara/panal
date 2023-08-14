#!/usr/bin/bash
archivos=()
if [ -z $1 ];then
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find $2 -type f -newer $0 -print0)
else
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find $2 -type f -print0)
fi
echo "....."
visores=()
IFS="\n"
for p in "${!archivos[@]}";do
    archivo=$(./comepeliculas.sh "${archivos[$p]}" )
    if [ ! -z "$archivo" ];then
	echo -e "___/\_____\n${archivos[$p]}\n---\/-------"
	./convierteajpg.sh "${archivos[$p]}"
    fi
done
if [ -z $1 ];then
    sleep 600
    setsid $0 $1 $2
fi
