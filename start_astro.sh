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
namo="descargausuariobyet"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querydescargausuario3.sh"
screen -S $namo -X stuff  $'\r'
namo="descargausuariowh"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querydescargausuario3wh.sh"
screen -S $namo -X stuff  $'\r'
namo="buscausuario"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsusuario3.sh"
screen -S $namo -X stuff  $'\r'
namo="buscaastro"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsastro1.sh"
screen -S $namo -X stuff  $'\r'
namo="buscaswe"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsswehazeclipticomes.sh"
screen -S $namo -X stuff  $'\r'
namo="indiceastr"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsastroenoutputaindex.sh"
screen -S $namo -X stuff  $'\r'
namo="remoastr"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscacsremovehreffromindex.sh"
screen -S $namo -X stuff  $'\r'
namo="indiceswe"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querybuscajsastrotransitosenoutputaindex.sh"
screen -S $namo -X stuff  $'\r'
namo="subebyet"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querysubeusuario0.sh"
screen -S $namo -X stuff  $'\r'
namo="subewh"
screen -dmS $namo
sleep 1
screen -S $namo -X stuff  "bash $PrPWD/querysubeusuariowebhost.sh"
screen -S $namo -X stuff  $'\r'
