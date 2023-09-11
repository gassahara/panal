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
listados="";
listado="";
montos=$($PrPWD/bills)
busca="ALGO"
tokendir="$PrPWD/users/tokensNew"
mkdir "$tokendir"
while [ -n "$busca" ];do
    monto=$(echo "$montos" | $PrPWD/stdcarsin ',')
    mkdir "$tokendir/$monto" 2>/dev/null
    uid1=$(dd if=/dev/random bs=1 skip=2000 count=8 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    uid2=$(dd if=/dev/random bs=1 skip=2000 count=8 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    uid3=$(dd if=/dev/random bs=1 skip=2000 count=8 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    uid4=$(dd if=/dev/random bs=1 skip=2000 count=8 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    datee=$(date +%s)
    utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    while [ -f "$tokendir/$monto/$utcc.c" ];do
	utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    done
    utcl=$(echo "$utcc"|tr -d '
' | wc -c)
    c=" $($PrPWD/aleatorio) int main() {  $($PrPWD/aleatorio) char fname[$utcl]=\"$utcc\"; $($PrPWD/aleatorio) long date=$datee;  $($PrPWD/aleatorio) long ammount=$monto;  $($PrPWD/aleatorio)  long uid1=0x$uid1;  $($PrPWD/aleatorio)  long uid2=0x$uid2;  $($PrPWD/aleatorio)  long uid3=0x$uid3;  $($PrPWD/aleatorio)  long uid4=0x$uid4;}"
    echo "$c" > "$tokendir/$monto/$utcc.c"
    gcc "$tokendir/$monto/$utcc.c"
    montos=$(echo "$montos" | $PrPWD/stdcdr ',')
    busca=$(echo "$montos" | $PrPWD/stdbuscaarg ",")
done
