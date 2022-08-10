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
usuarioftp="b14_26624723"
passwordftp="Effata1581"
remotepath="ftpupload.net/htdocs"
sleep 2
curl  --insecure  "ftp://$remotepath/panal/msgs/"  -X MLSD --user "$usuarioftp:$passwordftp"  2>/dev/null |cut -d " " -f2 | $PrPWD/stdcdr '..
' > $nomprograma.lis
PbPWD=$(echo "$PaPWD"|$PrPWD/stdcdr "$PrPWD")
busca=".."
echo "" |tr -d '
' > $nomprograma.cha
posicion=0;
dondes=$( cat "$nomprograma.lis" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    posicion2=$(echo "$dondes"|$PrPWD/stdcarsin " ")
    posicion2=$(expr 0$posicion2 - 0$posicion + 1)
    listf=$(cat "$nomprograma.lis" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarn $posicion2)
    posicion=$(expr 0$posicion2 + $posicion)
    dondes=$(echo "$dondes" |tr -d '
'|$PrPWD/stdcdr " ")
    chacha=$(echo " $listf"|tr -d '
'|$PrPWD/stdtohex |$PrPWD/chacha20)
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
if [ -z "$encuentra" -a -n "$listf" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo "$fn" tr -d '
'||$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	while [ -n "$slash" ];do
	    fn=$(echo "$fn" | $PrPWD/stdcdr "/" )
	    slash=$(echo $fn | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
    	echo "0 $busca ($fn)"
	len=$(echo "$fn"|wc -c|tr -d ' ')
echo "len=$len"
	if [ "0$len" -gt 0 ];then
            if [ ! -f "$fn" ];then
	        curl  --insecure  "ftp://$remotepath/panal/msgs/$fn" --user "$usuarioftp:$passwordftp" 2>/dev/null 1>$fn
            fi
	fi
	if [ -f "$fn" ];then
	    opens=$(cat "$fn"|$PrPWD/stdbuscaarg_count "BEGIN PGP MESSAGE")
	    closs=$(cat "$fn"|$PrPWD/stdbuscaarg_count "END PGP MESSAGE")
	    balan=$(( $opens-$closs ))
	    if [ 0$opens -gt 0 -a "$balan" = "0"  ];then
		echo ";$listf;$chacha;" >> $nomprograma.memoria
		cat $fn | gpg --no-default-keyring --keyring $PrPWD/user/key.key  -d 2>/dev/null 1>$fn.c
		echo  "/*" tr -d '
'> $fn-2.c
		cat $fn.c >> $fn-2.c
		mv $fn-2.c $fn.c
		mains=$(cat "$fn.c"|$PrPWD/stdbuscaarg " main")
		opens=$(cat "$fn.c"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
		closs=$(cat "$fn.c"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
		balan=$(expr 0$opens - 0$closs)
		if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		    ejec="$fn.$nomprograma.bin"
    		    errors=$(gcc -o ./$ejec $fn.c 2>&1)
		    echo "$ejec"
		    mkdir peticiones
		    if [ -z "$errors" ];then
			variables=$(cat $fn.c |$PrPWD/stddeclaracionesdevariable|$PrPWD/stddelcar "main{"|$PrPWD/stddelcar "
")
			variables=$(echo ";$variables"|tr -d '
')
			echo ">V>$variables<V<"
			userfromfile=$(echo "$variables" |tr -d '
'|$PrPWD/stdcdr ";char *"|$PrPWD/stdcarsin "=")
			echo "UU=$userfromfile"
			ttest=$(echo "$variables" |tr -d '
'|$PrPWD/stdbuscaarg_donde_hasta ";int ")
			ttest=$((ttest+4))
			echo "<<< ttest $ttest >>>"
			dondes=1
			while [ "0$ttest" -gt 0 ];do
			    dondes=$(($dondes+$ttest))
			    passfromfile=$(echo "$variables" |tr -d '
'|$PrPWD/stdcdrn $dondes|$PrPWD/stdcar ";")
			    echo "-> <$passfromfile>"
			    len=$(echo $passfromfile|$PrPWD/stdcar "="|$PrPWD/stdbuscaarg_donde_hasta "[16]")
			    len2=$(echo $passfromfile|$PrPWD/stdbuscaarg_count "][")
			    if [ 0$len -gt 0 -a 0$len2 -eq 0 ];then
				passfromfile=$(echo "$passfromfile"|tr -d '
'|$PrPWD/stdcarn $((len-3)))
				echo "<([$passfromfile])>"
				break;
			    else
				passfromfile=""
			    fi
			    ttest=$(echo ";$variables" |$PrPWD/stdcdrn $dondes|$PrPWD/stdbuscaarg_donde_hasta ";int ")
			    echo "<<< ttest 0$ttest d $dondes>>>"
			done
			filedfromfile=$(echo "$variables" | $PrPWD/stdcdr ";FILE *"|$PrPWD/stdcarsin "=")
			echo "<$userfromfile> <$passfromfile> <$filedfromfile>"
			if [ -n "$userfromfile" -a -n "$passfromfile" -a -n "$filedfromfile" ];then
			    usuar=$(echo ";$variables" | $PrPWD/stdcdr ";char *$userfromfile=" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ";");
			    filed=$(cat $fn.c | $PrPWD/stdcdr "$filedfromfile=" | $PrPWD/stdcdr "fopen(" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ",");
			    if [ ! -d "$PrPWD/users/$usuar" ];then
				pwss=$(echo ";$variables" | $PrPWD/stdcdr " $passfromfile" |$PrPWD/stdcdr "=" | $PrPWD/stdcarsin ";");
				mkdir $PrPWD/users/
				mkdir $PrPWD/users/$usuar
				cat $PrPWD/aes_ctr.c | $PrPWD/stdcar "unsigned char key[16]=" > $PrPWD/users/$usuar/$usuar-aes.c
				echo "<<< $pwss >>>"
				echo "$pwss" | tr -d '
'>> $PrPWD/users/$usuar/$usuar-aes.c
				cat $PrPWD/aes_ctr.c | $PrPWD/stdcdr "unsigned char key[16]=" | $PrPWD/stdcdrcon ";" >> $PrPWD/users/$usuar/$usuar-aes.c
				c=0
				iv="{{"
				while [ 0$c -lt 16 ];do
				    iv2=$(dd if=/dev/urandom bs=1 count=1 2>/dev/null | $PrPWD/stdtohex)
				    iv=$(echo "$iv 0x $iv2 ,")
				    c=$((c+1))
				done
				iv=$(echo  "$iv}}};"|tr -d '
'|$PrPWD/stddelcar ",}"|$PrPWD/stddelcar " ")
				echo "<<< ####################  >>>"
				echo "$iv"
				echo "<<< ####################  >>>"
				cat $PrPWD/users/$usuar/$usuar-aes.c | $PrPWD/stdcar "unsigned char iv[1][16]=" > $filed.c
				echo "$iv" >> $filed.c
				cat $PrPWD/users/$usuar/$usuar-aes.c | $PrPWD/stdcdr "unsigned char iv[1][16]=" | $PrPWD/stdcdr ";" >> $filed.c
				
				iv=$(echo "REGISTRADO"|$PrPWD/stdtohex)
				c=$(echo "$iv" |$PrPWD/stdbuscaarg_count " ")
				cat $filed.c | $PrPWD/stdcar "unsigned char buf[1][" > $filed-2.c
				echo "$((c+1)) ]=" >> $filed-2.c
				pwss="{{"
				while [ 0$c -gt 0 ];do
				    iv2=$(echo "$iv" | $PrPWD/stdcarsin " ")
				    pwss=$(echo "$pwss 0x $iv2 ,"|$PrPWD/stddelcar " ") 
				    iv=$(echo "$iv" | $PrPWD/stdcdr " ")
				    c=$(echo "$iv" |$PrPWD/stdbuscaarg_count " ")
				done
				echo "$pwss}}};"|$PrPWD/stddelcar ",}" >> $filed-2.c
				cat $filed.c | $PrPWD/stdcdr "unsigned char buf[" | $PrPWD/stdcdr ";" >> $filed-2.c
				mv "$filed-2.c" "$filed.c"
				errores=$(gcc -o $filed-bin $filed.c)
				if [ -z "$errores" ];then
				    datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$datosdelc.c" ];do
					datosdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$outputdelc.c" ];do
					outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    $PaPWD/$filed-bin
				    $PaPWD/$filed-bin > $datosdelc.c
				    echo "encrypted=new Uint8Array([" | tr -d '
' > $outputdelc
				    cat $datosdelc.c | $PrPWD/stdcdr "int buf[" | $PrPWD/stdcdr "=" | $PrPWD/stddelcar "{" | $PrPWD/stddelcar "}"|$PrPWD/stdcarsin ";" >> $outputdelc
				    echo -n "]);" |tr -d '
' >> $outputdelc
				    
				    echo "iv=new Uint8Array([" | tr -d '
' >> $outputdelc
				    cat $datosdelc.c | $PrPWD/stdcdr "int iv[" |  $PrPWD/stdcdr "=" | $PrPWD/stddelcar "{" | $PrPWD/stddelcar "}"|$PrPWD/stdcarsin ";" >> $outputdelc
				    echo  "]);" | tr -d '
' >> $outputdelc
				    echo "processed=255;" >> $outputdelc
				    echo "<<</$outputdelc\>>>"
				    cat $outputdelc
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
				echo "errores=\"USUARIO REGISTRADO, Por Favor Escoja otro nombre\";" > $outputdelc
				echo "processed=255;" >> $outputdelc
			    fi
			    if [ -z "$errores" ];then
				echo  "encrypted="'`' | tr -d '
' > $datosdelc.js
				cat $outputdelc | gpg -a --no-default-keyring --keyring $PrPWD/user/key.key  --sign  >> $datosdelc.js
				echo '`'";"  >> $datosdelc.js
				echo "processed=255;"  >> $datosdelc.js
				curl --insecure  --user "$usuarioftp:$passwordftp" -T $datosdelc.js "ftp://$remotepath/panal/msgs/$filed"
				mv $outputdelc* peticiones/
				mv $datosdelc* peticiones/
			    else
				echo "======================="
				echo "$errores"
			    fi
			    mv $filed* peticiones/
			fi
		    fi
		fi
	    fi
	fi
    fi
fi
