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
    nno=$(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/" )
    while [ 0$nno -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    nno=$(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/" )
    done
    procs=3
    while [ 0$procs -gt 2 ];do
	procs=$(ps -au$USER  |  $PrPWD/stdbuscaarg_count " $nomprograma" )
	sleep 0.1
    done
    lista=$(cat $nomprograma.memoria |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntoreqs|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
	$0 &
    else
	echo ...
	cp -v puntoreqs $nomprograma.memoria
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    $PrPWD/datapuntoreqcdrn 0$1
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
	    cd "$PrPWD"
	    reit=$(cat "$fn.req" | ./stdhttpgetfilehtmlcomprueba )
	    echo "$reit" > "$fn.std"
	    cd "$PaPWD"
	    if [ -z "$reit" ];then
		cd "$PrPWD"
		reix=$(cat "$fn.req" | ./stdhttpgetfileimagenescomprueba )
		reiu=$(cat "$fn.req" | ./stdhttpgetfilepdfscomprueba )
		reit=$(echo "$reix$reiu")
		cd "$PaPWD"
		if [ -z "$reit" ];then
		    echo "BB $fn "
		    rer=$(cat "$fn.in" | $PrPWD/stdhttprange > "$fn.rer")
		    if [ -z "$rer" ];then
			cd "$PrPWD"
			cat "$fn.req" | ./stdhttpgetfileoctect > "$fn.reb"
			cd "$PaPWD"
		    else
			cd "$PrPWD"
			echo "RANGO"
			cat "$fn.req" "$fn.rer" | ./stdhttpgetfileoctect-range > "$fn.reb"
			cd "$PaPWD"
		    fi
		    reit=$(cat "$fn.reb" | $PrPWD/stdcarn 1 )
		    if [ -n "$reit" ];then
			mv -v "$fn.reb" "$fn.out"
			pss="A"
			while [ -f "$pn.out" -a "$pss" != "Z" ];do
			    sleep 0.05
			    echo -n "($pss)"
			    pss=$(ps -A --no-headers -o "pid,state,command" | $PrPWD/stdcdr "$pn "|$PrPWD/stdcarsin " ")
			done
			kill $pn
			echo "BINARIO"
			mkdir peticiones
			mv $fn.in peticiones/
			mv $fn.req peticiones/
			mv $fn.reb peticiones/
			mv $fn.rer peticiones/
			mv procesados/$nomprograma peticiones/
			exit
		    fi
		fi
		mv $fn.reb peticiones/
		mv $fn.rer peticiones/
	    fi
	fi
    fi
fi
