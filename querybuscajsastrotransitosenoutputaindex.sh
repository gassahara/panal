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
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std_extension_js )
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
	len=$(cat "$fn"|wc -c|tr -d ' '|tr -d '
')
	if [ 0$len -gt 0 ];then
		    varos="";
		    varis=$(cat "$fn" |$PrPWD/stdbuscaarg "var processed=255")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "pro $varos"
		    else
			exit 0
		    fi		    
		    varis=$(cat "$fn" |$PrPWD/stdbuscaarg "var fecha=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "fec $varos"
		    else
			exit 0
		    fi		    
		    varis=$(cat "$fn" |$PrPWD/stdbuscaarg "var prefix_descripcion=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "des $varos"
		    else
			exit 0
		    fi		    
		    varis=$(cat "$fn" |$PrPWD/stdbuscaarg "var latitud=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "lat $varos"
		    else
			exit 0
		    fi		    
		    varis=$(cat "$fn" |$PrPWD/stdbuscaarg "var longitud=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "lon $varos"
		    else
			exit 0
		    fi		    
		    varis=$(cat "$fn"|$PrPWD/stdbuscaarg "var planeta=new Array")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "pla $varos"
		    else
			exit 0
		    fi		    
		    varis=$(cat "$fn"|$PrPWD/stdbuscaarg "var posicion_transito=new Array")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "post $varos"
		    else
			exit 0
		    fi
		    varis=$(cat "$fn"|$PrPWD/stdbuscaarg "var planeta_transito=new Array")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "plat $varos"
		    else
			exit 0
		    fi
		    varis=$(cat "$fn"|$PrPWD/stdbuscaarg "var dias=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "dia $varos"
		    else
			exit 0
		    fi
		    if [ "$varos" = "*********" ];then
			dias=$(cat "$fn" |$PrPWD/stdcdr "var dias="|$PrPWD/stdcarsin ";")
			fecha=$(cat "$fn" |$PrPWD/stdcdr "var fecha=\""|$PrPWD/stdcarsin "\"")
			ANO=$(echo "$fecha" |$PrPWD/stdcarsin "/")
			MES=$(echo "$fecha" |$PrPWD/stdcdr "/" |$PrPWD/stdcarsin "/")
			DIA=$(echo "$fecha" |$PrPWD/stdcdr "/"  |$PrPWD/stdcdr "/" |$PrPWD/stdcarsin " ")
			HORA=$(echo "$fecha" |$PrPWD/stdcdr " ")
			fecha=$(echo "$DIA/$MES/$ANO $HORA")
			latitud=$(cat "$fn" |$PrPWD/stdcdr "var latitud="|$PrPWD/stdcarsin ";")
			longitud=$(cat "$fn" |$PrPWD/stdcdr "var longitud="|$PrPWD/stdcarsin ";")
			descripcion=$(cat "$fn" |$PrPWD/stdcdr "var prefix_descripcion="|$PrPWD/stdcarsin ";" | $PrPWD/stdcdr "\""|$PrPWD/stdcarsin "\"")
			userd=$(echo -n "$fn"|$PrPWD/stdcdr "users/tooutput/"|$PrPWD/stdcarsin "/")
			nombre=$(echo "$userd" | tr -d '
' | sha512sum | $PrPWD/stdcarsin ' ')
			nombro=$(echo "$fn" | tr -d '
' | sha512sum | $PrPWD/stdcarsin ' ')
			echo "uuuuUUUUU   $userd UUUUuuuu $nombre "
			encuentra=$(cat $PrPWD/users/output/$userd/$nombre.js |$PrPWD/stdbuscaarg "var descripcion")
			if [ -z "$encuentra" ];then
			    echo "var descripcion=new Array('')" >> $PrPWD/users/output/$userd/$nombre.js
			fi
			encuentra=$(cat $PrPWD/users/output/$userd/$nombre.js |$PrPWD/stdbuscaarg "var nombre")
			if [ -z "$encuentra" ];then
			    echo "var nombre=new Array('')" >> $PrPWD/users/output/$userd/$nombre.js
			fi
			encuentra=$(cat $PrPWD/users/output/$userd/$nombre.js |$PrPWD/stdbuscaarg "$fecha-$latitud-$logitud")
			if [ -z "$encuentra" ];then
			    echo "descripcion[descripcion.length]=\"Transito para ($descripcion) en $fecha por $dias dias en ($latitud:$longitud)\";" >> $PrPWD/users/output/$userd/$nombre.js
			    echo "nombre[nombre.length]=\"$nombro.js.js\";" >> $PrPWD/users/output/$userd/$nombre.js
			    cp "$fn" $PrPWD/users/output/$userd/$nombro.js
			fi
		    fi
	fi
    fi
fi
