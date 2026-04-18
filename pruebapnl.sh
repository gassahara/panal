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

    listc=$(curl -L "https://fapi.binance.com/fapi/v1/ticker/24hr")
    listp=""
    encuentra="ALGO"
    while [ -n "$encuentra" ];do
	symbol=$(echo -n "$listc"|$PrPWD/stdcdr '"symbol":'|$PrPWD/stdcarsin ","|$PrPWD/stddelcar '"')
	echo "<>$symbol<>"
	encuentra=$(echo "$listp"|$PrPWD/stdbuscaarg "$symbol;")
	if [ -z "$encuentra" ];then
	    listp=$(echo -n "$symbol ; $listp"|$PrPWD/stddelcar ' ')
	fi
	listc=$(echo -n "$listc" | $PrPWD/stdcdr '"symbol":')
	encuentra=$(echo -n "$listc"|$PrPWD/stdbuscaarg '"symbol":')
    done
    listp=$(echo -n "; $listp"|$PrPWD/stddelcar ' ')
    pares="$PrPWD/binance_pares.key"
    echo "$listp" > "$pares"
    dondet=$( cat "$pares" |$PrPWD/stdbuscaarg_donde ';')
    posicionb=0
    while [ -n "$dondet" ];do
	listp=$(cat "$pares" | $PrPWD/stdcdrn "0$posicionb"|$PrPWD/stdcarsin ';')
	posicionb=$(echo "$dondet" |$PrPWD/stdcarsin " ")
	posicionb=$(expr 0$posicionb + 1)
	dondet=$(echo "$dondet" |$PrPWD/stdcdr " ")
	symbol=$(echo -n "$listp" | $PrPWD/stdcarsin ';')
	echo ">    >    $symbol"
        times=$(date +%s%N|$PrPWD/stdcarn 13) 
        params="recvWindow=5000&startTime=1633060800000&symbol=$symbol&timestamp=$times"
        signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$secretKey" | $PrPWD/stdcdr "= ")
	res=$(curl -H "X-MBX-APIKEY: $apikey" -L "https://fapi.binance.com/fapi/v1/income?$params&signature=$signature")
	echo "%^%^%^%^%^%^%^%^%^%^%^%^%"
	echo $res
    done
done
