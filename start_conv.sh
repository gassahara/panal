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
echo "$nomprograma..   - - -    $PrPWD - - - -  bash $PrPWD/querydescargausuario4.sh"
sleep 1
namo="descargausuario"
screen -dmS $namo
sleep 1
rm $PrPWD/data/querydescarga.l*
rm $PrPWD/data/querydescargausuario4.sh.lista0
screen -S $namo -X stuff  "bash $PrPWD/querydescargausuario4.sh"
screen -S $namo -X stuff  $'\r'
#namo="buscausuario"
#screen -dmS $namo
#sleep 1
#screen -S $namo -X stuff  "bash $PrPWD/querybuscacsusuario3.sh"
#screen -S $namo -X stuff  $'\r'
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

namo="stampcontracts"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsstampcontractbox.sh"
screen -S $namo -X stuff  $'\r'

namo="ppv"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsstampPPV.sh"
screen -S $namo -X stuff  $'\r'

namo="beacons"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "python $PrPWD/beacons.py"
screen -S $namo -X stuff  $'\r'
