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
    nc=$(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/")
    while [ $nc -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
	nc=$(echo $nomprograma|$PrPWD/stdbuscaarg_donde_hasta "/")
	nc=$(echo "0$nc")
    done
    while [ 0$procs -gt 2 ];do
	procs=$(ps -au$USER  |  $PrPWD/stdbuscaarg_count " $nomprograma" )
	sleep 0.1
    done
    lista=$($PrPWD/listadodirectorio_files_extension ".in"  |$PrPWD/stdtohex |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntoins|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
    else
	echo ...
	$PrPWD/listadodirectorio_files_extension ".in" |$PrPWD/stdtohex > puntoins
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    cuant=$($PrPWD/datapuntoincdrn 0$1 | $PrPWD/stdbuscaarg_donde_hasta 0A)
    if [ 0$cuant -gt 0 ];then
	cuant=$(echo $cuant+0$1|bc)
    else
	cuant=0;
    fi
    $0 "0$cuant" &
    disown
    sleep 0.01
    fn=$($PrPWD/datapuntoincdrn 0$1 | $PrPWD/stdcarn 0$cuant |$PrPWD/stdfromhex | $PrPWD/stdcarsin ".in" )
    if [ -n "$fn" ];then
	sha=$(cat "$fn.in" | sha256sum|$PrPWD/stdcarsin " " )
	shaf=$(cat procesados/*|$PrPWD/stdbuscaarg "$sha;$0;$fn;" )
	if [ -z "$shaf" ];then
    	    nomprograma=$fn
    	    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    		nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    	    done
    	    mkdir procesados
    	    echo "$sha;$0;$fn;" >> "procesados/$nomprograma"
	    texto=$(cat "$fn.in" | $PrPWD/stdhttp | $PrPWD/stdunescape|$PrPWD/stdtohex)
	    echo "$fn "
	    if [ -n "$texto" ];then
		echo "$texto"|$PrPWD/stdfromhex
		echo "$texto"|$PrPWD/stdfromhex > "$fn.req"
	    else
		cat "$fn.in"| gpg -d --no-default-keyring --keyring ./keys.keys > "$fn.bin"
	    fi
	fi
    fi
else
    $0 &
fi
