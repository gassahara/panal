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
date +%s
remotepath="http://127.0.0.1/" #"185.27.134.11/htdocs"
lista0=$(curl -L "$remotepath/dirlistmt.php" 2>/dev/null | tr '
' ' ' )

PbPWD=$(echo "$PaPWD"|$PrPWD/stdcdr "$PrPWD")
busca=".."
echo "" |tr -d '
' |> $nomprograma.cha
posicion=0;
encuentra="ALGO"
while [ -n "$lista0" ];do
    listf=$(echo "$lista0" | $PrPWD/stdcarsin ' ' )
    lista0=$(echo "$lista0" | $PrPWD/stdcdr ' ' )
    echo -n "."
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;")
    if [ -z "$encuentra" -a -n "$listf" ];then
	tamano=$(echo "$listf"|tr -d '
' | wc -c | $PrPWD/stdcarsin ' ')
	tamano=$(expr 0$tamano - 3)
	encuentra=$(echo "$listf"|$PrPWD/stdcdrn $tamano| $PrPWD/stdbuscaarg ".js")
	if [ -z "$encuentra" ];then
	    echo ";$listf;" >> $nomprograma.memoria	    
	fi
	if [ -n "$encuentra" ];then
	    fn=$listf
	    slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	    while [ -n "$slash" ];do
		fn=$(echo "$fn" | $PrPWD/stdcdr "/" )
		slash=$(echo $fn | $PrPWD/stdbuscaarg_donde_hasta "/" )
	    done
	    curl -L  "$remotepath/$listf" 2>/dev/null > $fn #2>/dev/null
	    if [ -f "$fn" ];then
		opens=$(cat "$fn"|$PrPWD/stdbuscaarg_count "BEGIN PGP MESSAGE")
		closs=$(cat "$fn"|$PrPWD/stdbuscaarg_count "END PGP MESSAGE")
		balan=$(expr 0$opens - 0$closs )
		if [ 0$opens -gt 0 -a "$balan" = "0"  ];then
		    echo "> $opens : $closs < $balan $fn"
		    echo ";$listf;" >> $nomprograma.memoria
		    cat "$fn" | gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --secret-keyring $PrPWD/user/key.gpg --trustdb-name $PrPWD/user/trustdb.gpg  -d  2>/dev/null 1>$fn.c
		    balan=$(cat "$fn.c"|wc -c|$PrPWD/stddelcar " " )
		    if [ 0$balan -gt 0 ];then
			echo '/*' | tr -d '
' > $fn.tmp
			cat $fn.c >> $fn.tmp
			mv -v $fn.tmp $fn.c
			mains=$(cat "$fn.c"|$PrPWD/stdbuscaarg " main")
			opens=$(cat "$fn.c"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
			closs=$(cat "$fn.c"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
			balan=$(expr  0$opens - 0$closs)
			echo ">>> $opens : $closs <<< $balan ($mains)"
			if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    			    errors=$(gcc $fn.c 2>&1)
			    if [ -n "$errors" ];then
				echo "There are errors on $fn.c"
			    fi
			    #echo "$errors"
			    mkdir peticiones
			    if [ -z "$errors" ];then
				variables=$(cat $fn.c |$PrPWD/stddeclaracionesdevariable|tr '
' ';')
				userfromfile=$(echo ";$variables" |$PrPWD/stdcdr ";char *"|$PrPWD/stdcarsin "=")
				ttest=$(echo ";$variables" |$PrPWD/stdbuscaarg_donde_hasta ";int ")
				#				   echo "<<< ttest $ttest >>>"
				dondes=0
				while [ "0$ttest" -gt 0 ];do
				    dondes=$(($dondes+$ttest))
				    ivfromfile=$(echo ";$variables" |$PrPWD/stdcdrn $dondes|$PrPWD/stdcarsin ";")
				    echo "-> $ivfromfile"
				    len=$(echo $ivfromfile|$PrPWD/stdcdr "]"|$PrPWD/stdbuscaarg_donde_hasta "[16]")
				    len2=$(echo $ivfromfile|$PrPWD/stdbuscaarg_count "][")
				    if [ 0$len -gt 0 -a 0$len2 -eq 1 ];then
					ivfromfile=$(echo "$ivfromfile"|$PrPWD/stdcarsin "[16]"|$PrPWD/stdcarsin "[")
					break;
				    else
					ivfromfile=""
				    fi
				    ttest=$(echo ";$variables" |$PrPWD/stdcdrn $dondes|$PrPWD/stdbuscaarg_donde_hasta ";int ")
				    echo "<<< ttest $ttest d $dondes>>>"
				done
				ttest=$(echo ";$variables"| $PrPWD/stddelcar "int $ivfromfile"|$PrPWD/stdbuscaarg_donde_hasta ";int ")
				echo "________________________________________________________"
				#				   echo ";$variables"| $PrPWD/stddelcar "int $ivfromfile"
				echo "......................................................."
				echo "<<< ttest $ttest >>>"
				dondes=0
				while [ "0$ttest" -gt 0 ];do
				    dondes=$(($dondes+$ttest))
				    encryptedfromfile=$(echo ";$variables"| $PrPWD/stddelcar "int $ivfromfile"|$PrPWD/stdcdrn $dondes|$PrPWD/stdcarsin ";")
				    len2=$(echo $encryptedfromfile|$PrPWD/stdbuscaarg_count "][")
				    echo "($len2)> $encryptedfromfile"
				    if [ 0$len2 -eq 1 ];then
					encryptedfromfile=$(echo "$encryptedfromfile"|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "[")
					break;
				    else
					encryptedfromfile=""
				    fi
				    ttest=$(echo ";$variables"| $PrPWD/stddelcar "int $ivfromfile"|$PrPWD/stdcdrn $dondes|$PrPWD/stdbuscaarg_donde_hasta ";int ")
				    echo "<<< ttest $ttest d $dondes>>>"
				done
				filedfromfile=$(echo ";$variables" |$PrPWD/stdcdr ";FILE *"|$PrPWD/stdcarsin "="|$PrPWD/stdcarsin ";")
				ca5=$(echo "$userfromfile $ivfromfile $encryptedfromfile $filedfromfile"|$PrPWD/stdbuscaarg " 0")
				echo "<USER:$userfromfile> <IV:$ivfromfile> <ENC:$encryptedfromfile> <FILE:$filedfromfile> <CA:$ca5>"
				if [ -n "$userfromfile" -a -n "$ivfromfile" -a -n "$encryptedfromfile" -a -n "$filedfromfile" -a -z "$ca5" ];then
				    cat $fn.c |$PrPWD/stdcdr "*$userfromfile=" # |$PrPWD/stddelcar '"'
				    usuarioo=$(echo ";$variables" |$PrPWD/stdcdr "$userfromfile=" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ";");
				    echo "uU $usuarioo Uu $userfromfile uU"
				    if [ -f "$PrPWD/users/$usuarioo/$usuarioo-aes.c" ];then
					outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$outputdelc.c" ];do
					    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done
					echo "oOO $outputdelc OOo"
					arrayindex=$(cat $fn.c | $PrPWD/stdcdr "int$ivfromfile["  | $PrPWD/stdcarsin "]");
					dondes=0
					iv=$(echo "$variables" | $PrPWD/stdcdr "int$ivfromfile["  | $PrPWD/stdcarsin ";");
					msj=$(echo "$variables" | $PrPWD/stdcdr "int$encryptedfromfile["|$PrPWD/stdcarsin ";");
					filed=$(cat $fn.c | $PrPWD/stdcdr "$filedfromfile=" | $PrPWD/stdcdr "fopen(" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ",");
					c=0
					tail $PrPWD/users/$usuarioo/$usuarioo-aes.c
					echo "IV $ivfromfile $iv"
					cat $PrPWD/users/$usuarioo/$usuarioo-aes.c | $PrPWD/stdcar "unsigned char iv[" > $outputdelc.c
					echo "$iv;" >> $outputdelc.c
					cat $PrPWD/users/$usuarioo/$usuarioo-aes.c | $PrPWD/stdcdr "unsigned char iv[" | $PrPWD/stdcdr ";" >> $outputdelc.c

					cat $outputdelc.c | $PrPWD/stdcar "unsigned char buf[" > $outputdelc-2.c
					echo "$msj;" >> $outputdelc-2.c
					cat $outputdelc.c | $PrPWD/stdcdr "unsigned char buf[" | $PrPWD/stdcdr ";" >> $outputdelc-2.c
					mv $outputdelc-2.c $outputdelc.c

					echo "$outputdelc.c"
					tail $outputdelc.c
					errores=$(gcc -o $outputdelc-bin $outputdelc.c 2>&1)
					echo "< < < $errores > > >"
					if [ -z "$errores" ];then
					    datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    while [ -f "$datosdelc.c" ];do
						datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    done
					    $PaPWD/$outputdelc-bin
					    echo "$datosdelc.c"
					    echo "==================="
					    echo  "/*" |tr -d '
' > $datosdelc.c
					    $PaPWD/$outputdelc-bin | $PrPWD/stdcdr "buf[" | $PrPWD/stdcarsin ";" | $PrPWD/stdfromdec  >> $datosdelc.c
					    cat "$datosdelc.c"

					    errores=$(gcc -o $datosdelc-bin $datosdelc.c 2>&1)
					    echo ">>>> '!!!!!'          $errores <<<<"
					    if [ -z "$errores" ];then
						mkdir $PrPWD/users
						mkdir $PrPWD/users/input
						mkdir $PrPWD/users/input/$usuarioo
						cp -v $datosdelc.c $PrPWD/users/input/$usuarioo/
					    fi
					fi
				    else
					datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$datosdelc.c" ];do
					    datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done
					outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$outputdelc.c" ];do
					    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done
					echo "Error de usuario de nombre de usuario o contraseña"
					echo "errores=\"Error de usuario de nombre de usuario o contraseña\";" > $outputdelc
					echo "processed=255;" >> $outputdelc
				    fi
				    if [ -n "$errores" ];then
					echo "errores=\"Error de usuario de nombre de usuario o contraseña\";" > $outputdelc
					echo "processed=255;" >> $outputdelc
				    else
					echo "errores=\"Entrada registrada correctamente, en cuanto se encunetre procesada aparecera la respuesta en la lista de mensajes (con el titulo indicado en la entrada)\";" > $outputdelc
					echo "processed=255;" >> $outputdelc
				    fi
				    echo "encrypted="'`'|tr -d '
' > $datosdelc.js
				    cat $outputdelc | gpg -a --no-default-keyring --keyring $PrPWD/user/key.key  --sign  >> $datosdelc.js
				    echo '`'";"  >> $datosdelc.js
				    echo "processed=255;"  >> $datosdelc.js
				    #curl --retry-delay 5 --retry 30 --retry-all-errors --socks5-hostname 127.0.0.1:9050 --insecure  --user "$usuarioftp:$passwordftp" -T $datosdelc.js "ftp://$remotepath/panal/msgs/$filed"
				    cat $datosdelc.js
				else
				    echo "======================="
				    mkdir $PrPWD/users
				    mkdir $PrPWD/users/input
				    mkdir $PrPWD/users/input/unencrypted
				    cp -v $datosdelc.c $PrPWD/users/input/$usuarioo/
				    cp -v "$fn.c" "$PrPWD/users/input/unencrypted"
				    echo "$errores"
				fi
			    fi
			fi
		    fi
		fi
	    fi
	fi
    fi
done
$0&
