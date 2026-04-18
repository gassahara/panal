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
    while [ 0$ps1 -gt 1 ];do
	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
	sleep 0.1
    done
    lista=$(cat $nomprograma.memoria |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntoposts|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
	$0 &
	disown
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
		if [ "$campo" = "audios" ];then
		    audios="$field"
		    r=$((r+1))
		fi
		if [ "$campo" = "previsualizar" ];then
		    previs="$field"
		    r=$((r+1))
		fi
		cad1=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof")
		estaenboundary=$(echo -n "$cad1" | $PrPWD/stdbuscaarg "$campof" )
		i=$((i+1))
	    done
	    echo "r=$r"
 	    if [ 0$r -eq 2 -a -n "$audios" ];then
		if [ "$previs" = "si" ];then
		    if [ -n "$audios" ];then
			salidap=$(echo -n "<h1>Previsualizacion Audios</h1><div id='audio01'></div><table><tr><td colspan=20><audio controls id='audioprevplay' style='width:0%;'></audio></td></tr>" | $PrPWD/stdtohex)
			salidah="$salidah $salidap"
			PrPWDHEX=$(echo -n "$PrPWD/" |$PrPWD/stdtohex)
			while [ $(echo "$audios" | $PrPWD/stdbuscaarg_count "&") -gt 0 ];do
			    v=$(echo "$audios" | $PrPWD/stdcarsin "&" | $PrPWD/stdtohex )
			    audios=$(echo "$audios" | $PrPWD/stdcdr "&" )
			    t2=$(echo "$v" | $PrPWD/stdbuscaarg "2F")
			    namo="$v"
			    while [ -n "$t2" ];do
				namo=$(echo "$namo" | $PrPWD/stdcdr "2F")
				t2=$(echo "$namo" | $PrPWD/stdbuscaarg "2F")
			    done
			    namd=$(echo "$v" | $PrPWD/stdcarsin "$namo" )
			    namo=$(echo "$namo"  | $PrPWD/stdfromhex)
			    namd=$(echo "$namd"  | $PrPWD/stdfromhex)
			    ffmpeg -threads 2 -loglevel 32 -i "$PrPWD/$namd$namo" "$PrPWD/$namd$namo-prevaudio.m4a" -y 2>&1
			    mv -v "$PrPWD/$namd$namo-prevaudio.m4a" "$PrPWD/$namd$namo-prevaudio"
			    id1=$(echo "$namd$namo"  | sha256sum | $PrPWD/stdcarsin " " )
			    v="$namo"
			    listac=$(echo -n "document.getElementById('$id1').selected=true; document.getElementById('addaudbutton').hidden=false;; document.getElementById('audioprevplay').src='$namd/$v-prevaudio'; document.getElementById('audname').value='$namd$namo'; document.getElementById('audioprevplay').style.width='80%';" | $PrPWD/stdtohex )
			    listac=$(echo -n "22 $listac 22"  | $PrPWD/stdfromhex )
			    cad1=$(echo "if(document.getElementById('peliculas').value && document.getElementById('audname').value ) { var xhrsa = new XMLHttpRequest(); xhrsa.open('POST', document.URL); xhrsa.onreadystatechange = function() { if (xhrsa.readyState == 4 && xhrsa.status == 200) {document.getElementById('subto01').innerHTML=xhrsa.responseText;}};var sBoundaryS2 = '---------------------------' + Date.now().toString(16); xhrsa.setRequestHeader('Content-Type', 'multipart\/form-data; boundary=' + sBoundaryS2); sendstrsa='--' + sBoundaryS2 + '\r\n' + 'Content-Disposition: form-data; name=' + unescape('%22') + 'addaudio' + unescape('%22') + ';\r\n\r\n' + document.getElementById('audname').value + '\r\n' + '--' + sBoundaryS2 + '--\r\n--' + sBoundaryS2 + '\r\n' + 'Content-Disposition: form-data; name=' + unescape('%22') + 'videoaudio' + unescape('%22') + ';\r\n\r\n' + document.getElementById('peliculas').value + '\r\n' + '--' + sBoundaryS2 + '--\r\n'; xhrsa.sendAsBinary(sendstrsa);}"|$PrPWD/stdtohex)
			    cad1=$(echo "22 $cad1 22"|$PrPWD/stdfromhex) 
			    salidap=$(echo "<tr onclick=$listac ><td>$v</td><td><input hidden=true id='audname'/><input type='button' hidden=true id='addaudbutton' value='Add to Movie' onclick=$cad1 /></td></tr>" | $PrPWD/stdtohex )
			    salidah="$salidah $salidap"
			    echo "$v <$id1>"
			    echo "n $namo d $namd"
 			done
			salidap=$(echo "</table>" | $PrPWD/stdtohex )
			salidah="$salidah $salidap "
		    fi

		fi
		echo ":::: queryvideo "
		echo "$salidah" |  $PrPWD/stdfromhex > $fn.html

	    fi
	fi
    fi
fi

