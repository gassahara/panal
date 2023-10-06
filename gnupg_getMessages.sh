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
remotepath="http://127.0.0.1/" #"185.27.134.11/htdocs"
cd $PrPWD
PrPWD2=$PWD
PrPWD=$PrPWD2
cd $PaPWD
#echo "$nomprograma.."
sleep 0.1
listados="";
game="RUEDA"
mkdir $PrPWD/user/$game
name=$(echo "$game"| tr -d [' 
'] | sha512sum | $PrPWD/stdcarsin ' ')
lname=$(echo "$name"| tr -d [' 
'] | wc -c)
lname=$(expr $lname + 3)
echo "NAME    $name"
sha=""
encuentra=".."
while [ -n "$encuentra" ];do
    sha=$(echo "$name $count"| tr -d " " | tr -d '
' | sha512sum | $PrPWD/stdcarsin " ")
    respuesta=$(curl -L "$remotepath/fretfile.php?fname=$sha.js")
    echo "$respuesta" 
    encuentra=$(echo "$respuesta" |$PrPWD/stdbuscaarg 'Success')
    if [ -n "$encuentra" ];then
	gpg  --homedir $PrPWD/user/$game/ --no-default-keyring --keyring $PrPWD/user/$game/key.key --trustdb-name $PrPWD/user/$game/trustdb.gpg --armor  --decrypt
    fi
    count=$(expr "$count" + 1)
    echo "$name $count"| tr -d " " | tr -d '
' | sha512sum | $PrPWD/stdcarsin " "
done			    

