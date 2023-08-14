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
    lista=$(find "$PrPWD/movies" -name "*.html"|$PrPWD/stdtohex |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat peliculasmpd|sha256sum|$PrPWD/stdcarsin " " )
    doc=$(cat $PrPWD/ej1.html|sha256sum|$PrPWD/stdcarsin " " )
    dob=$(cat $PrPWD/ej1.bak|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" -a "$doc" = "$dob" -a -0$procs -eq 0 -a -f peliculasmpd ];then
	pasa=1
	$0 &
	disown
    else
	echo "..."
	cp -v $PrPWD/uD.html $PrPWD/uD.bak
	find "$PrPWD/movies" -name "*.html"|$PrPWD/stdtohex > peliculasmpd
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    lista=$(find "$PrPWD/movies" -name "*.html"|$PrPWD/stdtohex )
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
	esvisor=$(cat "$namo" | $PrPWD/strdbuscaarg "<video ")
	if [ -n "$esvisor" ];then
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
	    cd "$PaPWD"
	    lista4=$(echo -n "<div style='width:10%;height:20%;float:left;' id='$id1' onclick='$listac;uvideo();'><img src='$imag' style='height:100px;'>$namo</div>" | $PrPWD/stdtohex )
	    echo "$lista4"|$PrPWD/stdfromhex
	fi
	lista="$lista3 $lista4"
	pasa=$(echo $lista | $PrPWD/stdbuscaarg 0A )
    done
    lista2=$(echo "$lista"  | $PrPWD/stdfromhex )
    echo "___________________"
    if [ -n "$lista2" ];then
	listav=" Videos <hr> <div id='directoriov' style='width:100%;'></div> <div name='videos' id='videos' style='width:100%;' >$lista2</select><br><input id='peliculasvalue' hidden=true/> <input type='button' value='Previsualizar' onclick='uvideo();'/>"
    fi

    salidah=$(echo -n "$listap <table style='position:relative;width:90%;background-color:lightgreen;'><tr><td style='width:100%;'>$listav</td></tr><tr><td style='width:100%;'>$listau</td></tr><tr><td style='width:100%;'>$listas</td></tr></table>" | $PrPWD/stdtohex)
    echo ":::: queryvideo"
    cat $PrPWD/uD.html | $PrPWD/stdcarsin "<!-- CORTAR -->" > $PrPWD/uD2.html
    echo "$salidah" |  $PrPWD/stdfromhex >> $PrPWD/uD2.html
    cat $PrPWD/uD.html | $PrPWD/stdcdr "<!-- CORTAR -->" >> $PrPWD/uD2.html
    cp -v $PrPWD/uD2.html $PrPWD/movies/uD3.html
    $0 &
    disown
fi
