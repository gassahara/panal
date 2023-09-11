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
echo "$nomprograma..   - - -    $PrPWD - - - -  bash $PrPWD/querydescargausuario1.sh"
sleep 1
namo="descargausuario"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querydescargausuario3.sh"
screen -S $namo -X stuff  $'\r'
namo="buscausuario"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsusuario3.sh"
screen -S $namo -X stuff  $'\r'
namo="registeruser"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsremgisteruser.sh"
screen -S $namo -X stuff  $'\r'
namo="stampcollector"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsstampcollector.sh"
screen -S $namo -X stuff  $'\r'
