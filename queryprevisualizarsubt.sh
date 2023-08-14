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
    echo "______________ $cuant"
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
	    r=0
	    while [ -n "$estaenboundary" ];do
		campo=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof" |$PrPWD/stdcarsin "$campof" |$PrPWD/stdcarsin "$dashes" | $PrPWD/stdcarsin "0A 0D 0A 0D" | $PrPWD/stdcdr "$name1" | $PrPWD/stdcarsin 22 |$PrPWD/stdfromhex )
		field=$(echo "$cad1" | $PrPWD/stdcdr "$campof" |$PrPWD/stdcarsin "$campof" |$PrPWD/stdcarsin "$dashes"| $PrPWD/stdcdr "$name1" |$PrPWD/stdcdr "0A 0D 0A"  | $PrPWD/stdcarsin "0D 0A" |$PrPWD/stdfromhex )
		echo "($campo)=$field>"
		if [ "$campo" = "subtitulos" ];then
		    echo "----"
		    subt="$field"
		    r=$(echo $r+1|bc)
		fi
		if [ "$campo" = "previsualizar" ];then
		    echo "......"
		    previs="$field"
		    r=$(echo $r+1|bc)
		fi
		cad1=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof")
		estaenboundary=$(echo -n "$cad1" | $PrPWD/stdbuscaarg "$campof" )
		i=$((i+1))
	    done
	    echo "r=$r"
 	    if [ 0$r -eq 2 -a -n "$subt" ];then
		if [ "$previs" = "si" ];then
		    if [ -n "$subt" ];then
			salidap=$(echo "<h1>Previsualizacion Subtitulos</h1><div id='subto01'></div><table style='width:90%'>" | $PrPWD/stdtohex)
			salidah="$salidah $salidap"
			while [ $(echo "$subt" | $PrPWD/stdbuscaarg_count "&") -gt 0 ];do
			    v=$(echo "$subt" | $PrPWD/stdcarsin "&" | $PrPWD/stdtohex )
			    subt=$(echo "$subt" | $PrPWD/stdcdr "&" )
			    t2=$(echo "$v" | $PrPWD/stdbuscaarg "2F")
			    namo="$v"
			    while [ -n "$t2" ];do
				namo=$(echo "$namo" | $PrPWD/stdcdr "2F")
				t2=$(echo "$namo" | $PrPWD/stdbuscaarg "2F")
			    done
			    namd=$(echo "$v" | $PrPWD/stdcarsin "$namo" )
			    namo=$(echo "$namo"  | $PrPWD/stdfromhex)
			    namd=$(echo "$namd"  | $PrPWD/stdfromhex)
			    id1=$(echo "$namd$namo" | sha256sum | $PrPWD/stdcarsin " ")
			    lista2=$(cat "$PrPWD/$namd$namo" | $PrPWD/stdtohex | $PrPWD/stddelcar 0A | $PrPWD/stddelcar 0D | $PrPWD/stdfromhex | $PrPWD/stdcarn 1000)
			    listac=$(echo -n "document.getElementById('$id1').selected=true;document.getElementById('subname').value='$namd$namo';" | $PrPWD/stdtohex )
			    listac=$(echo -n "22 $listac 22"  | $PrPWD/stdfromhex )
			    scriptohex2=$(echo "var xhrs2 = new XMLHttpRequest(); xhrs2.open('POST', document.URL); var sBoundaryS1 = '---------------------------' + Date.now().toString(16); xhrs2.setRequestHeader('Content-Type', 'multipart\/form-data; boundary=' + sBoundaryS1); sendstr='--' + sBoundaryS1 + '\r\n' + 'Content-Disposition: form-data; name=' + unescape('%22') + 'convsubt' + unescape('%22') + ';\r\n\r\n' + document.getElementById('subname').value + '\r\n' + '--' + sBoundaryS1 + '--\r\n'; xhrs2.sendAsBinary(sendstr);"|$PrPWD/stdtohex)
			    scriptohex2=$(echo "22 $scriptohex2 22"|$PrPWD/stdfromhex)
			    scriptohex4=$(echo "if(document.getElementById('peliculas').value && document.getElementById('subname').value ) { if(document.getElementById('subname').value.substring(document.getElementById('subname').value.length-4, document.getElementById('subname').value.length) == '.vtt' ) { var xhrsa = new XMLHttpRequest(); xhrsa.open('POST', document.URL); xhrsa.onreadystatechange = function() { if (xhrsa.readyState == 4 && xhrsa.status == 200) {document.getElementById('subto01').innerHTML=xhrsa.responseText;}};var sBoundaryS2 = '---------------------------' + Date.now().toString(16); xhrsa.setRequestHeader('Content-Type', 'multipart\/form-data; boundary=' + sBoundaryS2); sendstrsa='--' + sBoundaryS2 + '\r\n' + 'Content-Disposition: form-data; name=' + unescape('%22') + 'addsub' + unescape('%22') + ';\r\n\r\n' + document.getElementById('subname').value + '\r\n' + '--' + sBoundaryS2 + '--\r\n--' + sBoundaryS2 + '\r\n' + 'Content-Disposition: form-data; name=' + unescape('%22') + 'videoasub' + unescape('%22') + ';\r\n\r\n' + document.getElementById('peliculas').value + '\r\n' + '--' + sBoundaryS2 + '--\r\n'; xhrsa.sendAsBinary(sendstrsa);} else {alert('Convertir primero a vtt');}}"|$PrPWD/stdtohex)
			    scriptohex4=$(echo "22 $scriptohex4 22"|$PrPWD/stdfromhex)

			    salidap=$(echo "<tr onclick=$listac ><td>$namo</td><td>$lista2</td><td><input hidden=true id='subname'/><input type='button' id='convsubbutton' value='convertir' onclick=$scriptohex2/><input type='button' id='addsubbutton' value='Add to Movie' onclick=$scriptohex4 /></td></tr>" | $PrPWD/stdtohex )
			    scripto=""
			    salidah="$salidah $salidap"
			    echo "$v <$id1>"
			    echo "n $namo d $namd"
			done
			salidap=$(echo "</table>" | $PrPWD/stdtohex )
			salidah="$salidah $salidap"
		    fi
		fi
		echo ":::: queryvideo "
		echo "$salidah" |  $PrPWD/stdfromhex > $fn.html

	    fi
	fi
    fi
fi


