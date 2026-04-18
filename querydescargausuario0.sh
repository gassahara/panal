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
usuarioftp="b14_26624723"
passwordftp="Effata1581"
remotepath="ftpupload.net/htdocs"
sleep 2
listados="";
listado="";
lista0="";
if [ -d "$PrPWD/users/output" ];then
     listados=$(echo "$PrPWD/users/output"|$PrPWD/listadodirectorio_dirs_from_std|$PrPWD/stdbuscaarg_donde '
')
    listado=$(echo "$PrPWD/users/output"|$PrPWD/listadodirectorio_dirs_from_std)
    salta=0;
    while [ -n "$listados" ];do
	presalta=$(echo -n "$listados" | $PrPWD/stdcar " ")
	dirn=$(echo -n "$listado"|$PrPWD/stdcdrn 0$salta | $PrPWD/stdcarn $presalta)
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std)
	lista0="$lista0$lista1"
	salta=$(expr "$presalta + 1")
	listados=$(echo -n "$listados" | $PrPWD/stdcdr " ")
    done
fi
busca=".."
posicion=0;
dondes=$( echo "$lista0" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=$(echo "$listf"|$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
    if [ -z "$encuentra" ];then
	echo ";$listf;$chacha;" >> $nomprograma.memoria
    fi
done
listaa=$(curl  --insecure  "ftp://$remotepath/panal/msgs/"  -X MLSD --user "$usuarioftp:$passwordftp"  2>/dev/null | $PrPWD/stdcdr '..
')

busca=".."
posicion=0;
dondes=$( echo "$listaa" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    posicion2=$(echo "$dondes"|$PrPWD/stdcarsin " ")
    posicion2=$(expr 0$posicion2 - 0$posicion + 1)
    listf=$(echo "$listaa" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarn $posicion2)
    sizelistf=$(echo -n "$listf" | $PrPWD/stdcdr "size="|$PrPWD/stdcar ";")
    listf=$(echo "$listaa" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarn $posicion2|$PrPWD/stdcdr " ")
    listf=$(echo -n "$sizelistf$listf")
    posicion=$(expr 0$posicion2 + $posicion)
    dondes=$(echo -n "$dondes" |$PrPWD/stdcdr " ")
    chacha=$(echo -n " $listf"|$PrPWD/stdtohex |$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -n "$dondes" ];then
    $0 &
else
    ps1=3
    while [ 0$ps1 -gt 2 ];do
    	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
    	sleep 2
    done
    $0 &
fi
if [ -z "$encuentra" -a -n "$listf" ];then
    fn=$(echo -n "$listf"|$PrPWD/stdcdr ";" )
    tamano=$(echo -n "$listf"|$PrPWD/stdcarsin ";" )
    echo "<< fn $fn ($listf) >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	while [ -n "$slash" ];do
	    fn=$(echo "$fn" | $PrPWD/stdcdr "/" )
	    slash=$(echo $fn | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
	#    	echo "0 $busca ($fn)"
	len=$(echo -n "$fn"|wc -c)
	if [ 0$len -gt 0 -a ! -f "$fn" ];then
	    len=1
	    while [ $len -lt $tamano ];do
		curl  --insecure  "ftp://$remotepath/panal/msgs/$fn" --user "$usuarioftp:$passwordftp" 2>/dev/null 1>$fn
		len=$(dd if=$fn bs=1 2>/dev/null|wc -c)
	    done
	fi
	if [ 0$len -gt 0 -a  -f "$fn" ];then
	    opens=$(cat "$fn"|$PrPWD/stdbuscaarg_count "BEGIN PGP MESSAGE")
	    closs=$(cat "$fn"|$PrPWD/stdbuscaarg_count "END PGP MESSAGE")
	    balan=$(( $opens-$closs ))
	    if [ 0$opens -gt 0 -a "$balan" = "0"  ];then
		echo ";$listf;$chacha;" >> $nomprograma.memoria
		cat $fn | gpg -a --no-default-keyring --keyring $PrPWD/user/key.key  -d 2>/dev/null 1>$fn.$nomprograma
		mv "$fn.$nomprograma" "$fn.c"
	    fi
	fi
    fi
fi

