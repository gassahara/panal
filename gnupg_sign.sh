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
usuario=$(gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg  --list-secret-keys --with-colons  | awk -F: '/^sec/{print $5}'|head -n1|$PrPWD/stdcarsin '
')
echo $PrPWD/user
echo $PaPWD/public
gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f ./public - | gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --sign | gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f ./public
