#!/usr/bin/bash
fechaa="20000101"
horaa="00000000"
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
echo -e "PATHO: $patho \n"
dir="peliculas"
archivos=""
c=1
while [ -z "$archivos" ];do
  IFS=$'\n'
  touch -d $fechaa $0
  for d in $(find uploads -type f -newermm $0 -exec stat -c "%s@%n@%z" "{}" \; ) ; do
	irchivo=$(echo "$d" | cut -d "@" -f2 | sed "s/\.\///g")
	dd=$(echo $d | cut -d "@" -f3);
	fecha=$(echo "$dd" | cut -d " " -f1 | sed "s/\-//g")
	hora=$(echo  "$dd" | cut -d "@" -f3 | cut -d " " -f2 | tr -d ":" | tr -d ".")
	echo "$d () fecha:$fecha hora:$hora"
	if [ "$fecha" -ge "$fechaa" ];then
	    if [ "$hora" -gt "$horaa" ];then
		#echo "<<< $irchivo :: $d >>>"
   	        ffprocs=$(top -b -n 1 | grep convierteamp4 | grep -v grep | wc -l)
		while [ $ffprocs -ge 4 ];do
		    ffprocs=$(top -b -n 1 | grep convierteamp4 | grep -v grep | wc -l)
		    sleep 1
		done
echo "ffprocs $ffprocs"
		if [ $ffprocs -lt 4 ];then
		    if [ -f "$irchivo" ];then
			archivo=$(./comepeliculas.sh "$irchivo" )
			#echo %%%% $archivo
			if [ ! -z "$archivo" ];then
			    setsid ./convierteamp4.sh "$irchivo" &
			    sleep 3
			    echo -e "$ffprocs procesos $irchivo -> mp4"
			fi
		    fi
		fi
		if [ $fecha -ge $fechaam ];then
		    if [ $hora -gt $horaam ];then
			fechaam=$fecha
			horaam=$hora
			#echo "ACTUALIZO $fechaam $horaam"
		    fi
		fi
	    fi
	fi
    done
    sleep 1
done
w=$(wc -l $0 | sed -e "s/[[:space:]]\{2,\}/ /g" | cut -d " " -f1)
wc -l $0 | sed -e "s/[[:space:]]\{2,\}/ /g" |  cut -d " " -f1
echo $w
#archivos=""
warchivos=1
lineas=()
while [ "$w" -ge "$warchivos" ];do
    linea[$warchivos]=$(cat $0 | head -n$warchivos | tail -n1)
    if [ "$warchivos" -eq "2" -o "$warchivos" -eq "3" ];then
	linea[$warchivos]=$(cat $0 | head -n$warchivos | tail -n1 | sed "s/fechaa=\"[0-9]*/fechaa=\"$fechaam/g; s/horaa=\"[0-9]*/horaa=\"$horaam/g;" )
	echo .. $fechaam
	cat $0 | head -n$warchivos | tail -n1 | sed "s/fechaa=\"[0-9]*/fechaa=\"$fechaam/g; s/horaa=\"[0-9]*/horaa=\"$horaam/g;"
    fi
    warchivos=$((warchivos+1))
done
#echo "${linea[@]}"
#archivos=$(echo "$archivos \n")
#printf '%s\n' "${linea[@]}"
printf '%s\n' "${linea[@]}" > $0
#setsid $0 &
