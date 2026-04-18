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
    sleep 0.05
    ps1=3
    nomprograma=$0
    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/" ) -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    done
    while [ 0$ps1 -gt 4 ];do
	ps1=$(ps -A -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
	sleep 0.02
    done
    lista=$($PrPWD/listadodirectorio_files_extension ".bin"  |$PrPWD/stdtohex |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntobins|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
	$0 &
	disown
    else
	echo ...
	$PrPWD/listadodirectorio_files_extension ".bin" |$PrPWD/stdtohex > puntobins
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    cuant=$($PrPWD/datapuntobincdrn 0$1 | $PrPWD/stdbuscaarg_donde_hasta 0A)
    if [ 0$cuant -gt 0 ];then
	cuant=$(echo $cuant+0$1|bc)
    else
	cuant=0;
    fi
    $0 "0$cuant" &
    disown
    sleep 0.1
    fn=$($PrPWD/datapuntobincdrn 0$1 | $PrPWD/stdcarn 0$cuant |$PrPWD/stdfromhex | $PrPWD/stdcarsin ".bin" )
    pn=$(echo $fn | $PrPWD/stdcdr "$PaPWD/")
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

	    cat "$fn.bin"|$PrPWD/stddelcarhasta0a "#"|$PrPWD/stddelcar "fwrite"|$PrPWD/stddelcar "../"|$PrPWD/stddelcar "\"/" > $fn-iii.c
	    #cat "$fn.bin"|$PrPWD/stddelcar "PATH"|$PrPWD/stddelcar "cd "|$PrPWD/stddelcar ".."|$PrPWD/stddelcar " /" > $fn.bbn
	    #echo "export PATH='';"> $fn-ii.bbn
	    echo "23696E636C756465203C737464696F2E683E0A23696E636C756465203C737464696E742E683E0A23696E636C756465203C737472696E672E683E0A23696E636C756465203C7374646C69622E683E0A23696E636C756465203C6D6174682E683E0A0A" |$PrPWD/stdfromhex > $fn-ii.c
	    cat $fn-ii.c $fn-iii.c > $fn.c
	    #$fn.sh > $fn.out
	    gcc "$fn.c" -o "$fn-bin" -lm
	    ./$fn-bin > $fn.out
	    pss="A"
	    while [ -f "$pn.out" -a "$pss" != "Z" -a -n "$pss" ];do
		sleep 0.05
		echo -n "($pss)"
		pss=$(ps -A --no-headers -o "pid,state,command" | $PrPWD/stdcdr "$pn "|$PrPWD/stdcarsin " ")
	    done
	    mkdir peticiones
	    mv $fn.in peticiones/
	    mv $fn.bin peticiones/
	    mv procesados/$nomprograma peticiones/
	    echo "%%%%%%%%%"
	    exit
	fi
    fi
fi
