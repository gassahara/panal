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
    exit
    sleep 0.1
    ps1=3
    nomprograma=$0
    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/" ) -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    done
    while [ 0$ps1 -gt 2 ];do
	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
	sleep 0.1
    done
    lista=$(cat $nomprograma.memoria |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntoreqs|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
    else
	echo ...
	cp -v puntoreqs $nomprograma.memoria
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    cuant=$($PrPWD/datapuntoreqcdrn 0$1 | $PrPWD/stdbuscaarg_donde_hasta 0A)
    if [ 0$cuant -gt 0 ];then
	cuant=$(echo $cuant+0$1|bc)
    else
	cuant=0;
    fi
    $0 "0$cuant" &
    disown
    sleep 0.01
    fn=$($PrPWD/datapuntoreqcdrn 0$1 | $PrPWD/stdcarn 0$cuant |$PrPWD/stdfromhex | $PrPWD/stdcarsin ".req" )
    pn=$(echo $fn | $PrPWD/stdcdr "$PaPWD/")
    if [ -n "$fn" ];then
	sha=$(cat "$fn.req" | sha256sum|$PrPWD/stdcarsin " ")
	shaf=$(cat procesados/*|$PrPWD/stdbuscaarg "$sha;$0;$fn;")
	if [ -z "$shaf" ];then
    	    nomprograma=$fn
    	    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/") -gt 0 ];do
    		nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    	    done
    	    mkdir procesados
    	    echo "$sha;$0;$fn;" >> "procesados/$nomprograma"
	    reit=$(cat "$fn.req"|$PrPWD/stdhttpgetfileimagenescomprueba )
	    if [ -n "$reit" ];then
		cd "$PrPWD"
		cat "$fn.req" | ./stdhttpgetfileimagenes > "$fn.oun"
		cd "$PaPWD"
		mv -v "$fn.oun" "$fn.out"
		pss=1
		while [ -f "$pn.out" -a -n "$pss" ];do
		    sleep 0.05
		    campo=1
		    echo -n "$pss "|$PrPWD/stdfromhex
		    pss=$(ps -A --no-headers -o "%p" | $PrPWD/stdcdrcon $pn|$PrPWD/stdtohex|$PrPWD/stdcarsin 0A)
		done
		echo "<$pn I >"
		kill $pn
		mkdir peticiones
		mv $fn.in peticiones/
		mv $fn.req peticiones/
		mv procesados/$nomprograma peticiones/
	    fi
	fi
    fi
else
    $0 &
fi

