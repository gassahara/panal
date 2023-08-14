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
    lista=$(find "$PrPWD/documentos" -name "*.tex" -exec cat "{}" |$PrPWD/stdtohex |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat documentostex|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" -a -0$procs -eq 0 -a -f documentostex ];then
	pasa=1
	$0 &
	disown
    else
	echo "..."
	cp -v $PrPWD/uD.html $PrPWD/uD.bak
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
		imag=""
		if [ -f "$namd$namo.jpg" ];then
		    imag="$namd/$namo.jpg"
		else
		    if [ -z "$imag" ];then
			imag=$($P2PWD/listadodirectorio_files_extension .jpg|$P2PWD/stdcdr "$PrPWD"|$P2PWD/stdtohex|$P2PWD/stdcarsin 0A|$P2PWD/stdfromhex)
		    fi
		fi
		echo "[ $imag ]                    $namo <<<<<<<<"
		cd "$PaPWD"
		lista4=$(echo -n "<FORM METHOD=POST><p style='width:30%;height:22%;float:left;' name='$id1'><input hidden value='$id1' name='nombre'><img src='$imag' style='height:120px;'><br>$namo</p><input hidden value='convertir' name='convertir'><input type='submit'></FORM>" | $PrPWD/stdtohex )
	    fi
	lista="$lista3 $lista4"
	pasa=$(echo $lista | $PrPWD/stdbuscaarg 0A )
    done
    lista2=$(echo "$lista"  | $PrPWD/stdfromhex )
    echo "___________________"
    if [ -n "$lista2" ];then
	listav=" Documentos <hr> <div id='directoriov' style='width:100%;'></div> <div style='width:90%;left:5%;position:relative;background-color:green;height:110%;display:flex;flex-wrap:wrap;overflow:scroll;' name='videos' id='videos' style='width:100%;' >$lista2 </div>"
    fi

    salidah=$(echo -n "$listap $listav <hr> $listau <hr> $listas <hr>" | $PrPWD/stdtohex)
    echo ":::: queryvideo"
    cat $PrPWD/dD.html | $PrPWD/stdcarsin "<!-- CORTAR -->" > $PrPWD/dD2.html
    echo "$salidah" |  $PrPWD/stdfromhex >> $PrPWD/dD2.html
    cat $PrPWD/dD.html | $PrPWD/stdcdr "<!-- CORTAR -->" >> $PrPWD/dD2.html
    cp -v $PrPWD/dD2.html $PrPWD/dD3.html
    #$0 &
    disown
fi
