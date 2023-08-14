#!/bin/bash
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
pasa=0
if [ -z "$1" -o 0$1 -eq 0 ];then
    sleep 0.1
    procs=3
    nomprograma=$0
    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/" ) -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    done
    while [ 0$procs -gt 2 ];do
	procs=$(ps -A -o ";%c "|$PrPWD/stdbuscaarg_count ";$nomprograma " )
	sleep 0.1
    done
    lista=$($PrPWD/listadodirectorio_files_extension ".tx"  |$PrPWD/stdtohex |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntotxs|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
    else
	echo ...
	$PrPWD/listadodirectorio_files_extension ".tx" |$PrPWD/stdtohex > puntotxs
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    cuant=$($PrPWD/datapuntotxcdrn 0$1 | $PrPWD/stdbuscaarg_donde_hasta 0A)
    if [ 0$cuant -gt 0 ];then
	cuant=$(echo $cuant+0$1|bc)
    else
	cuant=0;
    fi
    $0 "0$cuant" &
    disown
    sleep 0.01
    fn=$($PrPWD/datapuntotxcdrn 0$1 | $PrPWD/stdcarn 0$cuant |$PrPWD/stdfromhex | $PrPWD/stdcarsin ".tx" )
    if [ -n "$fn" ];then
	sha=$(cat "$fn.tx" | sha256sum|$PrPWD/stdcarsin " " )
	shaf=$(cat procesados/*|$PrPWD/stdbuscaarg "$sha;$0;$fn;" )
	if [ -z "$shaf" ];then
    	    nomprograma=$fn
    	    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    		nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    	    done
    	    mkdir procesados
    	    echo "$sha;$0;$fn;" >> "procesados/$nomprograma"	    
	    
	    i=1
	    n=0
	    cad1=$(cat $fn.tx | $PrPWD/stdtohex)
	    estaenboundary=$(echo -n "$cad1" | $PrPWD/stdbuscaarg "3B" )
	    while [ -n "$estaenboundary" ];do
		field=$(echo "$cad1"|$PrPWD/stdcarsin "3B"|$PrPWD/stdfromhex )
		echo "$field>"
		encuentra=$(cat banco.csv |./stdbuscaarg "$field;")
		if [ -n "$encuentra" ];then
		    echo "......"
		    r=$((r+1))
		    break;
		fi
		cad1=$(echo -n "$cad1" | $PrPWD/stdcdr "3B")
		estaenboundary=$(echo -n "$cad1" | $PrPWD/stdbuscaarg "3B" )
	    done
	    echo "r=$r"
 	    if [ 0$r -eq 7 -a -n "$id" -a -n "$tx" ];then
		sha1=$(echo "$tx;$fecha;$emisor;$receptor;$monto"|sha512sum)
		echo "$tx;$fecha;$emisor;$receptor;$monto" > tx/$sha1
		sha1=$(echo "$tx;$id;$monto;$fecha"|sha512sum)
		echo "$id;$monto;$fecha" > tx/$sha1.tx
	    fi
	fi
    fi
fi

