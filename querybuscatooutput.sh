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
    listados=$(echo $PrPWD/users/input|$PrPWD/listadodirectorio_dirs_from_std|$PrPWD/stdbuscaarg_donde '
')
    listado=$(echo $PrPWD/users/input|$PrPWD/listadodirectorio_dirs_from_std)
    salta=0;
    while [ -n "$listados" ];do
	presalta=$(echo -n "$listados" | $PrPWD/stdcar " ")
	dirn=$(echo -n "$listado"|$PrPWD/stdcdrn 0$salta | $PrPWD/stdcarn $presalta)
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std )
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
    chacha=$(echo "$listf"|$PrPWD/chacha20)
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
	userd=$(echo -n "$fn"|$PrPWD/stdcdr "users/input/"|$PrPWD/stdcarsin "/")
	dirfn="$PrPWD/users/tooutput"
	mkdir "$dirfn"
	dirfn=$(echo -n "$dirfn/$userd/")
	mkdir "$dirfn"
 	echo "0 $busca ($fn2) $dirfn $userd"
	sleep 3
	len=$(cat "$fn"|wc -c)
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(echo "$opens-$closs"|bc)
	    echo "$len $opens-$closs"
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
 		ejec="$fn.$nomprograma.bin"
		echo "E: $ejec"
		errores=$(gcc -o "$ejec" "$fn" 2>&1 )
		if [ -z "$errores" ];then
		    variables=$(cat "$fn" |$PrPWD/stddeclaracionesdevariable|tr '
' ';'|$PrPWD/stddelcar " "|$PrPWD/stddelcar "intmain")
		    variables=";$variables"
		    varos="";
		    varis=$(echo -n "$variables" |$PrPWD/stdbuscaarg_count ";double")
		    if [ 0$varis -ge 12 ];then
			varos="$varos$varis"
		    else
			exit 0
		    fi		 
		    varis=$(echo -n "$variables" |$PrPWD/stdbuscaarg_count ";char")
		    if [ 0$varis -ge 2 ];then
			varos="$varos$varis"
		    else
			exit 0
		    fi		 
		    varis=$(echo -n "$variables" |$PrPWD/stdbuscaarg_count ";int")
		    if [ 0$varis -ge 2 ];then
			varos="$varos$varis"
		    else
			exit 0
		    fi
		    varis=$(echo -n "$variables"|$PrPWD/stdbuscaarg ";time_t")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
		    else
			exit 0
		    fi

		    utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " "|sha512sum|$PrPWD/stdcarsin " ")
		    while [ -f "$dirfn/$utcc.js" ];do
			utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " "|sha512sum|$PrPWD/stdcarsin " ")
		    done
		    utcc=$(echo -n "$dirfn/$utcc.js");
		    varis="ALGO";
		    while [ -n "$varis" ];do
			varis=$(echo -n ";$variables" |$PrPWD/stdcdr ";int"|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "["|$PrPWD/stdcarsin "=")
			varos=$(echo -n "$variables"|$PrPWD/stdcdr ";int$varis"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "["|$PrPWD/stdcdrcon "=")
			if [ -z "$varos" ];then
			    varos=$(echo -n "$variables"|$PrPWD/stdcdr ";int$varis"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdrcon "=")
			fi
			variables=$(echo -n "$variables"|$PrPWD/stddelcar ";int$varis")
			varos="$varis$varos;"
			len=$(echo -n "$varos"|$PrPWD/stdbuscaarg "{")
			while [ -n "$len" ];do
			    varis=$(echo -n "$varos"|$PrPWD/stdcarsin "{")
			    varos=$(echo -n "$varos"|$PrPWD/stdcdr "{")
			    varos=$(echo -n "$varis new Array ($varos")
			    varis=$(echo -n "$varos"|$PrPWD/stdcarsin "}")
			    varos=$(echo -n "$varos"|$PrPWD/stdcdr "}")
			    varos=$(echo -n "$varis)$varos")
			    len=$(echo -n "$varos"|$PrPWD/stdbuscaarg "{")
			done
			echo "$varos" >> "$utcc"
		    done
		    varis="ALGO";
		    while [ -n "$varis" ];do
			varis=$(echo -n ";$variables" |$PrPWD/stdcdr ";double"|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "["|$PrPWD/stdcarsin "=")
			varos=$(echo -n "$variables"|$PrPWD/stdcdr ";double$varis"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "["|$PrPWD/stdcdrcon "=")
			if [ -z "$varos" ];then
			    varos=$(echo -n "$variables"|$PrPWD/stdcdr ";double$varis"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdrcon "=")
			fi
			variables=$(echo -n "$variables"|$PrPWD/stddelcar ";double$varis")
			varos="$varis$varos;"
			len=$(echo -n "$varos"|$PrPWD/stdbuscaarg "{")
			while [ -n "$len" ];do
			    varis=$(echo -n "$varos"|$PrPWD/stdcarsin "{")
			    varos=$(echo -n "$varos"|$PrPWD/stdcdr "{")
			    varos=$(echo -n "$varis new Array ($varos")
			    varis=$(echo -n "$varos"|$PrPWD/stdcarsin "}")
			    varos=$(echo -n "$varos"|$PrPWD/stdcdr "}")
			    varos=$(echo -n "$varis)$varos")
			    len=$(echo -n "$varos"|$PrPWD/stdbuscaarg "{")
			done
			echo "$varos" >> "$utcc"
		    done
		    varis="ALGO";
		    while [ -n "$varis" ];do
			varis=$(echo -n ";$variables" |$PrPWD/stdcdr ";char"|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "["|$PrPWD/stdcarsin "=")
			varos=$(echo -n "$variables"|$PrPWD/stdcdr ";char$varis"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "["|$PrPWD/stdcdrcon "=")
			if [ -z "$varos" ];then
			    varos=$(echo -n "$variables"|$PrPWD/stdcdr ";char$varis"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdrcon "=")
			fi
			variables=$(echo -n "$variables"|$PrPWD/stddelcar ";char$varis")
			varos="$varis$varos;"
			len=$(echo -n "$varos"|$PrPWD/stdbuscaarg "{")
			while [ -n "$len" ];do
			    varis=$(echo -n "$varos"|$PrPWD/stdcarsin "{")
			    varos=$(echo -n "$varos"|$PrPWD/stdcdr "{")
			    varos=$(echo -n "$varis new Array ($varos")
			    varis=$(echo -n "$varos"|$PrPWD/stdcarsin "}")
			    varos=$(echo -n "$varos"|$PrPWD/stdcdr "}")
			    varos=$(echo -n "$varis)$varos")
			    len=$(echo -n "$varos"|$PrPWD/stdbuscaarg "{")
			done
			echo "$varos" >> "$utcc"
		    done
		fi
	    fi
	fi
    fi
fi
