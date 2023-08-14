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
sleep 0.1
archivo="$PrPWD/binance.key"
dondes=$( cat "$archivo" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
posiciona=0
while [ -n "$dondes" ];do
    listf=$(cat "$archivo" | $PrPWD/stdcdrn "0$posiciona"|$PrPWD/stdcarsin '
')
    echo "* ****** ******   *****      $listf"
    posiciona=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posiciona=$(expr 0$posiciona + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    cabecera="";
    filas=""
    user=$(echo -n "$listf" | $PrPWD/stdcarsin ';')
    archnombrejs=$(date +"%s")
    archnombrejs=$(echo -n "$user-$archnombrejs"|sha512sum|$PrPWD/stdcarsin " ")
    secretKey=$(echo -n "$listf" | $PrPWD/stdcdr ';'|$PrPWD/stdcarsin ';')
    apikey=$(echo -n "$listf" | $PrPWD/stdcdr ';'|$PrPWD/stdcdr ';'|$PrPWD/stdcarsin ';')
	echo "$user"
	echo "$apikey"
	echo "$secretKey"
        timet=$(date --date "09/30/2021" +%s%N|$PrPWD/stdcarn 13) 
        times=$(date +%s%N|$PrPWD/stdcarn 13) 
        params="recvWindow=5000&timestamp=$times"
        signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$secretKey" | $PrPWD/stdcdr "= ")
	res=$(curl -H "X-MBX-APIKEY: $apikey" -L "https://fapi.binance.com/fapi/v1/leverageBracket?$params&signature=$signature")
	echo "%^%^%^%^%^%^%^%^%^%^%^%^%"
	echo $res
done
