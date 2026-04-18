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
	    campof=$(cat $fn.in |$PrPWD/stdhttpcontent |$PrPWD/stdcdr "boundary=" | $PrPWD/stdtohex | $PrPWD/stdcarsin 0A | $PrPWD/stdcarsin 0D)
	    dashes=$(echo -n "---" | $PrPWD/stdtohex )
	    ka=999
	    while [ $ka -gt 2 ];do
		ka=$(echo "$campof"|$PrPWD/stdbuscaarg_count "$dashes")
		campof=$(echo "$campof"|$PrPWD/stdcdr $dashes)
		echo "$campof"
	    done
	    
	    name1=$(echo -n 'name="' | $PrPWD/stdtohex )
	    i=1
	    n=0
	    cat $fn.in  | $PrPWD/stdtohex > $fn.hex
	    dondes=$(cat $fn.in  | $PrPWD/stdtohex | $PrPWD/stdbuscaarg_donde "$campof" )
	    diccionario=2
	    while [ -n "$dondes" ];do
		dondei=$(echo "$dondes"|$PrPWD/stdcarsin " ")
		dondes=$(echo "$dondes" | $PrPWD/stdcdr " ")
		dondef=$(echo "$dondes"|$PrPWD/stdcarsin " ")
		echo "<$dondei $dondef>"
		campo=$(cat $fn.hex | $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei)) | $PrPWD/stdcarsin "0D 0A 0D 0A" | $PrPWD/stdcdr "$name1" | $PrPWD/stdcarsin 22|$PrPWD/stdfromhex)
		echo "--<$campo>--"
		echo "$campo=$field>"
		if [ "$campo" = "diccionario" ];then
		    diccionario=$((diccionario-1))
		    r=$((r+1))
		fi
		if [ "$campo" = "longitud" ];then
		    longitud=$(cat $fn.hex | $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei)) |$PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
		    echo "<< LONG $longitud >>"
		    r=$((r+1))
		fi
		cad1=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof")
		i=$((i+1))
	    done
	    echo -e "\n\n\nr=$r i=$i"
	    nn=$fn
    	    while [ $(echo $nn | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    		nn=$(echo $nn | $PrPWD/stdcdr "/" )
    	    done

 	    if [ 0$r -eq 2 -a $diccionario -eq 1 ];then
		dic1="$PrPWD/comp/sphinx/cmusphinx-es-5.2/etc/voxforge_es_sphinx.dic"
		lineasdic=$(cat "$dic1" | wc -l)
		palabra="99999999999999999"
		pale=1
		while [ $(echo "$palabra"|wc -c) -gt $longitud ];do
		    nbits=1
		    nh=1
		    while [ 0$nh -lt 0$lineasdic ];do
			n=$(dd if=/dev/urandom  bs=1 count=$nbits skip=$nbits 2>/dev/null | $PrPWD/stdtohex |$PrPWD/stddelcar " ")
			nh=$(echo "ibase=16;$n"|bc)
			nbits=$((nbits+1))
		    done
		    while [ 0$nh -gt 0$lineasdic ];do
			nh2=$(echo "$nh-$lineasdic"|bc)
			nh=$nh2
		    done
		    echo $nh2
		    lineasdiclugares=$(cat "$dic1"|$PrPWD/stdbuscaarg_donde $'\n')
		    palabra=$(head -n $nh2 "$dic1" | tail -n1 | $PrPWD/stdcarsin " " )
		    echo "< $palabra >"
		done
		echo "<HTML><BODY><p style=\"font-family: 'Sans';font-size:140px;color:green;\">$palabra</p></h2></BODY></HTML>" > $fn.html
	    fi
	fi
    fi
fi
