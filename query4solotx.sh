#!/bin/bash
fn=""
cuant=$(echo "0$1+1" | bc)
PrPWD=$PWD
while [ ! -f stdcdr ];do
    cd ..
done
PaPWD=$PWD
sleep 1
cadena=$(echo ".post" | ./stdtohex)
nomprograma=$0
while [ $(echo $nomprograma | ./stdbuscaarg_count "/") -gt 0 ];do
    nomprograma=$(echo $nomprograma | ./stdcdr "/" )
done
if [ ! -f $PrPWD/$nomprograma.memoria ];then
    cd $PrPWD
    $PaPWD/listadodirectorio_files  | $PaPWD/stdtohex > $nomprograma.memoria
    cd $PaPWD
fi
if [ ! -f $PrPWD/$nomprograma.procesados ];then
    touch $PrPWD/$nomprograma.procesados
fi
cuant=$(echo "0$1+1" | bc)
if [ $cuant -le $(cat $PrPWD/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" ) ];then
    sleep 0.3
    cat $PrPWD/$nomprograma.memoria |  $0 $cuant &
else
    sleep 0.3
    cd data
    l1=$(../listadodirectorio_files | ../stdtohex )
    cd ..
    m1=$(cat $PrPWD/$nomprograma.memoria )
    if [ "$l1" != "$m1" ];then
	echo "!"
	echo -n "$l1" > $PrPWD/$nomprograma.memoria
	echo -n "" > $PrPWD/$nomprograma.procesados
	echo -n "$l1" | $0 0 &
	exit
    else
	cuant=$(cat $PrPWD/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" )
	cuant=$(echo "0$cuant+1" | bc)
	echo -n "$l1" | $0 $cuant &
	exit
    fi
fi
cuant=0$1
if [ $cuant -le $(cat $PrPWD/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" ) ];then
    cadt=$(cat)
    cad=$(echo "$cadt " | ./stdbuscaarg "$cadena" )
    if [ -n "$cad" ];then
	cad=$(echo -n "$cadt" | ./stdbuscaarg_donde "$cadena" )
	while [ 0$cuant -gt 0 ];do
	    cuant2=$(echo -n $cad | ./stdcarsin " " )
	    cad=$(echo -n $cad | ./stdcdr " " )
	    cuant=$(echo "0$cuant-1" | bc)
	done
	cad=$(echo -n "$cadt" | ./stdcdrn 0$cuant2 | ./stdcarsin "$cadena" )
	cadt=""
	cuant=$(echo -n "$cad" | ./stdbuscaarg_donde 0A )
	cadt=$(echo -n "$cad" | ./stdbuscaarg_count 0A )
	while [ 0$cadt -gt 1 ];do
	    cuant=$(echo -n $cuant | ./stdcdr " ")
	    cadt=$((cadt-1))
	done
	cuant=$(echo $cuant | ./stdcar " ")
	cadt=$(echo -n "$cad" | ./stdcdrn 0$cuant )
	fn=$(echo $cadt | ./stdfromhex)
	if [ -n "$fn" ];then
	    cad=$(cat data/$nomprograma.procesados | ./stdbuscaarg ":$fn;" )
	    if [ -z "$cad"  ];then
		campof=$(cat $fn.post | ./stdhttpcontent | ./stdcdr "boundary=" | ./stdcarsin $'\r' )
		cadena="./stdcdr \"$campof\" "
		estaenboundary=$(cat $fn.post | eval $cadena  | ./stdbuscaarg "$campof" )
		echo "<$campof> $estaenboundary "
		i=1
		n=0
		while [ -n "$estaenboundary" ];do
		    cadena="$cadena | ./stdcdr \"$campof\" "
		    campo=$(cat $fn.post | eval $cadena | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdtohex | ./stdcar "0D 0A 0D 0A" | ./stdcdr "name=\"" | ./stdcarsin $'"' )
		    con=$( cat $fn.post | eval $cadena | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdtohex | ./stdcar "0D 0A 0D 0A"  | ./stdcdr "Content-Disposition: " | ./stdcarsin ";")
		    if [ -n "$campo" ];then
			r=$((r+1))
		    fi		    
		    if [ "$campo" = "tx" ];then
			n=$((n+1))
			tx_data=$(cat $fn.post | eval $cadena | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdtohex | ./stdcdr "0D 0A 0D 0A" | ./stdcarsin "0D"  | ./stdcarsin "0A" | ./stddelcar " ")
		    fi
		    estaenboundary=$(cat $fn | eval $cadena  | ./stdbuscaarg "$campof" )
		    echo ">->->- $i $campo"
		done
		if [ 0$n -eq 1 -a 0$r -eq 1 ];then
		    echo "!!!!!!!! $address"
		    m=$(stat -c %s datas/C1)
		    l=$(printf "%0x6X" $m)
		    d=$(date +%M%S%N | ./stdcarn 6 | ./stdtohex | ./stddelcar " " )
		    h=$(dd if=/dev/urandom bs=1 count=3 | ./stdtohex  | ./stddelcar " " )
		    identificador="$l$d$h"
		    echo "echo \"$identificador\" " > "$identificador.tx"
		    echo "dataC1cdrn $m | ./stdcdr \"$identificador\" | ./stdcdrcon \"$identificador\" | ./stdllaves " > "$identificador.rx"
		    cp -v "$identificador.rx" "$fn.html"
		    echo $tx_data | ./stdfromex >> "$identificador.tx"
		fi
	    fi
	fi
    fi
fi
