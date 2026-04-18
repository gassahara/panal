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
bash $PrPWD/querydescargausuario1.sh > querydescargausuario1.sh.log
bash $PrPWD/querydescargausuario2.sh > querydescargausuario2.sh.log
bash $PrPWD/querybuscacsusuario1.sh > querybuscacsusuario1.sh.log
bash $PrPWD/querybuscacsusuario3.sh > querybuscacsusuario3.sh.log
bash $PrPWD/querybuscacsclientes.sh > querybuscacsclientes.sh.log
