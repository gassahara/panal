#!/bin/bash
fechaa="20161026"
horaa="160325672151102"
fechaam=$fechaa
horaam=$horaa
echo ">>$0<<<"
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

dir="peliculas"
archivos=""
c=1
while [ -z "$archivos" ];do
while read d
do
    dd=$(echo $d | cut -d "&" -f3);
    fecha=$(echo "$dd" | cut -d " " -f1 | sed "s/\-//g")
    hora=$(echo  "$dd" | cut -d "&" -f3 | cut -d " " -f2 | tr -d ":" | tr -d ".")
    if [ $fecha -ge $fechaa ];then
	if [ $hora -gt $horaa ];then
	    echo "$fecha > $fechaa   $hora > $horaa"
            archivos="$archivos;$d;";
	    if [ $fecha -ge $fechaam ];then
		if [ $hora -gt $horaam ];then
		    fechaam=$fecha
		    horaam=$hora
		    echo "ACTUALIZO $fechaam $horaam"
	    fi
	    fi
	fi
    fi
done< <(find . -type f -exec stat --format=%n\&%s\&%y\;\;\; '{}' \; | sed "s/\;\;\;/\\\\\n/g" )
sleep 1
done
warchivos=1
#echo -e $archivos | grep -obn "\;";
while [ ! -z "$warchivos" ]; do
    warchivos=$(echo $archivos | grep -obn "\;" | head -n1 | cut -d ":" -f2 )
    archivo=${archivos:0:$warchivos}
    archivo=$(echo $archivo | cut -d "&" -f1)
    archivos=${archivos:$(($warchivos+1))}
    while [ "${archivo:0:1}" == " " ];do
	archivo=${archivo:1:${#archivo}}
    done
    #echo "file=  $archivo"
    archivo=$(echo "$archivo" | sed "s/ /\ /g; s/\.\///g ")
    if [ -f "$archivo" ];then
	erchivo=$($patho/eshtml.sh "$archivo" )
	echo "$erchivo $archivo"
	if [ -n "$erchivo" ];then
	    echo ">>>>> $erchivo"
	    cat "$erchivo" | $patho/hazp3 5001 &
	fi 
    fi 
    SEPARADOR=$( echo "$a" | grep -o "<\|>" )
    if [ ! -z "$SEPARADOR" ];then
	b=$(echo "$a" | cut -d "$SEPARADOR" -f2  | sed "s// /g;")
	while [ "${b:0:1}" == " " ];do
            b=${b:1}
	done
	echo $b
    fi
done
echo "working"
w=$(wc -l $0 | cut -d " " -f1)
archivos=""
warchivos=1 
while [ "$w" -ge "$warchivos" ];do
    d=$(cat $0 | head -n$warchivos | tail -n1 | sed "s/fechaa=\"[0-9]*/fechaa=\"$fechaam/g; s/horaa=\"[0-9]*/horaa=\"$horaam/g;" | base64)
    warchivos=$((warchivos+1))
    archivos="$archivos $d \n"
done
archivos="$archivos \n "
rm $0
touch $0
while read d; do echo "$d" | base64 -d -i >> $0 ;done < <(echo -e "$archivos");
chmod +x $0
setsid $0 &
