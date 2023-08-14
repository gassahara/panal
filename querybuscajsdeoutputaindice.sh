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
nomprograma=$0
slash=$(echo "$nomprograma"| $PrPWD/stdbuscaarg_donde_hasta "/" )
while [ -n "$slash" ];do
    nomprograma=$(echo "$nomprograma"| $PrPWD/stdcdr "/" )
    slash=$(echo "$nomprograma" | $PrPWD/stdbuscaarg_donde_hasta "/" )
done
cd $PrPWD
PrPWD2=$PWD
PrPWD=$PrPWD2
cd $PaPWD
sleep 0.1
listados="";
listado="";
if [ -d "$PrPWD/users/output" ];then
    listados=$(echo $PrPWD/users/output|$PrPWD/listadodirectorio_dirs_from_std|$PrPWD/stdbuscaarg_donde '
')
    listado=$(echo $PrPWD/users/output|$PrPWD/listadodirectorio_dirs_from_std)
    salta=0;
    while [ -n "$listados" ];do
	presalta=$(echo -n "$listados" | $PrPWD/stdcar " ")
	dirn=$(echo -n "$listado"|$PrPWD/stdcdrn 0$salta | $PrPWD/stdcarn $presalta)
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std_extension_js )
	lista2=$(echo -n "$lista1
$lista0" )
	lista0=$lista2
	salta=$(expr "$presalta + 1")
	listados=$(echo -n "$listados" | $PrPWD/stdcdr " ")
    done
fi
busca=".."
posicion=0;
dondes=$( echo "$lista0" |$PrPWD/stdbuscaarg_donde "
")
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=""
    if [ -n "$listf" ];then
	chacha=$(cat "$listf"|$PrPWD/chacha20)
    fi
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -z "$encuentra" ];then
    echo ";$listf;$chacha;" >> $nomprograma.memoria
fi
    ps1=3
    	ps1=$(ps -au$USER  |  $PrPWD/stdbuscaarg_count " $nomprograma" )
    while [ 0$ps1 -gt 3 ];do
    	ps1=$(ps -au$USER  |  $PrPWD/stdbuscaarg_count " $nomprograma" )
	#    	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
    	sleep 1
    done
    while [ 0$ps1 -gt 0 ];do
	sleep 1
	ps1=$(expr 0$ps1 - 1)
    done
    $0 &
if [ -z "$encuentra" -a -n "$listf" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	fn2="$fn"
	while [ -n "$slash" ];do
	    fn2=$(echo -n "$fn2" | $PrPWD/stdcdr "/" )
	    slash=$(echo -n "$fn2" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
	dirfn=$(echo -n "$fn"|$PrPWD/stdcarsin "/$fn2")
	userd=$(echo -n "$fn"|$PrPWD/stdcdr "users/output/"|$PrPWD/stdcarsin "/")
	dirfn=$(echo -n "$dirfn/data/")
	mkdir "$dirfn"
 	echo "0 $busca ($fn2) $dirfn $userd"
	sleep 3
	len=$(cat "$fn"|wc -c|$PrPWD/stddelcar " ")
	if [ 0$len -gt 0 ];then
	    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
	    outputdelc=$(echo "$dirfn/$outputdelc")
	    while [ -f "$outputdelc.c" ];do
		outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
	    done
	    echo "oOO $outputdelc OOo"
	    cat $PrPWD/stdbidiarray.c | $PrPWD/stdcar "char array[" > $outputdelc.c
	    echo -n "$len]={" >> $outputdelc.c
	    cat "$fn"|$PrPWD/stdtohex0x  >> $outputdelc.c
	    echo -n "}" >> $outputdelc.c
	    cat $PrPWD/stdbidiarray.c | $PrPWD/stdcdr "char array[" | $PrPWD/stdcdr "}" >> $outputdelc.c
	    errores=$(gcc -o "$outputdelc" "$outputdelc.c" 2>&1)
	    echo ":::::::::::"
	    echo "$errores"
	    echo "$outputdelc"
	    echo "<><><><><><>"
	    listf=$outputdelc

	    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
	    outputdelc=$(echo "$dirfn/$outputdelc")
	    while [ -f "$outputdelc.c" ];do
		outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
	    done

	    iv="{"
	    while [ 0$c -lt 16 ];do
		iv2=$(dd if=/dev/urandom bs=1 count=1 2>/dev/null | $PrPWD/stdtohex)
		iv=$(echo "$iv 0x $iv2,"|$PrPWD/stddelcar " ")
		c=$((c+1))
	    done
	    iv=$(echo "$iv }};"|$PrPWD/stddelcar " "|$PrPWD/stddelcar ",}")
	    cat $PrPWD/users/$userd/$userd-aes.c | $PrPWD/stdcar "char iv[1][16]=" > $outputdelc.c
	    echo "$iv" >> $outputdelc.c
	    cat $PrPWD/users/$userd/$userd-aes.c | $PrPWD/stdcdr "char iv[1][16]=" | $PrPWD/stdcdr ";" >> $outputdelc.c

	    cat $outputdelc.c | $PrPWD/stdcar "char buf[" > $outputdelc-2.c
	    $listf | $PrPWD/stdcdr "[" >> $outputdelc-2.c
	    cat $outputdelc.c | $PrPWD/stdcdr "char buf[" | $PrPWD/stdcdr ";" >> $outputdelc-2.c
	    mv $outputdelc-2.c $outputdelc.c	    
	    errores=$(gcc -o $outputdelc-bin $outputdelc.c)
	    listado=$($outputdelc-bin|tr '
' ';')
	    listf="ALGO";
	    nombre=$(echo "$fn"|sha512sum -b|$PrPWD/stdcarsin " ")
	    while [ -n "$listf" ];do
		listf=$(echo -n ";$listado" |$PrPWD/stdcdr ";int "|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "["|$PrPWD/stdcarsin "=")
 	    echo ":::::::::::"
	    echo "$listf"
	    echo "<><><><><><>"
		busca=$(echo -n ";$listado"|$PrPWD/stdcdr ";int $listf"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "["|$PrPWD/stdcdrcon "=")
 	    echo "bibibibibibibibibibibibibibibibibi"
	    echo "$busca"
	    echo "<><><><><><>"
		if [ -z "$busca" ];then
		    busca=$(echo -n "$listado"|$PrPWD/stdcdr ";int $listf"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdrcon "=")
		fi
		listado=$(echo -n ";$listado"|$PrPWD/stddelcar ";int $listf")
		busca="$listf$busca;"
		len=$(echo -n "$busca"|$PrPWD/stdbuscaarg "{")
		while [ -n "$len" ];do
		    listf=$(echo -n "$busca"|$PrPWD/stdcarsin "{")
		    busca=$(echo -n "$busca"|$PrPWD/stdcdr "{")
		    busca=$(echo -n "$listf new Array ($busca")
		    listf=$(echo -n "$busca"|$PrPWD/stdcarsin "}")
		    busca=$(echo -n "$busca"|$PrPWD/stdcdr "}")
		    busca=$(echo -n "$listf)$busca")
		    len=$(echo -n "$busca"|$PrPWD/stdbuscaarg "{")
		done
		echo "$busca" >> "$outputdelc.js"
	    done
	    if [ -z "$errores" ];then
		mv "$outputdelc.js" "$PrPWD/users/output/$userd/$nombre.js"
	    else
		echo "EE::$errores"
	    fi
	fi
    fi
fi
