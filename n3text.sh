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
#echo "$nomprograma.."
sleep 0.1
$PrPWD/listadodirectorio_files_extension .c > $nomprograma.lis
busca=".."
printf "%s" "" > $nomprograma.cha
posicion=0;
dondes=$( cat "$nomprograma.lis" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(cat "$nomprograma.lis" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr $posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=$(echo "$listf"|$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done

if [ -n "$dondes" ];then
    $0 &
else
    ps1=3
    while [ 0$ps1 -gt 20 ];do
    	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
	echo "wait"
    	sleep 0.5
    done
    $0 &
fi
if [ -z "$encuentra" -a -n "$listf" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(printf "%s" "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then

	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	while [ -n "$slash" ];do
	    fn=$(echo "$fn" | $PrPWD/stdcdr "/" )
	    slash=$(echo $fn | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
    	echo "0 $busca ($fn)"
	cat "$fn"|wc -c
	len=$(cat "$fn"|wc -c | $PrPWD/stddelcar " ")
	echo ">>>>>    ($len) ($fn)"
	if [ 0$len -gt 0 ];then
	    if [ -f "$fn" ];then
		mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
		opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
		closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
		echo "$opens-$closs"
		balan=$(echo "$opens-$closs"|bc)
		if [ -n "$opens" -a "$opens" != "0" -a "$balan" = "0" -a -n "$mains" ];then
 		    ejec="$fn.$nomprograma.bin"
		    echo "E: $ejec"
		    errores=$(gcc -o "$ejec" "$fn" 2>&1 )
		    echo "     !!!!      $errores"   #borrar
		    if [ -z "$errores" ];then
			echo "$ejec $PrPWD"
			varis=""
			varis=$(cat "$fn" | $PrPWD/stdcdr "fopen"|$PrPWD/stdcarsin ";"|$PrPWD/stdbuscaarg ".in")
			if [ -n "$varis" ];then
			    namo=$(cat "$fn" | $PrPWD/stdcdr "fopen"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr '"'|$PrPWD/stdcar ".in")
			fi
			varus=$(cat "$fn" | $PrPWD/stdcdr "fopen"|$PrPWD/stdcarsin ";"|$PrPWD/stdbuscaarg ".out")
			varos="$varos$varis$varus"
			varis=""
			varis=$(cat "$fn" | $PrPWD/stdcdr "fopen"|$PrPWD/stdcdr "fopen"|$PrPWD/stdcarsin ";"|$PrPWD/stdbuscaarg ".in")
			if [ -n "$varis" ];then
			    namo=$(cat "$fn" | $PrPWD/stdcdr "fopen"|$PrPWD/stdcdr "fopen"|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr '"'|$PrPWD/stdcar ".in")
			fi
			varus=$(cat "$fn" | $PrPWD/stdcdr "fopen"|$PrPWD/stdcdr "fopen"|$PrPWD/stdcarsin ";"|$PrPWD/stdbuscaarg ".out")
			varos="$varos$varis$varus"
			echo "< < < $varos > > >"
			if [ "$varos" = "**" ];then
			    echo " - - - - - - - - - - - - - - - - - - $namo  - - - - - - - - - - - -"
			    varis=$(cat "$namo" | $PrPWD/stdcarn 4)
			    varos=$(echo -n "$varis"|wc -c |$PrPWD/stdcarsin " ")
			    if [ -n "$varis" ];then
				if [ "$varis" = "POST" ];then
					echo ";$listf;$chacha;" >> $nomprograma.memoria
				    bound=$(cat "$namo"|$PrPWD/stdcdr "boundary="|$PrPWD/stdcarsin '
')
				    utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$dirfn/$utcc.c" ];do
					utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    cat "$namo"|$PrPWD/stdcdr "$bound"|$PrPWD/stdcdr "$bound"|$PrPWD/stdcar "$bound" > $utcc
				fi
				if [ "$varis" = "GET " ];then
				    varus=$(cat "$namo" | $PrPWD/stdtohex | $PrPWD/stdbuscaarg "0D 0A 0D 0A")
				    echo "$varis .... $varus "
				    if [ -n "$varus" ];then
					echo ";$listf;$chacha;" >> $nomprograma.memoria
					cat "$namo"
    					r2t=$(echo -n ""|./$ejec |$PrPWD/stdhttp | $PrPWD/stdunescape| $PrPWD/stdhttpgetfilehtmlcomprueba )
					echo "<: $r2t :>"
    					cont=$(echo -n ""|./$ejec | $PrPWD/stdhttpcontent )
					echo "$cont"
    					if [ -n "$r2t" -a -z "$cont" ];then
    					    echo "TEXTO 2 > $1 <"
    					    archivo=$(printf "%s" ""|$PaPWD/$ejec |$PrPWD/stdhttp | $PrPWD/stdunescape)
					    archivo=$(echo "$PrPWD/$archivo")
					    echo $archivo
					    echo $archivo  | uconv -t utf8|  $PrPWD/stdhttpgetfilehtml | uconv -t utf8|$PaPWD/$ejec 1>/dev/null
					    namo=$(echo -n "$namo"|$PrPWD/stdcarsin ".in")
					    varos=$(diff "$namo.rr" "$namo.out")
					    while [ -n "$varos" ];do
						sleep 1
						echo " . . . . . . . . . . . . waiting"
						varos=$(diff "$namo.rr" "$namo.out")
					    done
					    mv -v "$namo.out" peticiones/
    					    mkdir peticiones
    					    mv $fn peticiones/
    					    mv $fn.* peticiones/
    					    echo "%%%%%%%%%"
    					    exit
					fi
				    fi
				else
				    echo ";$listf;$chacha;" >> $nomprograma.memoria
				fi
			    else
				varis=$(cat "$fn" | $PrPWD/stdcdr "int pid="|$PrPWD/stdcarsin ";")
				echo "ps $varis"
				if [ -n "$varis" ];then
				    varus=$(ps -Am | $PrPWD/stdbuscaarg "$varis ")
				    echo "[ . $varus .]"
				    if [ -z "$varus" ];then
					echo ";$listf;$chacha;" >> $nomprograma.memoria						
				    fi
				fi
			    fi
    			else
			    echo ";$listf;$chacha;" >> $nomprograma.memoria
			fi
		    fi
		fi
	    fi
	fi
    fi
fi
