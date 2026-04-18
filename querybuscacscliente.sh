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
#cspiceloc=" /media/A/nube/comp/cspice" #ntfs
cspiceloc=" $PrPWD/cspice/cspiceosx/cspiceosx" #apfs
cd $PrPWD
PrPWD2=$PWD
PrPWD=$PrPWD2
cd $PaPWD
#echo "$nomprograma.."
sleep 0.1
listados="";
listado="";
if [ -d "$PrPWD/users/input" ];then
    listados=$(echo $PrPWD/users/input|$PrPWD/listadodirectorio_dirs_from_std|$PrPWD/stdbuscaarg_donde '
')
    listado=$(echo $PrPWD/users/input|$PrPWD/listadodirectorio_dirs_from_std)
    salta=0;
    while [ -n "$listados" ];do
	presalta=$(echo -n "$listados" | $PrPWD/stdcar " ")
	dirn=$(echo -n "$listado"|$PrPWD/stdcdrn 0$salta | $PrPWD/stdcarn $presalta)
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std_extension_c )
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
	sleep 0.5
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
			userd=$(echo -n "$fn"|$PrPWD/stdcdr "users/input/"|$PrPWD/stdcarsin "/")
			echo "uuuuUUUUU   $userd UUUUuuuu "
			mkdir $PrPWD/users/input
			mkdir $PrPWD/users/input/$userd
		    variables=$(cat "$fn" |$PrPWD/stddeclaracionesdevariable|tr '
' ';')
		    echo "$variables"
		    varos="";
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "time_t prefix_")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi		    
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_nombre[")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_direccion[")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "char prefix_cedula[8]")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "char prefix_respuesta[8]")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    if [ "$varos" = "****" ];then
			fechan=$(echo -n ";$variables" |$PrPWD/stdcdr ";time_t "|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "=")
			nombre=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_nombre["|$PrPWD/stdcdr "]="|$PrPWD/stdcarsin ";")
			direccion=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_direccion["|$PrPWD/stdcdr "]="|$PrPWD/stdcarsin ";")
			cedula=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_cedula["|$PrPWD/stdcdr "]=\""|$PrPWD/stdcarsin "\"")
			respuesta=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_respuesta["|$PrPWD/stdcdr "]=\""|$PrPWD/stdcarsin "\"")
			echo "$fechan $plan $fecha $cedula .............."
			mkdir $PrPWD/users/output/$userd
			if [ -f "$PrPWD/users/clientes/$cedula" ];then
			    mkdir $PrPWD/users/output
			    echo "Cliente YA EXISTE" > $PrPWD/users/output/$userd/$respuesta
			else
			    mkdir $PrPWD/users/clientes
			    cp -v "$listf" $PrPWD/users/clientes/$cedula
			    utcc=$(dd if=/dev/random bs=1 count=5 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    echo "<option value=\"$utcc\"> $cedula </option>" >> $PrPWD/users/cedulas.html
			    cp -v  $PrPWD/users/cedulas.html  $PrPWD/users/output/unencrypted/cedulas.html
			    echo "Cliente Agregado con Exito" > $PrPWD/users/output/$userd/$respuesta
			fi
		    fi
		fi
		mkdir peticiones
    		# mv $dirfn/$swecl*.c peticiones/
    		# mv $dirfn/$tjdf*.c peticiones/
		# mv $dirfn/$aspecas*.c peticiones/
		# mv $dirfn/$aspececl*.c peticiones/
    		# mv $dirfn/$ffc* peticiones/
		#    		mv $fn peticiones/
		#    		mv $fn.* peticiones/
	    fi
	fi
    fi
fi
