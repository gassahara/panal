#!/bin/bash
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
mkdir ../user/
touch ../user/key.key ../user/trustdb.gpg
n=$(gpg --no-default-keyring --keyring ../user/key.key --trustdb-name ../user/trustdb.gpg --export -a|wc -c)
if [ 0$n -lt 1 ];then
    echo "<<$n>>"
    gpg --batch --passphrase "" --yes --no-default-keyring --keyring ../user/key.key --trustdb-name ../user/trustdb.gpg  --quick-generate-key "$USER" rsa4096 encr,sign 0
fi
if [ -f "../user/public_key.js" ];then
    echo "var pubk=\`$(gpg --no-default-keyring --keyring ../user/key.key --trustdb-name ../user/trustdb.gpg --export -a)\`;" > ../user/public_key.js
fi
fn="../user/public.pem"
touch "$fn"
size=$(cat "$fn" | wc -c | $PrPWD/stdcarsin ' ')
opens=$(cat "$fn"|$PrPWD/stdbuscaarg_count "BEGIN PUBLIC KEY")
closs=$(cat "$fn"|$PrPWD/stdbuscaarg_count "END PUBLIC KEY")
echo "$size $open $closs"
if [ -z "$opens" -o "0$opens" -eq 0 ];then
    openssl genpkey -algorithm RSA -out ../user/private.pem -pkeyopt rsa_keygen_bits:4096
    openssl rsa -pubout -in ../user/private.pem -out ../user/public.pem
fi
