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
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std_extension_c )
	lista2=$(echo -n "$lista1
$lista0" )
	lista0=$lista2
	salta=$(expr $presalta + 1)
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
ps1=1
while [ -f "$nomprograma.lock-$ps1" ];do
    if [ 0$ps1 -lt 3 ];then
	echo "W W W W W W W W W W W W W   $ps1"
	ps1=$(expr 0$ps1 + 1)
    else
	ps1=1
	sleep 1
    fi
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
	mkdir "$dirfn/data"
	dirfn=$(echo -n "$dirfn/data" )
    	echo "0 $busca ($fn2) $dirfn"
	len=$(cat "$fn"|wc -c|tr -d ' '|tr -d '
')
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - $closs)
	    echo "$len $opens-$closs"
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		ejec="$fn.$nomprograma.bin"
		echo "E: $ejec"
		errores=$(gcc -o "$ejec" "$fn" 2>&1 )
		if [ -z "$errores" ];then
		    utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
		    while [ -f "$dirfn/$utcc.c" ];do
			utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
		    done
		    variables=$(cat "$fn" |$PrPWD/stddeclaracionesdevariable|tr '
' ';')
		    echo "$variables"
		    varos="";
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "time_t prefix_fecha=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi		    
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "double prefix_latitud=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi		    
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "double prefix_longitud=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "double prefix_ascendente=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "double prefix_ascendente_ascencional=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    if [ "$varos" = "*****" ];then
			fechan=$(echo -n ";$variables" |$PrPWD/stdcdr ";time_t "|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "=")
			fecha=$(echo -n ";$variables" |$PrPWD/stdcdr "$fechan="|$PrPWD/stdcarsin ";")
			latitud=$(echo -n ";$variables"|$PrPWD/stdcdr "double prefix_latitud="|$PrPWD/stdcarsin ";")
			longitud=$(echo -n ";$variables"|$PrPWD/stdcdr "double prefix_longitud="|$PrPWD/stdcarsin ";")
			userd=$(echo -n "$fn"|$PrPWD/stdcdr "users/tooutput/"|$PrPWD/stdcarsin "/")
			nombre=$(echo "$userd" | tr -d '
' | sha512sum | $PrPWD/stdcarsin ' ')
			echo "uuuuUUUUU   $userd UUUUuuuu "
			fn3=$(echo "$fn2"|$PrPWD/stdcarsin ".c"|sha512sum|$PrPWD/stdcarsin " ")
			cat "$fn"|$PrPWD/stddeclaracionesdevariable_tojs 
			cat "$fn"|$PrPWD/stddeclaracionesdevariable_tojs > $PrPWD/users/output/$userd/$fn3.js
			touch $PrPWD/users/output/$userd/$nombre.js
			encuentra=$(cat $PrPWD/users/output/$userd/$nombre.js |$PrPWD/stdbuscaarg "var descripcion")
			if [ -z "$encuentra" ];then
			    echo "var descripcion=new Array('')" >> $PrPWD/users/output/$userd/$nombre.js
			fi
			encuentra=$(cat $PrPWD/users/output/$userd/$nombre.js |$PrPWD/stdbuscaarg "var nombre")
			if [ -z "$encuentra" ];then
			    echo "var nombre=new Array('')" >> $PrPWD/users/output/$userd/$nombre.js
			fi
			fecha=$(date --date "@$fecha" -u)
			encuentra=$(echo "$longitud" | $PrPWD/stdbsucaarg "-")
			if [ -n "$encuentra" ];then
			    longitud=$(echo "$longitud W"|$PrPWD/stdcdr "-"| tr -d '
' )
			else
			    longitud=$(echo "$longitud E"| tr -d '
')
			fi
			encuentra=$(echo "$latitud" | $PrPWD/stdbsucaarg "-")
			if [ -n "$encuentra" ];then
			    latitud=$(echo "$latitud N"|$PrPWD/stdcdr "-"| tr -d '
' )
			else
			    latitud=$(echo "$latitud S"| tr -d '
')
			fi
			encuentra=$(cat $PrPWD/users/output/$userd/$nombre.js |$PrPWD/stdbuscaarg "$fecha-$latitud-$longitud")
			if [ -z "$encuentra" ];then
			    echo "descripcion[descripcion.length]=\"$fecha en $latitud $longitud\";" >> $PrPWD/users/output/$userd/$nombre.js
			    echo "nombre[nombre.length]=\"$fn3.js.js\";" >> $PrPWD/users/output/$userd/$nombre.js
			fi
		    fi
		fi
	    fi
	fi
    fi
fi
