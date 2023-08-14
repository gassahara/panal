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
	lista1=$($PrPWD/listadodirectorio_files_extension .req )
	lista0=$lista1
	echo "$lista0"
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
	    cd "$PrPWD"
	    reit=$(cat "$fn" | ./stdhttpgetfilehtmlcomprueba )
	    echo "$reit" > "$fn.std"
	    cd "$PaPWD"
	    if [ -z "$reit" ];then
		cd "$PrPWD"
		reix=$(cat "$fn" | ./stdhttpgetfileimagenescomprueba )
		reiu=$(cat "$fn" | ./stdhttpgetfilepdfscomprueba )
		reit=$(echo "$reix$reiu")
		cd "$PaPWD"
		if [ -z "$reit" ];then
		    echo "BB $fn "
		    rer=$(cat "$fn.in" | $PrPWD/stdhttprange > "$fn.rer")
		    if [ -z "$rer" ];then
			cd "$PrPWD"
			cat "$fn" | ./stdhttpgetfileoctect > "$fn.reb"
			cd "$PaPWD"
		    else
			cd "$PrPWD"
			echo "RANGO"
			cat "$fn" "$fn.rer" | ./stdhttpgetfileoctect-range > "$fn.reb"
			cd "$PaPWD"
		    fi
		    reit=$(cat "$fn.reb" | $PrPWD/stdcarn 1 )
		    if [ -n "$reit" ];then
			mv -v "$fn.reb" "$fn.out"
			pss="A"
			while [ -f "$pn.out" -a "$pss" != "Z" ];do
			    sleep 0.05
			    echo -n "($pss)"
			    pss=$(ps -A --no-headers -o "pid,state,command" | $PrPWD/stdcdr "$pn "|$PrPWD/stdcarsin " ")
			done
			kill $pn
			echo "BINARIO"
			mkdir peticiones
			mv $fn.in peticiones/
			mv $fn peticiones/
			mv $fn.reb peticiones/
			mv $fn.rer peticiones/
			mv procesados/$nomprograma peticiones/
			exit
		    fi
		fi
		mv $fn.reb peticiones/
		mv $fn.rer peticiones/
	    fi
	fi
    fi
fi
