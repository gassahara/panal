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
#echo "$nomprograma.."
sleep 0.1
archivo="$PrPWD/binance.key"
dondes=$( cat "$archivo" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
listc=$(curl -L "https://api.binance.com/api/v3/ticker/24hr")
listp=""
listq=""
encuentra="ALGO"
nomlistq=$(echo "$nomprograma -listq"|$PrPWD/stddelcar ' ')
echo $nomlistq
while [ -n "$encuentra" ];do
    symbol=$(echo "$listc"|$PrPWD/stdcdr '"symbol":'|$PrPWD/stdcarsin ","|$PrPWD/stddelcar '"')
    symbolq=$(echo "$listc"|$PrPWD/stdcdr '"symbol":'|$PrPWD/stdcarsin ","|$PrPWD/stddelcar '"'|$PrPWD/stdcarsin "USDT"|$PrPWD/stddelcar ' ')
    echo "<>$symbol<>"
    encuentra=$(echo "$listp"|$PrPWD/stdbuscaarg "$symbol;")
    if [ -z "$encuentra" ];then
	listp=$(echo "$symbol;$listp"|$PrPWD/stddelcar ' ')
        echo "$symbolq ;" >> "$nomlistq"
    fi
    listc=$(echo "$listc" | $PrPWD/stdcdr '"symbol":')
    encuentra=$(echo "$listc"|$PrPWD/stdbuscaarg '"symbol":')
done
listq=$(cat "$nomlistq"|sort|uniq|$PrPWD/stddelcar '
')
pares="$PrPWD/binance_pares.key"
cat $PrPWD/stdbuscaarg_varios_donde.c | $PrPWD/stdcar "char separador=" > $PrPWD/stdbuscaarg_binance.c
echo "';';" >> $PrPWD/stdbuscaarg_binance.c
cat $PrPWD/stdbuscaarg_varios_donde.c | $PrPWD/stdcdr "char separador=" | $PrPWD/stdcdr ";" | $PrPWD/stdcar " char search" >> $PrPWD/stdbuscaarg_binance.c
cuantos=$(echo -n "$listq"|wc -c | $PrPWD/stdcarsin " ")
cuantos=$(expr $cuantos + 1)
echo "[$cuantos]=\"$listq\";" >>  $PrPWD/stdbuscaarg_binance.c
cat  $PrPWD/stdbuscaarg_varios_donde.c | $PrPWD/stdcdr "char search" | $PrPWD/stdcdr '
' | $PrPWD/stdcar " int longitudes[" >>  $PrPWD/stdbuscaarg_binance.c
ns=$(echo "$listq" | $PrPWD/stdbuscaarg_count ";")
ns=$(expr $ns + 1)
echo -n "$ns];" >>  $PrPWD/stdbuscaarg_binance.c
cat  $PrPWD/stdbuscaarg_varios_donde.c | $PrPWD/stdcdr " int longitudes[" | $PrPWD/stdcdr ';' | $PrPWD/stdcar " int aciertos[" >> $PrPWD/stdbuscaarg_binance.c
echo -n "$ns];" >>  $PrPWD/stdbuscaarg_binance.c
cat  $PrPWD/stdbuscaarg_varios_donde.c | $PrPWD/stdcdr " int aciertos[" | $PrPWD/stdcdr '
'  >>  $PrPWD/stdbuscaarg_binance.c
gcc $PrPWD/stdbuscaarg_binance.c -o $PrPWD/stdbuscaarg_binance -Wall 
echo "$listp" > "$pares"
