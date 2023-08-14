#!/bin/bash
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
cd "$PrPWD"
PrPWD=$PWD
cd "$PaPWD"
pasa=0
if [ -z "$1" -o 0$1 -eq 0 ];then
    sleep 1
    procs=3
    nomprograma=$0
    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/" ) -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    done
    while [ 0$procs -gt 1 ];do
	procs=$(ps -A -o ";%c "|$PrPWD/stdbuscaarg_count ";$nomprograma " )
	sleep 0.1
    done
    procs=$(ps -A -o ";%c "|$PrPWD/stdbuscaarg_donde_hasta ";ffmpeg " )
    lista=$(find "$PrPWD/documentos" -name "*.tex"|$PrPWD/stdtohex |sha256sum|$PrPWD/stdcarsin " " )
    listains=$(find "$PaPWD/" -name "*.in"|$PrPWD/stdtohex |sha256sum|$PrPWD/stdcarsin " " )
    puntotexs=$(cat documentostex|sha256sum|$PrPWD/stdcarsin " " )
    puntoins=$(cat puntoins|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$puntotexs" = "$lista" -a "$puntoins" = "$listains" -a -0$procs -eq 0 -a -f documentostex ];then
	pasa=1
	$0 &
	disown
    else
	echo "..."
	find "$PrPWD/documentos" -name "*.tex"|$PrPWD/stdtohex > documentostex
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    lista=$(find "$PrPWD/documentos" -name "*.tex"|$PrPWD/stdtohex )
    echo "$lista" | $PrPWD/stdfromhex
    t1=$(echo "$lista" | $PrPWD/stdbuscaarg 0A )
    pasa=$(echo -n "$lista" | $PrPWD/stdbuscaarg 0A )
    PrPWDHEX=$(echo -n "$PrPWD/" |$PrPWD/stdtohex)
    echo "$pasa"
    while [ -n "$pasa" ];do
	lista2=$(echo -n "$lista" | $PrPWD/stdcar 0A )
	lista3=$(echo -n "$lista" | $PrPWD/stdcdr 0A )
	namo=$(echo "$lista2" | $PrPWD/stdcdr "2F")
	t2=$(echo "$namo" | $PrPWD/stdbuscaarg "2F")
	while [ -n "$t2" ];do
	    namo=$(echo "$namo" | $PrPWD/stdcdr "2F")
	    t2=$(echo "$namo" | $PrPWD/stdbuscaarg "2F")
	done
	namd=$(echo "$lista2" | $PrPWD/stdcarsin "$namo" | $PrPWD/stdcdr "$PrPWDHEX" )
	listac=$(echo -n 'document.getElementById("directoriov").innerHTML=' | $PrPWD/stdtohex )
	listac=$(echo -n "$listac 22 $namd 22"  | $PrPWD/stdfromhex )
	namd=$(echo "$namd" | $PrPWD/stdfromhex)
	namo=$(echo "$namo" | $PrPWD/stdfromhex)
	id1=$(echo "$namd$namo" | sha256sum | $PrPWD/stdcarsin " ")
	namd=$(echo -n "$namd" | $PrPWD/stdtohex)
	namo=$(echo -n "$namo" | $PrPWD/stdtohex)
	listac=$(echo -n "$listac;document.getElementById(" | $PrPWD/stdtohex )
	lista5=$(echo -n "peliculasvalue"|$PrPWD/stdtohex )
	listac=$(echo -n "$listac 22 $lista5 22"  |$PrPWD/stdfromhex )
	listac=$(echo -n "$listac ).value=" | $PrPWD/stdtohex )
	listac=$(echo -n "$listac 22 $namd$namo 22"  | $PrPWD/stdfromhex )
	namd=$(echo "$namd"|$PrPWD/stdfromhex )
	namo=$(echo "$namo"|$PrPWD/stdfromhex )
	echo ">> $namd $namo"
	    if [ -n "$namd" ];then
		cd "$PrPWD/$namd"
		cd ..
		stdcdr="stdcdr"
		stdcdrd=""
		while [ ! -f "$stdcdrd$stdcdr" ];do
		    stdcdrd=$(echo "../$stdcdrd")
		    echo "$stdcdrd"
		done
		if [ -n "$stdcdrd" ];then
		    P2PWD=$stdcdrd
		else
		    P2PWD="./"
		fi
		echo "_____ $PrPWD"
		imag=""
		cd "$PaPWD"
		echo ":::: queryvideo"
		cat "$PrPWD/visortex.html" | $PrPWD/stdcarsin "datann" > "$PrPWD/$namo-visor.tmp"
		echo -n "$namd/$namo" >> "$PrPWD/$namo-visor.tmp"
		cat "$PrPWD/visor.html" | $PrPWD/stdcdr "datann" |$PrPWD/stdcarsin "<FORM>" >> "$PrPWD/$namo-visor.tmp"
		echo -n "" >> "$PrPWD/$namo-visor.tmp"
		cat "$namd/$namo" >> "$PrPWD/$namo-visor.tmp"
		echo -n "</TEXTAREA>" >> "$PrPWD/$namo-visor.tmp"
		cat "$PrPWD/visor.html" | $PrPWD/stdcdrcon "</FORM>" >> "$PrPWD/$namo-visor.tmp"
		cp -v "$PrPWD/$namo-visor.tmp" "$PrPWD/$namo-visor.html"
	    fi
	lista="$lista3 $lista4"
	pasa=$(echo $lista | $PrPWD/stdbuscaarg 0A )
    done
    #$0 &
    disown
fi
