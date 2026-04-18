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
		if [ "$campo" = "addaudio" ];then
		    echo "......"
		    audio1=$field
		    r=$((r+1))
		fi
		if [ "$campo" = "videoaudio" ];then
		    echo "......"
		    vidaudio=$field
		    r=$((r+1))
		fi
		cad1=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof")
		estaenboundary=$(echo -n "$cad1" | $PrPWD/stdbuscaarg "$campof" )
		i=$((i+1))
	    done
	    echo "<<   r=$r  >>"
 	    if [ 0$r -eq 2 -a -n "$vidaudio" ];then
    		videon=$vidaudio
		videoi=0;
		videoin=1
    		while [ 0$videoin -gt 0 ];do
		    videoin=$(echo "$videon" | $PrPWD/stdcdrn "0$videoi"| $PrPWD/stdbuscaarg_donde_hasta "/" )
		    videoi=$(echo 0$videoi+0$videoin|bc)
    		done
		videon=$(echo "$videon"|$PrPWD/stdcdrn "0$videoi")
		videop=$(echo "$vidaudio" | $PrPWD/stdcarn "$videoi")
		videon2=$(echo "$videon" | $PrPWD/stddelcar ".")
		videoo="$videop$videon2"

    		subn=$audio1
		subi=0;
		subin=1
    		while [ 0$subin -gt 0 ];do
		    subin=$(echo "$subn" | $PrPWD/stdcdrn "0$subi"| $PrPWD/stdbuscaarg_donde_hasta "/" )
		    subi=$(echo 0$subi+0$subin|bc)
    		done
		subn=$(echo "$subn"|$PrPWD/stdcdrn "0$subi")
		subp=$(echo "$audio1" | $PrPWD/stdcarn "$subi")

		echo "c $vidaudio"
		echo "p $videop"
		echo "v $videon"
		echo "o $videoo"
		echo "s $subn"
		echo "S $subp"
		nomino=$(echo "$PrPWD/$vidaudio.mpd"|$PrPWD/stdtohex)
		ffmpeg -loglevel 32  -threads 2 -i "$PrPWD/$audio1" -vn -ac 2 -c:a aac -b:a 196k -dash 1 -b:v 4800k -minrate 900k -maxrate 5200k  -bufsize 36400k  -f dash -init_seg_name "init_Audio_\$RepresentationID\$_$subn" -media_seg_name "segmento_Audio_\$RepresentationID\$_\$Number\$_$subn" "$PrPWD/$videop/$subn.mpd" -y
		cad1=$(cat "$PrPWD/$videop/$subn.mpd"|$PrPWD/stdcdrcon 'contentType="audio"'|$PrPWD/stdcar "</AdaptationSet>"|$PrPWD/stdtohex)
		cad2=$(echo '<AdaptationSet "'|$PrPWD/stdtohex)
		cad1=$(echo "$cad2 $cad1")
		n=$(cat "$PrPWD/$vidaudio"|$PrPWD/stdbuscaarg_donde_hasta '<AdaptationSet ')
		n=$(echo "0$n-15"|bc)
		cat "$PrPWD/$vidaudio"|$PrPWD/stdcarn "0$n" > "$PrPWD/$videop/$videon.tmp"
		echo "$cad1" |$PrPWD/stdfromhex >> "$PrPWD/$videop/$videon.tmp"
		cat "$PrPWD/$vidaudio"|$PrPWD/stdcdrn "0$n" >> "$PrPWD/$videop/$videon.tmp"
		mv -v "$PrPWD/$videop/$videon.tmp" "$PrPWD/$videop/tempo-$videon"
		echo "Added $subn to $vidaudio ($PrPWD/$videop/$videon)"
		echo "Added $audio1 to $vidaudio" > $fn.html
	    fi
	fi
    fi
fi
