#!/bin/sh
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
#echo "$nomprograma.."
sleep 0.1
listados="";
listado="";
if [ -d "$PrPWD/users/tooutput" ];then
    listados=$(echo $PrPWD/users/tooutput|$PrPWD/listadodirectorio_dirs_from_std|$PrPWD/stdbuscaarg_donde '
')
    listado=$(echo $PrPWD/users/tooutput|$PrPWD/listadodirectorio_dirs_from_std)
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
    chacha=$(cat "$listf"|$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -z "$encuentra" ];then
    echo ";$listf;$chacha;" >> $nomprograma.memoria
fi
if [ -n "$dondes" ];then
    $0 &
else
    ps1=3
    while [ 0$ps1 -gt 2 ];do
 	ps1=$(ps -Am -o ";%c:" | $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
 	sleep 2
    done
    $0 &
fi
if [ -z "$encuentra" ];then
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
	userd=$(echo -n "$fn"|$PrPWD/stdcdr "users/tooutput/"|$PrPWD/stdcarsin "/")
	dirfn="$PrPWD/users/tooutput"
	mkdir "$dirfn"
	dirfn=$(echo -n "$dirfn/$userd/")
	mkdir "$dirfn"
 	echo "0 $busca ($fn2) $dirfn $userd"
	sleep 3
	len=$(cat "$fn"|wc -c)
	if [ 0$len -gt 0 ];then
	    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
	    while [ -f "$outputdelc.c" ];do
		outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
	    done
	    busca=$(cat $fn|$PrPWD/stdbuscaarg_count ";")
	    encuentra=0;
	    dondex=0;
	    nombre=$(echo "$fn"|sha512sum -b|$PrPWD/stdcarsin " ")
	    cp "$PrPWD/users/tooutput/$userd/$nombre.js" $outputdelc
	    echo "indicearray.push(new Array({"'"'"$nombre"'"'"},{"'"'"});" >> $outputdelc
	    mv "$outputdelc" "$PrPWD/users/tooutput/$userd/$nombre.js"
	    if [ -z "$errores" ];then
		echo "EE::$errores"
	    fi
	fi
    fi
fi
if [ -n "$dondes" ];then
    $0 &
else
    ps1=3
    while [ 0$ps1 -gt 2 ];do
 	ps1=$(ps -Am -o ";%c:" | $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
 	sleep 2
    done
    $0 &
fi
