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
		if [ "$campo" = "videos" ];then
		    echo "......"
		    videos="$field"
		    r=$((r+1))
		fi
		if [ "$campo" = "previsualizar" ];then
		    echo "......"
		    previs="$field"
		    r=$((r+1))
		fi
		cad1=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof")
		estaenboundary=$(echo -n "$cad1" | $PrPWD/stdbuscaarg "$campof" )
		i=$((i+1))
	    done
	    echo "r=$r"
 	    if [ 0$r -eq 2 -a -n "$videos" ];then
		if [ "$previs" = "si" ];then
		    if [ -n "$videos" ];then
			scriptohex=$(echo -n "document.getElementById('convbutton').hidden=false;document.getElementById('extrbutton').hidden=false;"|$PrPWD/stdtohex)
			scriptohex=$(echo -n "22 $scriptohex 22"|$PrPWD/stdfromhex)
			scriptohex2=$(echo "var xhrconv = new XMLHttpRequest(); xhrconv.open('POST', document.URL);xhrconv.onreadystatechange = function() {if (xhrconv.readyState == 4 && xhrconv.status == 200) { document.getElementById('convtarget').innerHTML = xhrconv.responseText; } }; var sBoundary = '---------------------------' + Date.now().toString(16); xhrconv.setRequestHeader('Content-Type', 'multipart\/form-data; boundary=' + sBoundary); sendstr='--' + sBoundary + '\r\n' + 'Content-Disposition: form-data; name=' + unescape('%22') + 'convertir' + unescape('%22') + ';\r\n\r\n' + document.getElementById('videoname').value + '\r\n' + '--' + sBoundary + '--\r\n'; xhrconv.sendAsBinary(sendstr);"|$PrPWD/stdtohex)
			scriptohex2=$(echo "22 $scriptohex2 22"|$PrPWD/stdfromhex)
			salidap=$(echo -n "<h1>Previsualizacion Videos</h1><table><tr><td colspan=20><video controls id='videoprevplay' style='width:1%;' onloadeddata=$scriptohex ></video><input hidden=true id='videoname'/><input type='button' hidden=true id='convbutton' value='convertir' onclick=$scriptohex2/>" | $PrPWD/stdtohex)
			scriptohex2=$(echo "var xhrvid = new XMLHttpRequest(); xhrvid.open('POST', document.URL);xhrvid.onreadystatechange = function() {if (xhrvid.readyState == 4 && xhrvid.status == 200) { document.getElementById('convtarget').innerHTML = xhrvid.responseText; } }; var sBoundary = '---------------------------' + Date.now().toString(16); xhrvid.setRequestHeader('Content-Type', 'multipart\/form-data; boundary=' + sBoundary); sendstr='--' + sBoundary + '\r\n' + 'Content-Disposition: form-data; name=' + unescape('%22') + 'extraudio' + unescape('%22') + ';\r\n\r\n' + document.getElementById('videoname').value + '\r\n' + '--' + sBoundary + '--\r\n'; xhrvid.sendAsBinary(sendstr);"|$PrPWD/stdtohex)
			scriptohex2=$(echo "22 $scriptohex2 22"|$PrPWD/stdfromhex)
			salidaq=$(echo -n "<input type='button' hidden='true' id='extrbutton' value='Extraer Audio' onclick=$scriptohex2/></td></tr>" | $PrPWD/stdtohex)
			salidap=$(echo -n "$salidap $salidaq")
			scripto=""
			salidah="$salidah $salidap"
			PrPWDHEX=$(echo -n "$PrPWD/" |$PrPWD/stdtohex)
			while [ $(echo "$videos" | $PrPWD/stdbuscaarg_count "&") -gt 0 ];do
			    v=$(echo "$videos" | $PrPWD/stdcarsin "&" | $PrPWD/stdtohex )
			    videos=$(echo "$videos" | $PrPWD/stdcdr "&" )
			    echo "$videos ($v)"
			    t2=$(echo "$v" | $PrPWD/stdbuscaarg "2F")
			    namo="$v"
			    while [ -n "$t2" ];do
				namo=$(echo "$namo" | $PrPWD/stdcdr "2F")
				t2=$(echo "$namo" | $PrPWD/stdbuscaarg "2F")
			    done
			    namd=$(echo "$v" | $PrPWD/stdcarsin "$namo" )
			    namo=$(echo "$namo"  | $PrPWD/stdfromhex)
			    namd=$(echo "$namd"  | $PrPWD/stdfromhex)
			    enproceso=$(ps -e -o "%P;%p;%c;%a" | $PrPWD/stdcar "$namo" | $PrPWD/stdtohex )
			    while [ $(echo "$enproceso" | $PrPWD/stdbuscaarg_donde_hasta "0A") -gt 0 ];do
				enproceso=$(echo "$enproceso" | $PrPWD/stdcdr "0A" )
			    done
			    enproceso=$(echo -n "20 $enproceso" | $PrPWD/stdfromhex | $PrPWD/stdbuscaarg "ffmpeg" )
			    if [ -n "$enproceso" ];then
				echo "$enproceso"
			    else
				ta1=$(sha256sum "$PrPWD/$namd$namo" -bz| $PrPWD/stdcarsin " ")
				ta2=$(cat "$PrPWD/$namd$namo.sha")
				if [ ! -f "$PrPWD/$namd$namo.sha" -o "$ta1" != "$ta2" ];then
				    duration=$(ffprobe -v error -show_entries format=duration  -of default=noprint_wrappers=1:nokey=1 "$PrPWD/$namd$namo" 2>&1 | $PrPWD/stdcarsin "." )
				fi
				if [ ! -f "$PrPWD/$namd$namo.sha" -o "$ta1" != "$ta2" -o ! -f "$PrPWD/$namd$namo-01.jpg"  ];then
				    if [ 0$duration -gt 1500 ];then
					echo -n "HACIENDO IMAGENES ..."
					find "$PrPWD/$namd" -maxdepth 1 -name "$namo*.jpg" -exec rm -v "{}" \;
					ffmpeg -ss 00:05:00 -t 00:20:00 -threads 4 -loglevel 32 -i "$PrPWD/$namd$namo" -f image2 -vf "fps=fps=0.6,select=gt(scene\\,0.6)" -frames:v 6 -vsync vfr -y "$PrPWD/$namd$namo-%02d.jpg"
					echo ".. IMAGENES HECHAS"
				    else
					echo -n "HACIENDO IMAGENES ..."
					ffmpeg -threads 4 -loglevel 32 -i "$PrPWD/$namd$namo"  -f image2 -vf "fps=fps=1/600,select=gt(scene\\,0.3)" -frames:v 8 -vsync vfr -y "$PrPWD/$namd$namo-%02d.jpg"
					echo ".. IMAGENES HECHAS"
				    fi
				fi

				if [ ! -f "$PrPWD/$namd$namo.sha" -o "$ta1" != "$ta2" -o ! -f "$PrPWD/$namd$namo-previsualizacion"  ];then
				    if [ 0$duration -gt 1500 ];then
					ffmpeg -ss 00:05:00 -t 00:05:00 -threads 4 -loglevel 32 -i "$PrPWD/$namd$namo" -f mp4 -vcodec libx264 -b:v 4800k -minrate 900k -maxrate 5200k  -bufsize 36400k  -force_key_frames "expr:gte(t,n_forced)" -y "$PrPWD/$namd$namo-previsualizacion"
				    else
					rm -v "$PrPWD/$namd$namo-previsualizacion"
					ln -s "$PrPWD/$namd$namo" "$PrPWD/$namd$namo-previsualizacion"
				    fi
				fi
			    fi
			    sha256sum "$PrPWD/$namd$namo" -bz|$PrPWD/stdcarsin " " > "$PrPWD/$namd$namo.sha"
			    id1=$(echo "$namd$namo"  | sha256sum | $PrPWD/stdcarsin " ")
			    v="$namo"
			    lista=$(find "$PrPWD/$namd" -maxdepth 1 -name "$namo*.jpg" | $PrPWD/stdtohex )
			    pasa=$(echo -n "$lista" | $PrPWD/stdbuscaarg_donde_hasta 0A )
			    while [ 0$pasa -gt 0 ];do
				lista2=$(echo -n "$lista" | $PrPWD/stdcarn "$pasa" )
				lista3=$(echo -n "$lista" | $PrPWD/stdcdrn "$pasa" )
				namo=$(echo "$lista2" | $PrPWD/stdcdr "2F")
				t2=$(echo "$namo" | $PrPWD/stdbuscaarg "2F")
				while [ -n "$t2" ];do
				    namo=$(echo "$namo" | $PrPWD/stdcdr "2F")
				    t2=$(echo "$namo" | $PrPWD/stdbuscaarg "2F")
				done
				namd=$(echo -n "$lista2" | $PrPWD/stdcarsin "$namo" | $PrPWD/stdcdr "$PrPWDHEX" )
				namd=$(echo -n "$namd" | $PrPWD/stdfromhex)
				namo=$(echo -n "$namo" | $PrPWD/stdfromhex)
				lista4=$(echo -n "<img src='$namd$namo' style='width:18%;position:relative;float:left;'/>" | $PrPWD/stdtohex )
				lista="$lista3 $lista4"
				pasa=$(echo -n "$lista" | $PrPWD/stdbuscaarg_donde_hasta 0A )
				echo "$lista4"|$PrPWD/stdfromhex
				echo "$pasa"
			    done
			    lista2=$(echo "$lista" | $PrPWD/stdfromhex )
			    listac=$(echo -n "document.getElementById('$id1').selected=true; document.getElementById('videoname').value='$namd$v'; document.getElementById('videoprevplay').src='$namd$v-previsualizacion'; document.getElementById('videoprevplay').style.width='80%';" | $PrPWD/stdtohex )
			    listac=$(echo -n "22 $listac 22"  | $PrPWD/stdfromhex )
			    if [ -n "$enproceso" ];then
				v="$v ( Procesando )"
				salidap=$(echo "<tr><td>$v</td><td>$lista2</td></tr>" | $PrPWD/stdtohex )
			    else
				salidap=$(echo "<tr onclick=$listac ><td>$v</td><td>$lista2</td></tr>" | $PrPWD/stdtohex )
			    fi
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

