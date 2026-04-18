#$1: directorio, $2 si se revisan solo los archivos mas nuevos que la fecha de creacion de este archivo #3 si se comaparan las imagenes $4 si se crean las imagenes 
#!/bin/bash
archivos=()
raiz="http://192.168.77.47/nube"
date2=1
if [ "$2" -eq "0" -o  -z "$2" ];then
while read -r -d '';do
    archivos+=("$REPLY")
    if [ $date -gt $date2 ];then
	date2=$((date+1))
    fi
done < <(find "$1" -type f -newer $0 -print0)
if [ $date2 -gt 1 ];then
    touch $0 -t "$date2"
fi
else
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find "$1" -type f -print0)
fi
echo "--"
listado=""
i=1
o=1
for arc in "${archivos[@]}";do
    i=$((i+1))
    menor=399015
    menos=999999
    o=1
    for erc in "${archivos[@]}";do
	o=$((o+1))
	if [ "$arc" != "$erc" ];then
	    esta=$(echo "$listado" | grep  -c "A $i B $o C")
	    asta=$(echo "$listado" | grep  -c "A $o B $i C")
	    if [ $esta -lt 1 -a $asta -lt 1 ];then
		listad="$listado A $i B $o C "
		listado="$listad"
		menos=$(compare-im6 -metric mae "$erc"  "$arc" -compose src  -alpha opaque -fuzz 20 -similarity-threshold 20% c.jpg 2>&1 \; | grep -o "(\b[^)]*" | sed "s/(//g; s/[0]\.//g; s/\-*//g; " )
		menos=$(echo $menos | grep "[1-9]" | grep -v "[0-9] [0-9]")
		if [ "0$menos" -lt "1" ];then
		    menos=999999
		fi
		
		if [ $menos -lt 299015 ];then
		    echo -e "\n\n\n\n$arc = $erc"
		    menor=$menos
		fi
	    fi
	fi
    done
done

