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
sleep 2
listados="";
listado="";
lista0=$($PrPWD/listadodirectorio_files_extension .c )
PbPWD=$(echo "$PaPWD"|$PrPWD/stdcdr "$PrPWD")
busca=".."
posicion=0;
dondes=$( echo "$lista0" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    if [ -z "$listf" ];then
	encuentra="ALGO"
	continue;
    fi
    chacha=$(cat "$listf"|$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -z "$encuentra" ];then
    echo ";$listf;$chacha;" >> $nomprograma.memoria
fi
ps1=1
while [ -f "$nomprograma.lock-$ps1" ];do
    if [ 0$ps1 -lt 2 ];then
	echo "W W W W W W W W W W W W W   $ps1"
	ps1=$(expr 0$ps1 + 1)
    else
	ps1=1
	sleep 1
    fi
done
    $0 &
if [ -z "$encuentra" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	while [ -n "$slash" ];do
	    fn=$(echo "$fn" | $PrPWD/stdcdr "/" )
	    slash=$(echo $fn | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
    	echo "0 $busca ($fn)"
	len=$(cat "$fn"|wc -c|tr -d ' ')
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - $closs)
	    echo "main $mains opens $opens closs $closs "
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		ejec="$fn.$nomprograma.bin"
		errores=$(gcc -o ./$ejec $fn 2>&1 )
		if [ -z "$errores" ];then
		    variables=$(cat $fn |$PrPWD/stddeclaracionesdevariable|$PrPWD/stddelcar '
')
		    userfromfile=$(echo ";$variables" |$PrPWD/stdcdr ";char *"|$PrPWD/stdcarsin "=")
		    ttest=$(echo ";$variables" |$PrPWD/stdbuscaarg_donde_hasta ";int ")
		    dondes=0
		    while [ "0$ttest" -gt 0 ];do
			dondes=$(($dondes+$ttest))
			ivfromfile=$(echo ";$variables" |$PrPWD/stdcdrn $dondes|$PrPWD/stdcarsin ";")
			len=$(echo $ivfromfile|$PrPWD/stdcdr "]"|$PrPWD/stdbuscaarg_donde_hasta "[16]")
			len2=$(echo $ivfromfile|$PrPWD/stdbuscaarg_count "][")
			if [ 0$len -gt 0 -a 0$len2 -eq 1 ];then
			    ivfromfile=$(echo "$ivfromfile"|$PrPWD/stdcarsin "["|$PrPWD/stddelcar " ")
			    break;
			else
			    ivfromfile=""
			fi
			ttest=$(echo ";$variables" |$PrPWD/stdcdrn $dondes|$PrPWD/stdbuscaarg_donde_hasta ";int ")
		    done

		    ttest=$(echo ";$variables"| $PrPWD/stddelcar "int $ivfromfile"|$PrPWD/stdbuscaarg_donde_hasta ";int ")
		    dondes=0
		    while [ "0$ttest" -gt 0 ];do
			dondes=$(($dondes+$ttest))
			encryptedfromfile=$(echo ";$variables"| $PrPWD/stddelcar "int $ivfromfile"|$PrPWD/stdcdrn $dondes|$PrPWD/stdcarsin ";")
			len2=$(echo $encryptedfromfile|$PrPWD/stdbuscaarg_count "][")
			if [ 0$len2 -eq 1 ];then
			    encryptedfromfile=$(echo "$encryptedfromfile"|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "["|$PrPWD/stddelcar " ")
			    break;
			else
			    encryptedfromfile=""
			fi
			ttest=$(echo ";$variables"| $PrPWD/stddelcar "int $ivfromfile"|$PrPWD/stdcdrn $dondes|$PrPWD/stdbuscaarg_donde_hasta ";int ")
		    done

		    filedfromfile=$(echo ";$variables" |$PrPWD/stdcdr ";FILE *"|$PrPWD/stdcarsin "="|$PrPWD/stdcarsin ";")
		    ca5=$(echo "$userfromfile $ivfromfile $encryptedfromfile $filedfromfile"|$PrPWD/stdbuscaarg " 0")
		    echo "<$userfromfile> <$ivfromfile> <$encryptedfromfile> <FD $filedfromfile> <$ca5>"
		    if [ -n "$userfromfile" -a -n "$ivfromfile" -a -n "$encryptedfromfile" -a -n "$filedfromfile" -a -z "$ca5" ];then
			filed=$(cat $fn | $PrPWD/stdcdr "$filedfromfile=" | $PrPWD/stdcdr "fopen(" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ",");
			usuarioo=$(echo ";$variables" |$PrPWD/stdcdr "$userfromfile=" |$PrPWD/stdcdr '"' | $PrPWD/stdcarsin '"');
			echo "- - - - - - - - - - - - - - - -  "
			echo "uU $usuarioo Uu $userfromfile uU"
			echo "- - - - - - - - - - - - - - - -  "
			errores="USUARIO INCORRECTO"
			if [ -f "$PrPWD/users/$usuarioo/$usuarioo-aes.c" ];then
			    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$outputdelc.c" ];do
				outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done
			    echo "oOO $outputdelc OOo"
			    arrayindex=$(cat $fn | $PrPWD/stdcdr "int $ivfromfile["  | $PrPWD/stdcarsin "]");
			    dondes=0
			    iv=$(echo "$variables" | $PrPWD/stdcdr "int $ivfromfile["  | $PrPWD/stdcarsin ";");
			    msj=$(echo "$variables" | $PrPWD/stdcdr "int $encryptedfromfile["|$PrPWD/stdcarsin ";");
			    filed=$(cat $fn | $PrPWD/stdcdr "$filedfromfile=" | $PrPWD/stdcdr "fopen(" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ",");
			    c=0
			    echo "IV $ivfromfile $iv"
			    cat $PrPWD/users/$usuarioo/$usuarioo-aes.c | $PrPWD/stdcar "unsigned char iv[" > $outputdelc.c
			    echo "$iv;" >> $outputdelc.c
			    cat $PrPWD/users/$usuarioo/$usuarioo-aes.c | $PrPWD/stdcdr "unsigned char iv[" | $PrPWD/stdcdr ";" >> $outputdelc.c

			    echo "msj $encryptedfromfile $msj"
			    cat $outputdelc.c | $PrPWD/stdcar "unsigned char buf[" > $outputdelc-2.c
			    echo "$msj;" >> $outputdelc-2.c
			    cat $outputdelc.c | $PrPWD/stdcdr "unsigned char buf[" | $PrPWD/stdcdr ";" >> $outputdelc-2.c
			    mv $outputdelc-2.c $outputdelc.c

			    echo "$outputdelc.c"
			    tail $outputdelc.c
			    errores=$(gcc -o $outputdelc-bin $outputdelc.c 2>&1)
			    echo "< < < |ERRORES:$errores| > > >"
			    if [ -z "$errores" ];then
				datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				while [ -f "$datosdelc.c" ];do
				    datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				done
				$PaPWD/$outputdelc-bin
				echo "$datosdelc.c"
				$PaPWD/$outputdelc-bin > $datosdelc.c

				outputdelcu=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				while [ -f "$outputdelcu.c" ];do
				    outputdelcu=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				done
				echo -n "/*"  > $outputdelcu.c
				cat $datosdelc.c|$PrPWD/stdcdr "int buf["|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "=" |$PrPWD/stdfromdec >> $outputdelcu.c
				errores=$(gcc -o $outputdelcu-bin $outputdelcu.c 2>&1)
				echo "<< (( $outputdelcu )) >>"
				echo "<( $errores ])>"
				if [ -z "$errores" ];then
				    echo " * . * . * . * . * . * . * . * . * . * . * . * "
				    cat "$outputdelcu.c"
				    echo " * . * . * . * . * . * . * . * . * . * . * . * "
u				    mkdir $PrPWD/users
				    mkdir $PrPWD/users/input
				    mkdir $PrPWD/users/input/$usuarioo
				    cp -v $outputdelcu.c $PrPWD/users/input/$usuarioo/
				fi
			    fi
			else
			    mkdir $PrPWD/users
			    mkdir $PrPWD/users/output
			    mkdir $PrPWD/users/output/unencrypted
			    echo "errores=\"Error de usuario de nombre de usuario o contraseña\";" > $PrPWD/users/output/unencrypted/$filed
			    echo "processed=255;" >> $PrPWD/users/output/unencrypted/$filed
			    echo "RROR!!"
			    exit
			fi
			if [ -n "$errores" ];then
			    mkdir $PrPWD/users
			    mkdir $PrPWD/users/output
			    mkdir $PrPWD/users/output/unencrypted
			    echo "Escribiendo a $filed"
			    echo "errores=\"Error de usuario de nombre de usuario o contraseña\";" > $PrPWD/users/output/unencrypted/$filed
			    echo "processed=255;" >> $PrPWD/users/output/unencrypted/$filed
			else
			    mkdir $PrPWD/users
			    mkdir $PrPWD/users/output
			    mkdir $PrPWD/users/output/unencrypted
			    echo "11111111111111111111111111111111111111111111111111111111111111
$filed
2222222222222222222222222222222222222222222222"
			    echo "Escribiendo a $filed"
			    echo "errores=\"Entrada registrada correctamente, en cuanto se encunetre procesada aparecera la respuesta en la lista de mensajes (con el titulo indicado en la entrada)\";" >> $PrPWD/users/output/unencrypted/$filed
			    echo "processed=255;" >> $PrPWD/users/output/unencrypted/$filed
			fi
		    else
			echo "======================="
			echo "$errores"
		    fi
		else
		    echo "$errores" #rm $fn
		fi
	    fi
	fi
    fi
fi
		
		
