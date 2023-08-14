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
	$0 &
    else
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
		echo "$campo====$field>"
		if [ "$campo" = "addsub" ];then
		    echo "......"
		    subt=$field
		    r=$((r+1))
		fi
		if [ "$campo" = "videoasub" ];then
		    echo "......"
		    convsub=$field
		    r=$((r+1))
		fi
		cad1=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof")
		estaenboundary=$(echo -n "$cad1" | $PrPWD/stdbuscaarg "$campof" )
		i=$((i+1))
	    done
	    echo "r=$r"
 	    if [ 0$r -eq 2 -a -n "$convsub" ];then
    		videon=$convsub
		videoi=0;
		videoin=1
    		while [ 0$videoin -gt 0 ];do
		    videoin=$(echo "$videon" | $PrPWD/stdcdrn "0$videoi"| $PrPWD/stdbuscaarg_donde_hasta "/" )
		    videoi=$(echo 0$videoi+0$videoin|bc)
    		done
		videon=$(echo "$videon"|$PrPWD/stdcdrn "0$videoi")
		videop=$(echo "$convsub" | $PrPWD/stdcarn "$videoi")
		videon2=$(echo "$videon" | $PrPWD/stddelcar ".")
		videoo="$videop$videon2"

    		subn=$subt
		subi=0;
		subin=1
    		while [ 0$subin -gt 0 ];do
		    subin=$(echo "$subn" | $PrPWD/stdcdrn "0$subi"| $PrPWD/stdbuscaarg_donde_hasta "/" )
		    subi=$(echo 0$subi+0$subin|bc)
    		done
		subn=$(echo "$subn"|$PrPWD/stdcdrn "0$subi")
		subp=$(echo "$subt" | $PrPWD/stdcarn "$subi")

		echo "c $convsub"
		echo "p $videop"
		echo "v $videon"
		echo "o $videoo"
		echo "s $subn"
		subn2=$(cat "$PrPWD/$convsub" | $PrPWD/stdbuscaarg "<BaseURL>$subn</BaseURL>")
		if [ ! -f "$PrPWD/$videop/$subn" -o -z "$subn2" ];then
		    cp -v "$PrPWD/$subt" "$PrPWD/$videop"
		    cat "$PrPWD/$convsub"|$PrPWD/stdcarsin "<AdaptationSet " > "$PrPWD/$convsub.tmp"
		    echo "<AdaptationSet contentType='text' lang='en' mimeType='text/vtt'><Representation bandwidth='10000' ><BaseURL>$subn</BaseURL></Representation> </AdaptationSet>" >> "$PrPWD/$convsub.tmp"
		    cat "$PrPWD/$convsub"|$PrPWD/stdcdrcon "<AdaptationSet " >> "$PrPWD/$convsub.tmp"
		    mv -v "$PrPWD/$convsub.tmp" "$PrPWD/$convsub"
		    echo "Adding $subt to $convsub"
		    echo "Added $subt to $convsub" > $fn.html
		else
		    echo "YA EXISTE" > $fn.html
		fi
	    fi
	fi
    fi
fi
