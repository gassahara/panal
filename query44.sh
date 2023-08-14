#!/bin/bash
fn=""
cuant=$(echo "0$1+1" | bc)
while [ ! -f stdcdr ];do
    cd ..
done
sleep 1
cadena=$(echo ".post" | ./stdtohex)
nomprograma=$0
while [ $(echo $nomprograma | ./stdbuscaarg_count "/") -gt 0 ];do
    nomprograma=$(echo $nomprograma | ./stdcdr "/" )
done
if [ ! -f data/$nomprograma.memoria ];then
    cd data
    ../listadodirectorio_files  | ../stdtohex > $nomprograma.memoria
    cd ..
fi
if [ ! -f data/$nomprograma.procesados ];then
    touch data/$nomprograma.procesados
fi
cuant=$(echo "0$1+1" | bc)
if [ $cuant -le $(cat data/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" ) ];then
    sleep 0.3
    cat data/$nomprograma.memoria |  $0 $cuant &
else
    sleep 0.3
    cd data
    l1=$(../listadodirectorio_files | ../stdtohex )
    cd ..
    m1=$(cat data/$nomprograma.memoria )
    if [ "$l1" != "$m1" ];then
	echo "!"
	echo -n "$l1" > data/$nomprograma.memoria
	echo -n "" > data/$nomprograma.procesados
	echo -n "$l1" | $0 0 &
	exit
    else
	cuant=$(cat data/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" )
	cuant=$(echo "0$cuant+1" | bc)
	echo -n "$l1" | $0 $cuant &
	exit
    fi
fi
cuant=0$1
if [ $cuant -le $(cat data/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" ) ];then
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
		campof=$(cat $fn.post | ./stdhttpcontent | ./stdcdr "boundary=" | ./stdcarsin $'\r'  | ./stddelcar "\"" )
		if [ -z "$campof" ];then
		    con=$( cat $fn.post | ./stdcdr "Content-Type: " | ./stdcarsin $'\n' | ./stdbuscaarg_donde_hasta "form-urlencoded")
		    if [ -n "$con" ];then
			cadena=" ./stdcdrn $con | ./stdcdr $'\r\n\r\n' | ./stdcar $'\r\n\r\n' "
			i=1
			n=0
			r=0
			estaenboundary=1
			while [ -n "$estaenboundary" ];do
			    estaenboundary=$(cat $fn.post | eval $cadena  | ./stdcar "&" )
			    campo=$(cat $fn.post | eval $cadena | ./stdcarsin "=" )
			    if [ -n "$campo" ];then
				r=$((r+1))
			    fi
			    if [ 0$r -gt 1 ];then
				exit
			    fi
			    
			    if [ "$campo" = "address" ];then
				n=$((n+1))
				address=$(cat $fn.post | eval $cadena | ./stdcdr = | ./stdcar "&")
			    fi
			    if [ "$campo" = "tx" ];then
				tx=$(cat $fn.post | eval $cadena | ./stdcdr = | ./stdcar "&")
				n=$((n+1))
			    fi
			    cadena="$cadena | ./stdcdr \"&\" | ./stdcar \"&\" "
			    echo ">->->- $i <$campo><$campof> 0$n"
			    i=$((i+1))
			done
			echo "n=$n r=$r"
			if [ 0$n -gt 0 -a 0$r -gt 0 ];then
			    echo "!!!!!!!! $address"
			    l=$(stat -c %s datas/C1)
			    d=$(date +%M%S%N | ./stdcarn 5 | ./stdtohex | ./stddelcar " " )
			    echo $l$d > "$l$d.tx"
			    echo $address >> "$l$d.tx"
			    cadena=$(cat "$l$d.tx" | ./stdtohex | ./stddelcar " ")
			    echo "echo $cadena | sh interpreta.sh" > "$l$d.tx"
			    echo "./stdcdrn $l | ./stdcdr $l$d" | base64 | ./stdcarsin "=" > $fn.html
			fi
			if [ 0$n -gt 1 -a 0$r -gt 1 ];then
			    echo $l$d > "$l$d.tx"
			    echo $address >> "$l$d.tx"
			    cat $fn*.tx  >> "$l$d.tx"
			    cadena=$(cat "$l$d.tx" | ./stdtohex | ./stddelcar " ")
			    echo "echo $cadena | sh interpreta.sh " > "$l$d.tx"
			    echo "./stdcdrn $l | ./stdcdr $l$d" | base64 | ./stdcarsin "=" > $fn.html
			fi
			if [ 0$n -gt 0 -a 0$r -gt 0 ];then
			    mkdir subir
			    mv $l$d.tx subir/$l$d.tx
			fi
		    fi
		fi
	    fi
	fi
    fi
fi
