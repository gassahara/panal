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
remotepath="http://127.0.0.1/" #"https://curare2019.ddns.net/"
PbPWD=$(echo "$PaPWD"|$PrPWD/stdcdr "$PrPWD")
busca=".."
posicion=0;
encuentra="ALGO"
ii=1
continua=1
pn=$0
slash=$(echo "$pn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
while [ -n "$slash" ];do
    pn=$(echo "$pn" | $PrPWD/stdcdr "/" )
    slash=$(echo $pn | $PrPWD/stdbuscaarg_donde_hasta "/" )
done
pren=0
proc=0
if [ -f "$nomprograma.lista0" ];then
    while [ -n "$continua" ];do
<<<<<<< Updated upstream
	ii=$(expr $i + 50)
	if [ 0$ii -gt 0$count ];then
	    continua=0
	fi	
	if [ ! -f "$PaPWD/$pn.l.$ii" -a ! -f "$PaPWD/$pn.lock" ];then
	    touch "$PaPWD/$pn.l.$ii"
	    if [ 0$ii -lt 0$count ];then
 		$0 $i &
	    fi
	    pren=0
	    while [ "0$i" -lt "$ii" ];do
		n2=1;
		proc=1
		while [ 0$n2 -lt 2 ];do
		    if [ -z "$dondes" ];then
			i=$ii
			continua=0
			echo "0$ii + 1"
			i=$(expr 0$ii + 1)
			n2=$count
			n2=$(expr 0$n2 - 0$pren)
			break
		    else
			n2=$(echo "$dondes" | $PrPWD/stdcarsin ' ' )
			dondes=$(echo "$dondes" | $PrPWD/stdcdr ' ' )
		    fi
		    n2=$(expr 0$n2 - 0$pren)
		done
		listf=$(cat "$nomprograma.lista0" | $PrPWD/stdcdrn 0$pren | $PrPWD/stdcarn $n2 )
		pren=$(expr 0$pren + 0$n2 + 1)
=======
	fname="$PaPWD/querydescarga.l.$ii"
	if [ ! -f "$fname.lock" -a ! -f "$PaPWD/$pn.lock" ];then
	    touch "$fname.lock"
	    ii=$(expr $ii + 1)
	    if [ -f "$PaPWD/querydescarga.l.$ii" ];then
 		$0 $ii &
	    fi
	    for listf in $(cat "$fname"); do
>>>>>>> Stashed changes
		fn=$listf
		slash=$(echo "$fn" | tr -d '
' | $PrPWD/stdbuscaarg_donde_hasta "/" )
		while [ -n "$slash" ];do
		    fn=$(echo "$fn" | tr -d '
' | $PrPWD/stdcdr "/" )
		    slash=$(echo $fn | tr -d '
' | $PrPWD/stdbuscaarg_donde_hasta "/" )
		done
		if [ -n "$fn" -a -n "$listf" ];then
		    if [ ! -f "$fn.memoria" ];then
			echo "<<$listf>>"
			tamano=$(echo "$listf"|tr -d '
' | wc -c | $PrPWD/stdcarsin ' ')
			echo "T $tamano"
			if [ 0$tamano -gt 4 ];then
			    tamano=$(expr 0$tamano - 3)
			fi
			encuentra=$(echo "$listf"|$PrPWD/stdcdrn $tamano| $PrPWD/stdbuscaarg ".js")
			if [ -z "$encuentra" ];then
			    echo ";$listf;" > "$fn.memoria"
			else
			    echo "<:<$remotepath/$listf >:>"
			    respcode=$(curl --head --silent --fail "$remotepath/$listf" | $PrPWD/stdbuscaarg "HTTP/1.1 200 OK")
			    if [ -n "$respcode" ];then
				curl -L  "$remotepath/$listf" 2>/dev/null > $fn #2>/dev/null
				echo -n ">"
				if [ -f "$fn" ];then
				    echo -n "F"
				    size=$(cat "$fn" | wc -c | $PrPWD/stdcarsin ' ')
				    opens=$(cat "$fn"|$PrPWD/stdbuscaarg_count "BEGIN PGP MESSAGE")
				    closs=$(cat "$fn"|$PrPWD/stdbuscaarg_count "END PGP MESSAGE")
				    if [ -z "$opens" -o "0$opens" -eq 0 ];then
					if [ 0$tamano -gt 1 ];then
					    firstchar=$(cat "$fn"|$PrPWD/stdcarn 2)
					    if [ "$firstchar" != '--' -a "$firstchar" != 'BE' -a "$firstchar" != ' -' -a "$firstchar" != '- '  ];then
						echo ";$listf;" > "$fn.memoria"
						echo ">> >> >> $size $opens $closs"
					    fi
					fi			
				    else
					if [ 0$opens -gt 0 ];then
					    balan=$(expr 0$opens - 0$closs )
					    if [ "$balan" = "0"  ];then
						echo "SAVED PGP"
						echo ";$listf;" > "$fn.memoria"
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
						    if [ 0$opens -gt 0 ];then
							echo "IT IS C"
							balan=$(expr  0$opens - 0$closs)
							echo ">>> $opens : $closs <<< $balan ($mains)"
							if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    							    errors=$(gcc $fn.c 2>&1)
							    if [ -n "$errors" ];then
								echo "There are errors on $fn.c"
							    else
								mkdir $PrPWD/users
								mkdir $PrPWD/users/input
								mkdir $PrPWD/users/input/unencrypted
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
			    fi			
			fi
		    fi
		fi
	    done
	    rm  -v "$fname.lock"
	    if [ ! -f $PaPWD/$pn.lock ];then
		touch $PaPWD/$pn.lock
		a=1
		while [ "0$a" -le 0$count ];do
<<<<<<< Updated upstream
		    if [ -f "$PaPWD/$pn.l.$a" ];then
			a=$(expr 0$count + 1)
=======
		    if [ -f "$PaPWD/querydescarga.l.$a.lock" ];then
			a=1
			sleep 2
			rm $pn.lock
			exit
>>>>>>> Stashed changes
		    fi
		    a=$(expr $a + 1)
		done
		rm  -v "$nomprograma.lista0"
<<<<<<< Updated upstream
		if [ 0$a -gt 0$count ];then
		    curl -H 'Cache-Control: no-cache, no-store'  -L "$remotepath/dirlistmt.php?i=$(date +%s)" 2>/dev/null | tr '
' ' ' > $nomprograma.lista0
		fi
=======
>>>>>>> Stashed changes
		echo "X"
		rm $pn.lock
		sleep 10
		$0 x &
		exit
	    fi
	    continua=0
	    break
	else
<<<<<<< Updated upstream
	    while [ "0$i" -lt "$ii" ];do
		dondes=$(echo "$dondes" | $PrPWD/stdcdr ' ' )
		if [ -z "$dondes" ];then
		    continua=0
		    break
		fi
		i=$(expr 0$i + 1)		
	    done
	fi
	if [ -z "$dondes" ];then
	    continua=0
	    break
=======
	    ii=$(expr $ii + 1)
	    fname="$PaPWD/querydescarga.l.$ii"
	    if [ ! -f "$fname" ];then
		exit
	    fi
>>>>>>> Stashed changes
	fi
    done
else    
    listacc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    while [ -f "$PaPWD/$listacc.c" ];do
	listacc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    done
    cat $PrPWD/listadescarga.c | $PrPWD/stdcar "unsigned char files[" > "$PaPWD/$listacc.c"
    curl -L "127.0.0.1/dirlistmt.php" 2>/dev/null | $PrPWD/stddeclaracionesdevariable | $PrPWD/stdcdr 'files[' | $PrPWD/stdcarsin '
' >> "$PaPWD/$listacc.c"
    cat $PrPWD/listadescarga.c | $PrPWD/stdcdr "unsigned char files[" | $PrPWD/stdcdr ';' >> "$PaPWD/$listacc.c"
    errors=$(gcc -o $PaPWD/$listacc "$PaPWD/$listacc.c" 2>&1)
    if [ -n "$errors" ];then
	echo "There are errors on $PaPWD/$listacc"
    else
	$PaPWD/$listacc > $nomprograma.lista0
	$0 n &
	echo ">>"
    fi
fi
exit
