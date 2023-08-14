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
    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta "/" ) -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    done
    while [ 0$ps1 -gt 2 ];do
	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
	sleep 0.1
    done
    lista=$(cat $nomprograma.memoria |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntoposts|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
    else
	echo "..."
	cp -v puntoposts $nomprograma.memoria
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    cuant=$($PrPWD/datapuntopostcdrn 0$1 | $PrPWD/stdbuscaarg_donde_hasta 0A)
    if [ 0$cuant -gt 0 ];then
	cuant=$(echo $cuant+0$1|bc)
    else
	cuant=0;
    fi
    $0 "0$cuant" &
    echo "______________"
    disown
    sleep 0.1
    fn=$($PrPWD/datapuntopostcdrn 0$1 | $PrPWD/stdcarn 0$cuant |$PrPWD/stdfromhex | $PrPWD/stdcarsin ".in" )
    if [ -n "$fn" ];then
	echo "0 $cuant $fn"
 	sha=$(cat "$fn.in" | sha256sum|$PrPWD/stdcarsin " " )
	shaf=$(cat procesados/*|$PrPWD/stdbuscaarg "$sha;$0;$fn;" )
	if [ -z "$shaf" ];then
    	    nomprograma=$fn
    	    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    		nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    	    done
    	    mkdir procesados
    	    echo "$sha;$0;$fn;" >> "procesados/$nomprograma"
	    
	    

            campof=$(cat $fn.in |$PrPWD/stdhttpcontent |$PrPWD/stdcdr "boundary=" | $PrPWD/stdtohex | $PrPWD/stdcarsin 0A )
	    campog=$(echo -n "$campof" | $PrPWD/stdfromhex)
	    dashes=$(echo -n "---" | $PrPWD/stdtohex )
	    name1=$(echo -n 'name="' | $PrPWD/stdtohex )
	    i=1
	    n=0
	    cad1=$(cat $fn.in | $PrPWD/stdtohex)
	    estaenboundary=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof"  |$PrPWD/stdbuscaarg "$campof" )
	    while [ -n "$estaenboundary" ];do
		campo=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof" |$PrPWD/stdcarsin "$campof" |$PrPWD/stdcarsin "$dashes" | $PrPWD/stdcarsin "0A 0D 0A 0D" | $PrPWD/stdcdr "$name1" | $PrPWD/stdcarsin 22 |$PrPWD/stdfromhex )
		field=$(echo "$cad1" | $PrPWD/stdcdr "$campof" |$PrPWD/stdcarsin "$campof" |$PrPWD/stdcarsin "$dashes"| $PrPWD/stdcdr "$name1" |$PrPWD/stdcdr "0A 0D 0A"  | $PrPWD/stdcarsin "0D 0A" |$PrPWD/stdfromhex )
		echo "$campo=$field>"
		if [ "$campo" = "videos" ];then
		    echo "......"
		    videos=$field
		    r=$((r+1))
		fi
		if [ "$campo" = "audios" ];then
		    audio=$field
		    r=$((r+1))
		fi
		if [ "$campo" = "subtitulos" ];then
		    subt=$field
		    r=$((r+1))
		fi
		if [ "$campo" = "prev" ];then
		    previs="$field"			
		    r=$((r+1))
		fi
		cad1=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof")
		estaenboundary=$(echo -n "$cad1" | $PrPWD/stdbuscaarg "$campof" )
		i=$((i+1))
	    done
 	    if [ 0$r -gt 3 -a "$previs" != "si" -a "$hacer" != "si" ];then
		lista=$(find "$PrPWD/movies" -name "*.m[kp][gv4]" | $PrPWD/stdtohex )
		t1=$(echo "$lista" | $PrPWD/stdbuscaarg 0A )
		pasa=$(echo -n $lista | $PrPWD/stdbuscaarg 0A )
		PrPWDHEX=$(echo -n "$PrPWD/" |$PrPWD/stdtohex)
		echo $PrPWDHEX
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
		    listav=" Videos <hr> <div id='directoriov'></div> <select multiple name='videos' style='width:100%;' >$lista2</select><br>"
		fi
		
		lista=$(find "$PrPWD/movies" -name "*.[om][g4p][ga3]" | $PrPWD/stdtohex )
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
		    lista4=$(echo -n "<option value='$namd$namo' onclick='$listac'>$namo</option>" | $PrPWD/stdtohex )
		    lista="$lista3 $lista4"
		    pasa=$(echo $lista | $PrPWD/stdbuscaarg 0A )
		done
		lista2=$(echo "$lista"  | $PrPWD/stdfromhex )
		echo "___________________"
		if [ -n "$lista2" ];then
		    listau=" Audios <hr> <div id='directorioa'></div> <select multiple name='audios' style='width:100%;'>$lista2</select><br>"
		fi

		
		lista=$(find "$PrPWD/movies" -name "*.[sv][rt]t" | $PrPWD/stdtohex )
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
		    listas=" Subtitulos <hr> <div id='directorios'></div> <select multiple name='subtitulos' style='width:100%;'>$lista2</select><br>"
		fi
		salidah=$(echo -n "<table style='position:relative;width:90%;background-color:lightgreen;'><tr><td style='width:32%;'>$listav</td><td style='width:32%;'>$listau</td><td style='width:32%;'>$listas</td></tr></table>" | $PrPWD/stdtohex)
		
		echo ":::: queryvideo "
		echo "$salidah" |  $PrPWD/stdfromhex > $fn.html
	    fi
	fi
    fi
else
    $0 &
fi
