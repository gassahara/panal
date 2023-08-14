#!/bin/sh
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
usuarioftp="b14_26624723"
remotepath="ftpupload.net/htdocs"
sleep 0.1
curl "ftp://$remotepath/panal/msgs/"  -X MLSD --user "$usuarioftp:Effata1581"  2>/dev/null |cut -d " " -f2 | $PrPWD/stdcdr '..
' > "$nomprograma.lis"
PbPWD=$(echo "$PaPWD"|$PrPWD/stdcdr "$PrPWD")
busca=".."
echo -n "" > $nomprograma.cha
posicion=0;
dondes=$( cat "$nomprograma.lis" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(cat "$nomprograma.lis" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=$(echo "$listf"|$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -n "$dondes" ];then
    $0 &
else
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
fi
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
	len=$(echo "$fn"|wc -c)
	if [ 0$len -gt 0 -a ! -f "$fn" ];then
	    curl  --insecure  "ftp://$remotepath/panal/msgs/$fn" --user "$usuarioftp:Effata1581" 2>/dev/null 1>$fn
	    opens=$(cat "$fn"|$PrPWD/stdbuscaarg_count "BEGIN PGP MESSAGE")
	    closs=$(cat "$fn"|$PrPWD/stdbuscaarg_count "END PGP MESSAGE")
	    balan=$(( $opens-$closs ))
	    if [ 0$opens -gt 0 -a "$balan" = "0"  ];then
		echo ";$listf;$chacha;" >> $nomprograma.memoria
		cat $fn | gpg -a --no-default-keyring --keyring $PrPWD/user/key.key  -d 1>$fn.c
		mains=$(cat "$fn.c"|$PrPWD/stdbuscaarg " main")
		opens=$(cat "$fn.c"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
		closs=$(cat "$fn.c"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
		balan=$(echo "$opens-$closs"|bc)
		if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		    ejec="$fn.$nomprograma.bin"
    		    errors=$(gcc -o ./$ejec $fn.c 2>&1)
		    echo "$ejec"
		    mkdir peticiones
		    if [ -z "$errors" ];then
			ca1=$(cat $fn.c | $PrPWD/stddelcar "  "|$PrPWD/stdbuscaarg "char *user=")
			ca2=$(cat $fn.c | $PrPWD/stddelcar "  "|$PrPWD/stdbuscaarg "int encrypted[")
			ca3=$(cat $fn.c | $PrPWD/stddelcar "  "|$PrPWD/stdbuscaarg "int iv[")
			ca4=$(cat $fn.c | $PrPWD/stddelcar "  "|$PrPWD/stdbuscaarg "char *filed=")
			if [ -n "$ca1" -a -n "$ca2" -a -n "$ca3" -a -n "$ca4" ];then
			    user=$(cat $fn.c | $PrPWD/stddelcar "  "|$PrPWD/stdcdr "char *user=\"" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ";");
			    if [ -f "$PrPWD/user/$user-aes.c" ];then
				outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				while [ -f "$outputdelc.c" ];do
				    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				done

				iv=$(cat $fn.c | $PrPWD/stddelcar "  "|$PrPWD/stdcdr "int iv["  | $PrPWD/stdcarsin ";" | $PrPWD/stdcdr "]" |$PrPWD/stdcdr "=" |$PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}");
				msj=$(cat $fn.c | $PrPWD/stddelcar "  "|$PrPWD/stdcdr "int encrypted["  |$PrPWD/stdcdr "]={" | $PrPWD/stdcarsin "}");
				msjl=$(cat $fn.c | $PrPWD/stddelcar "  "|$PrPWD/stdcdr "int encrypted["  |$PrPWD/stdcarsin "]");
				filed=$(cat $fn.c | $PrPWD/stddelcar "  "|$PrPWD/stdcdr "char *filed=" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ";");
				c=0
				cat $PrPWD/user/$user-aes.c | $PrPWD/stdcar "uint8_t iv[16]={" > $outputdelc.c
				echo "$iv};" >> $outputdelc.c
				cat $PrPWD/user/$user-aes.c | $PrPWD/stdcdr "uint8_t iv[16]="  | $PrPWD/stdcdr ";" >> $outputdelc.c

				cat $outputdelc.c | $PrPWD/stdcar "uint8_t buf[" > $outputdelc-2.c
				echo "$msjl]={$msj};" >> $outputdelc-2.c
				cat $outputdelc.c | $PrPWD/stdcdr "uint8_t buf[" | $PrPWD/stdcdr "}" >> $outputdelc-2.c
				mv $outputdelc-2.c $outputdelc.c

				echo "$outputdelc.c"
				tail $outputdelc.c
				errores=$(gcc -o $outputdelc-bin $outputdelc.c)
				if [ -z "$errores" ];then
				    datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$datosdelc.c" ];do
					datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    $PaPWD/$outputdelc-bin
				    echo "$datosdelc.c"
				    $PaPWD/$outputdelc-bin > $datosdelc.c
				    cat  "$datosdelc.c"
				    echo "==================="
				    
				    encrypted=$(cat $datosdelc.c|$PrPWD/stdcdr "int buf["|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "=" |$PrPWD/stdcdr "{" |$PrPWD/stdcar "}"|$PrPWD/stdfromdec)
				    echo "...............   $datosdelc $encrypted ........."
				    cat $datosdelc.c|$PrPWD/stdcdr "int buf["|$PrPWD/stdcarsin ";"| $PrPWD/stdcdr "="  | $PrPWD/stdcdr "{"  | $PrPWD/stdcarsin "}"
				    echo ": : : : : : : : : : : "
				    encrypted=$(echo "TU MSJ FUE $encrypted " | $PrPWD/stdtohex )
				    encryptedl=$(echo "$encrypted"| $PrPWD/stdbuscaarg_count " " )

				    iv="{"
				    while [ 0$c -lt 16 ];do
					iv2=$(dd if=/dev/urandom bs=1 count=1 2>/dev/null | $PrPWD/stdtohex)
					iv=$(echo "$iv 0x $iv2,"|$PrPWD/stddelcar " ")
					c=$((c+1))
				    done
				    iv=$(echo "$iv }};"|$PrPWD/stddelcar " "|$PrPWD/stddelcar ",}")
				    cat $PrPWD/user/$user-aes.c | $PrPWD/stdcar "uint8_t iv[16]=" > $filed.c
				    echo "$iv" >> $filed.c
				    cat $PrPWD/user/$user-aes.c | $PrPWD/stdcdr "uint8_t iv[16]="  | $PrPWD/stdcdr ";" >> $filed.c
				    cat $filed.c | $PrPWD/stdcar "uint8_t buf[" > $filed-2.c

				    iv=""
				    while [ 0$c -gt 0 ];do
					iv2=$(echo "$encrypted" | $PrPWD/stdcarsin " ")
					iv=$(echo "$iv 0x $iv2,"|$PrPWD/stddelcar " ")
					encrypted=$(echo "$encrypted" | $PrPWD/stdcdr " ")
					c=$(echo "$encrypted" |$PrPWD/stdbuscaarg_count " ")
				    done
				    
			    
				    echo "$encryptedl]={$iv}};" | $PrPWD/stddelcar ",}"  >> $filed-2.c
				    cat $filed.c | $PrPWD/stdcdr "uint8_t buf[" | $PrPWD/stdcdr "}" >> $filed-2.c
				    mv $filed-2.c $filed.c

				    errores=$(gcc -o $filed-bin $filed.c)
				    if [ -z "$errores" ];then
					echo ".........."
					datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$datosdelc.c" ];do
					    datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done
					$PaPWD/$filed-bin > $datosdelc.c
					echo ".........."
					outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$outputdelc.c" ];do
					    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done
					
					echo -n "encrypted=new Uint8Array([" > $outputdelc
					cat $datosdelc.c | $PrPWD/stdcdr "int buf[" | $PrPWD/stdcdr "=" | $PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}" >> $outputdelc
					echo -n "]);"  >> $outputdelc
					
					echo -n "iv=new Uint8Array([" >> $outputdelc
					cat $datosdelc.c | $PrPWD/stdcdr "int iv[" | $PrPWD/stdcdr "=" | $PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}" >> $outputdelc
					echo -n "]);"  >> $outputdelc
					echo "processed=255;" >> $outputdelc

					datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$datosdelc.c" ];do
					    datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done

					echo -n "encrypted="'`' > $datosdelc.js
					cat $outputdelc | gpg -a --no-default-keyring --keyring $PrPWD/user/key.key  --sign  >> $datosdelc.js
					echo '`'";"  >> $datosdelc.js
					echo "processed=255;"  >> $datosdelc.js
					curl --insecure  --user "$usuarioftp:Effata1581" -T $datosdelc.js "ftp://$remotepath/panal/msgs/$filed"
				    fi
				    
				    mv $outputdelc* peticiones/
				    mv $datosdelc* peticiones/
				else
				    echo "======================="
				    echo "$errores"
				fi
			    fi
			    mv $filed* peticiones/
			fi
    			mv $fn peticiones/
    			mv $fn.* peticiones/
		    fi
		else
		    rm $fn
		fi
	    fi
	fi
    fi
fi
