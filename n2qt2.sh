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
    ps1=3
    nomprograma=$0
    nc=$(echo $nomprograma|$PrPWD/stdbuscaarg_donde_hasta "/")
    while [ $nc -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
	nc=$(echo $nomprograma|$PrPWD/stdbuscaarg_donde_hasta "/")
	nc=$(echo "0$nc")
    done
    while [ 0$ps1 -gt 4 ];do
	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
	sleep 0.1
    done
    lista=$(cat $nomprograma.memoria |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntoreqs|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
	$0 &
	disown
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
    sleep 0.1
    fn=$($PrPWD/datapuntoreqcdrn 0$1 | $PrPWD/stdcarn 0$cuant |$PrPWD/stdfromhex | $PrPWD/stdcarsin ".req" )
    pn=$(echo $fn | $PrPWD/stdcdr "$PaPWD/")
    if [ -n "$fn" ];then
	echo "0 $cuant $fn"
 	sha=$(cat "$fn.req" | sha256sum|$PrPWD/stdcarsin " " )
	shaf=$(cat procesados/*|$PrPWD/stdbuscaarg "$sha;$0;$fn;" )
	if [ -z "$shaf" ];then
    	    nomprograma=$fn
    	    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    		nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    	    done
    	    mkdir procesados
    	    echo "$sha;$0;$fn;" >> "procesados/$nomprograma"
	    
	    cd $PrPWD
	    r2t=$(cat "$fn.req" | ./stdhttpgetfilehtmlcomprueba )
	    cd $PaPWD
	    cont=$(cat "$fn.in" | $PrPWD/stdhttpcontent )
	    if [ -n "$r2t" -a -z "$cont" ];then
		echo "TEXTO 2 > $1 <"
		cd $PrPWD
		cat "$fn.req" | ./stdhttpgetfilehtml > "$fn.oun"
		mv -v $fn.oun $fn.out
		cd $PaPWD
		pss="A"
		while [ -f "$pn.out" -a "$pss" != "Z" -a -n "$pss" ];do
		    sleep 0.05
		    echo -n "($pss)"
		    pss=$(ps -A --no-headers -o "pid,state,command" | $PrPWD/stdcdr "$pn "|$PrPWD/stdcarsin " ")
		done
		mkdir peticiones
		mv $fn.in peticiones/
		mv $fn.req peticiones/
		mv procesados/$nomprograma peticiones/
		echo "%%%%%%%%%"
		exit
	    fi
	fi
    fi
fi
