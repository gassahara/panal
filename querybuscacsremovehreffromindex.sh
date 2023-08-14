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
SWESRC="/run/media/user/4T/nube/swe/src"
cspiceloc="/run/media/user/4T/nube/comp/cspice" #linux
cd $PaPWD
#echo "$nomprograma.."
sleep 10
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
	sleep 3
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
		    varos="";
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg ";char prefix_filename[")
		    if [ -n "$varis" ];then
			varis=$(echo -n ";$variables" |$PrPWD/stdcdr ";char prefix_filename["|$PrPWD/stdcarsin '
'|$PrPWD/stdcarsin ";")
			echo "V1 $varis"
			if [ -n "$varis" ];then
			    varis=$(echo -n "$varis" |$PrPWD/stdcdr "="|$PrPWD/stdcarsin '
'|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr '"'|$PrPWD/stdcarsin '"')
			    echo "V2 $varis"
			    varis='*'
			    varos="$varos$varis"
			else
			    exit 0
			fi
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg ";char prefix_descripcion[")
		    if [ -n "$varis" ];then
			varis=$(echo -n ";$variables" |$PrPWD/stdcdr ";char prefix_descripcion["|$PrPWD/stdcarsin '
'|$PrPWD/stdcarsin ";")
			echo "D1 $varis"
			if [ -n "$varis" ];then
			    varis=$(echo -n "$varis" |$PrPWD/stdcdr "="|$PrPWD/stdcarsin '
'|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr '"'|$PrPWD/stdcarsin '"')
			    echo "D2 $varis"
			    varis='*'
			    varos="$varos$varis"
			else
			    exit 0
			fi
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg ";int prefix_borrar=1;")
		    if [ -z "$varis" ];then
			exit 0
		    else
			varos="$varos$varis"			
		    fi
		    echo "$varos"
		    if [ "$varos" = "***" ];then
			filen=$(echo  ";$variables" |$PrPWD/stdcdr ";char prefix_filename["|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "="|$PrPWD/stdcdr '"'|$PrPWD/stdcarsin '"')
		        descrip=$(echo  ";$variables" |$PrPWD/stdcdr ";char prefix_descripcion["|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "="|$PrPWD/stdcdr '"'|$PrPWD/stdcarsin '"')
			userd=$(echo -n "$fn"|$PrPWD/stdcdr "users/input/"|$PrPWD/stdcarsin "/")
			nombre=$(echo "$userd" | tr -d '
' | sha512sum | $PrPWD/stdcarsin ' ')
			cadena=$(echo "descripcion[descripcion.length]=\"$descrip\";" | $PrPWD/stdtohex)
			cadena2=$(echo "nombre[nombre.length]=\"$filen\";" | tr -d '
' | $PrPWD/stdtohex)
			cadena3=$(echo "$cadena $cadena2"|$PrPWD/stdfromhex)
			encuentra=$(cat "$PrPWD/users/output/$userd/$nombre.js"|$PrPWD/stdbuscaarg "$cadena3")
			echo " . . . . . "
			echo "$cadena3"
			if [ -n "$encuentra" ];then
			    cat "$PrPWD/users/output/$userd/$nombre.js" | $PrPWD/stdcarsin  "$cadena3" > "$dirfn/$fn2.tmp"
			    cat "$PrPWD/users/output/$userd/$nombre.js" | $PrPWD/stdcdr "$cadena3" >> "$dirfn/$fn2.tmp"
			    cp -v "$dirfn/$fn2.tmp" "$PrPWD/users/output/$userd/$nombre.js"
			else
			    echo "NOT FOUND"
			fi
		    fi
		fi
	    fi
	fi
    fi
fi
