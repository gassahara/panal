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
    lista=$(find "$PrPWD/movies" -name "*.[svm][k4pdtr][43gvt]" |$PrPWD/stdtohex |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat multimedia|sha256sum|$PrPWD/stdcarsin " " )
    doc=$(cat $PrPWD/ej1.html|sha256sum|$PrPWD/stdcarsin " " )
    dob=$(cat $PrPWD/ej1.bak|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" -a "$doc" = "$dob" -a -0$procs -eq 0 -a -f multimedia ];then
	pasa=1
	$0 &
	disown
    else
	echo "..."
	cp -v $PrPWD/ej1.html $PrPWD/ej1.bak
	find "$PrPWD/movies" -name "*.[svm][k4pdtr][43gvt]" |$PrPWD/stdtohex > multimedia
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    find "$PrPWD/movies" -name  "*.mpd"
    lista=$(find "$PrPWD/movies" -name "*.mpd" | grep -v "/240-\|/320-\|/480-\|/720-\|" | $PrPWD/stdtohex )
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
	listac=$(echo -n 'document.getElementById("directoriop").innerHTML=' | $PrPWD/stdtohex )
	listac=$(echo -n "$listac 22 $namd 22"  | $PrPWD/stdfromhex )
	namd=$(echo "$namd" | $PrPWD/stdfromhex)
	namo=$(echo "$namo" | $PrPWD/stdfromhex)
	id1=$(echo "$namd$namo" | sha256sum | $PrPWD/stdcarsin " ")
	lista4=$(echo -n "<option value='$namd$namo' id='$id1' onclick='$listac'>$namo</option>" | $PrPWD/stdtohex )
	lista="$lista3 $lista4"
	pasa=$(echo $lista | $PrPWD/stdbuscaarg 0A )
    done
    lista2=$(echo "$lista"  | $PrPWD/stdfromhex )
    echo "___________________"
    if [ -n "$lista2" ];then
	listap=" <table style='width:100%;'><tr><td colspan=3>Peliculas </td></tr><tr><td> <div id='directoriop'></div> <select multiple id='peliculas' name='peliculas' style='width:100%;' >$lista2</select><br><br><input type='button' value='Previsualizar' onclick='prevvideo()'/>"
    fi

    find "$PrPWD/movies" -name  "*.[om][kpg][4gv]"
    lista=$(find "$PrPWD/movies" -name "*.[om][kpg][4gv]" | grep -v "segmento-\|segmento_\|init_\|init\-" | $PrPWD/stdtohex )
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
	enproceso=$(ps -e -o "%P;%p;%c;%a" | $PrPWD/stdcdrcon "ffmpeg" | $PrPWD/stdcar "$namo" | $PrPWD/stdtohex )
	if [ -n "$enproceso" -a $(echo "$enproceso" | $PrPWD/stdbuscaarg_count "0A" ) -lt 1 ];then
	    lista4=$(echo -n "<option value='$namd$namo' id='$id1' onclick='$listac'>$namo (Procesando )</option>" | $PrPWD/stdtohex )
	else
	    lista4=$(echo -n "<option value='$namd$namo' id='$id1' onclick='$listac'>$namo</option>" | $PrPWD/stdtohex )
	fi
	lista="$lista3 $lista4"
	pasa=$(echo $lista | $PrPWD/stdbuscaarg 0A )
    done
    lista2=$(echo "$lista"  | $PrPWD/stdfromhex )
    echo "___________________"
    if [ -n "$lista2" ];then
	listav=" Videos <hr> <div id='directoriov' style='width:100%;'></div> <select multiple name='videos' id='videos' style='width:100%;' >$lista2</select><br><input type='button' value='Previsualizar' onclick='prevvideo()'/>"
    fi

    lista=$(find "$PrPWD/movies" -name "*.[aom][cp4][ca3]" |grep -v "segmento-\|segmento_\|init_\|init\-" |$PrPWD/stdtohex )
    t1=$(echo "$lista" | $PrPWD/stdbuscaarg 0A )
    pasa=$(echo -n $lista | $PrPWD/stdbuscaarg 0A )
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
	listac=$(echo -n 'document.getElementById("directorioa").innerHTML=' | $PrPWD/stdtohex )
	listac=$(echo -n "$listac 22 $namd 22"  | $PrPWD/stdfromhex )
	namd=$(echo "$namd" | $PrPWD/stdfromhex)
	namo=$(echo "$namo" | $PrPWD/stdfromhex)
	id1=$(echo "$namd$namo" | sha256sum | $PrPWD/stdcarsin " ")
	lista4=$(echo -n "<option value='$namd$namo' onclick='$listac' id='$id1' >$namo</option>" | $PrPWD/stdtohex )
	lista="$lista3 $lista4"
	pasa=$(echo $lista | $PrPWD/stdbuscaarg 0A )
    done
    lista2=$(echo "$lista"  | $PrPWD/stdfromhex )
    echo "___________________ $lista2"
    if [ -n "$lista2" ];then
	listau=" Audios <hr> <div id='directorioa' style='width:100%;'></div> <select multiple name='audios' id='audios' style='width:100%;'>$lista2</select>><br><input type='button' value='Previsualizar' onclick='prevaudio();' />"
    fi
    
    lista=$(find "$PrPWD/movies" -name "*.[sv][rt][t]"  | $PrPWD/stdtohex )
    t1=$(echo "$lista" | $PrPWD/stdbuscaarg 0A )
    pasa=$(echo -n $lista | $PrPWD/stdbuscaarg 0A )
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
	listac=$(echo -n 'document.getElementById("directorios").innerHTML=' | $PrPWD/stdtohex )
	listac=$(echo -n "$listac 22 $namd 22"  | $PrPWD/stdfromhex )
	namd=$(echo "$namd" | $PrPWD/stdfromhex)
	namo=$(echo "$namo" | $PrPWD/stdfromhex)
	id1=$(echo "$namd$namo" | sha256sum | $PrPWD/stdcarsin " ")
	lista4=$(echo -n "<option value='$namd$namo' onclick='$listac' id='$id1' >$namo</option>" | $PrPWD/stdtohex )
	lista="$lista3 $lista4"
	pasa=$(echo $lista | $PrPWD/stdbuscaarg 0A )
    done
    lista2=$(echo "$lista"  | $PrPWD/stdfromhex )
    echo "___________________"
    if [ -n "$lista2" ];then
	listas=" Subtitulos <hr> <div id='directorios' style='width:100%;'></div> <select multiple name='subtitulos' id='subtitulos' style='width:100%;'>$lista2</select><br><input type='button' value='Previsualizar' onclick='prevsubt()' />"
    fi
    salidah=$(echo -n "$listap <table style='position:relative;width:90%;background-color:lightgreen;'><tr><td style='width:100%;'>$listav</td></tr><tr><td style='width:100%;'>$listau</td></tr><tr><td style='width:100%;'>$listas</td></tr></table>" | $PrPWD/stdtohex)
    echo ":::: queryvideo"
    cat $PrPWD/ej1.html | $PrPWD/stdcarsin "<!-- CORTAR -->" > $PrPWD/ej2.html
    echo "$salidah" |  $PrPWD/stdfromhex >> $PrPWD/ej2.html
    cat $PrPWD/ej1.html | $PrPWD/stdcdr "<!-- CORTAR -->" >> $PrPWD/ej2.html
    cp -v $PrPWD/ej2.html $PrPWD/ej3.html
    $0 &
    disown
fi
