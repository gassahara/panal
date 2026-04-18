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
$PrPWD/listadodirectorio_files_extension .c|$PrPWD/stdtohex > $nomprograma.lis
busca=".."
echo -n "" > $nomprograma.cha
posicion=0;
dondes=$( cat "$nomprograma.lis" |$PrPWD/stdbuscaarg_donde "0A")
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(cat "$nomprograma.lis" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin "0A"|$PrPWD/stdfromhex)
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=$(echo "$listf"|$PrPWD/stdtohex |$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done

if [ -n "$dondes" ];then
    $0 &
else
    ps1=3
    while [ 0$ps1 -gt 2 ];do
    	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
    	sleep 0.5
    done
    $0 &
fi
if [ -z "$encuentra" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	while [ -n "$slash" ];do
	    fn=$(echo "$fn" | $PrPWD/stdcdr "/" )
	    slash=$(echo $fn | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
    	echo "0 $busca ($fn)"
	len=$(cat "$fn"|wc -c)
	if [ 0$len -gt 0 -a -f "$fn" ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(echo "$opens-$closs"|bc)
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		ejec="$fn.$nomprograma.bin"
    		gcc -o $ejec $fn
		echo "$ejec"
		echo -n ""|./$ejec
		reit=$(echo -n ""|./$ejec|$PrPWD/stdhttpgetfilepdfscomprueba )
		echo "<< $reit >>"
		if [ -n "$reit" ];then
		    echo ";$listf;$chacha;" >> $nomprograma.memoria
    		    archivo=$(echo -n ""|$PaPWD/$ejec |$PrPWD/stdhttp | $PrPWD/stdunescape)
		    archivo=$(echo "$PrPWD$archivo")
		    echo $archivo|$PrPWD/stdhttpgetfilepdf|./$ejec 1>/dev/null
    		    mkdir peticiones
    		    mv $fn peticiones/
    		    echo "%%%%%%%%%"
    		    exit
		fi
	    fi
	fi
    fi
fi

