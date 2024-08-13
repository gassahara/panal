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
remotepath=$(cat $PrPWD/host.c|$PrPWD/stddeclaracionesdevariable | $PrPWD/stdcdr host|$PrPWD/stdcdr = |$PrPWD/stdcdr '"'|$PrPWD/stdcarsin '"')
cd $PrPWD
PrPWD2=$PWD
PrPWD=$PrPWD2
cd $PaPWD
#echo "$nomprograma.."
sleep 0.1
listados="";
game="RUEDA"
mkdir $PrPWD/user/$game
gpg --homedir $PrPWD/user/$game --passphrase "" --no-default-keyring --keyring $PrPWD/user/$game/key.key --secret-keyring $PrPWD/user/$game/key.gpg --trustdb-name $PrPWD/user/$game/trustdb.gpg --batch --quick-generate-key "user@server.com" rsa4096 encr,sign 0
#public=$(gpg  --homedir $PrPWD/user/$game/ --no-default-keyring --keyring $PrPWD/user/$game/key.key --trustdb-name $PrPWD/user/$game/trustdb.gpg --armor --export|base64|tr -d '
#')
public=$(echo 'var rsaPublicKey=\`' $(gpg  --homedir $PrPWD/user/$game/ --no-default-keyring --keyring $PrPWD/user/$game/key.key --trustdb-name $PrPWD/user/$game/trustdb.gpg --armor --export) '\` ; ' | base64 | tr -d '
' )
name=$(echo "$game"| tr -d [' 
'] | sha512sum | $PrPWD/stdcarsin ' ')
lname=$(echo "$name"| tr -d [' 
'] | wc -c)
lname=$(expr $lname + 3)
echo "NAME    $name"
utcc=$(dd if=/dev/random bs=1 count=32 skip=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " " | sha512sum | $PrPWD/stdcarsin ' ')
dirfn="$PaPWD"
while [ -f "$dirfn/$utcc.c" ];do
    utcc=$(dd if=/dev/random bs=1 count=32 skip=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " " | sha512sum | $PrPWD/stdcarsin ' ')
done
lcontentExtra=$(echo $public|tr -d '
'|wc -c)
echo $($PrPWD/aleatorio) '
#include <stdio.h>
' $($PrPWD/aleatorio) '
int main(int argc, char *argv[]){' $($PrPWD/aleatorio) '
;' "char nameofindex[$lname]=\"$name.js\";$($PrPWD/aleatorio) char command[8]=\"REGISTER\"; $($PrPWD/aleatorio) char content[7]=\"content\"; $($PrPWD/aleatorio)"'
char contentExtra'"[$lcontentExtra]=\"$public\"; $($PrPWD/aleatorio) }" > $utcc.c
echo '-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=5EZI
-----END PGP PUBLIC KEY BLOCK-----' > $utcc.public
echo $utcc.c
gcc $utcc.c
variables=$(curl -L $remotepath/formalm.php|tr -d '"')
iv_OTP=$(echo "$variables" | $PrPWD/stdcdr "iv_OTP=" | $PrPWD/stdcarsin ";")
OTP_resource=$(echo "$variables" | $PrPWD/stdcdr "OTP_resource=" | $PrPWD/stdcarsin ";")
OTP=$(echo "$variables" | $PrPWD/stdcdr " OTP=" | $PrPWD/stdcarsin ";")
echo "$variables"
encryptedoutput=$(cat $utcc.c| gpg  --homedir $PrPWD/user/$game/ --no-default-keyring --keyring $PrPWD/user/$game/key.key --trustdb-name $PrPWD/user/$game/trustdb.gpg --armor  --encrypt -f $utcc.public)
namepublic=$(echo "$name.js public"| tr -d ' ' | sha512sum | $PrPWD/stdcarsin ' ')
echo "NAME    $name"
echo "PUBLIC  $namepublic"
respuestaa=$(curl -L "$remotepath/fretfile.php?fname=$name.js" 2>/dev/null | $PrPWD/stdcdr '"'  | $PrPWD/stdcarsin '"' )
respuestab=$(curl -L "$remotepath/fretfile.php?fname=$namepublic.js" 2>/dev/null | $PrPWD/stdcdr '"'  | $PrPWD/stdcarsin '"' )
respuesta=$(echo "$respuestaa $respuestab")
encuentra=$(echo "$respuesta" |$PrPWD/stdbuscaarg 'Not Found Not Found')
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   $respuesta   ($encuentra $encuentrac) ($namepublic)"
if [ -n "$encuentra" ] ; then
    curl -vvvv -X POST -L $remotepath/formalm.php -F "OTP=$OTP" -F "iv_OTP=$iv_OTP" -F "OTP_resource=$OTP_resource" -F "texto2=$encryptedoutput"
fi
