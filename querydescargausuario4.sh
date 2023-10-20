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
remotepath="https://curare2019.ddns.net/"
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
    ii=1
    while [ -f "$PaPWD/querydescarga.l.$ii" -a -f "$PaPWD/querydescarga.l.$ii.lock" ];do
	ii=$(expr $ii + 1)
	echo "$ii"
    done    
    fname="$PaPWD/querydescarga.l.$ii"
    if [ -f "$fname" -a ! -f "$fname.lock" ];then
	touch "$fname.lock"
	ii=$(expr $ii + 1)
	if [ -f "$PaPWD/querydescarga.l.$ii" ];then
 	    $0 $ii &
	fi
	for listf in $(cat "$fname"); do
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
		if [ -f "$PaPWD/querydescarga.l.$a.lock" ];then
		    a=1
		    sleep 2
		fi
		a=$(expr $a + 1)
	    done
	    rm  -v "$nomprograma.lista0"
	    echo "X"
	    rm $pn.lock
	    sleep 4
	    $0 x &
	    exit
	fi
    else
	if [ ! -f $PaPWD/$pn.lock ];then
	    touch $PaPWD/$pn.lock
	    a=1
	    while [ "0$a" -le 0$count ];do
		if [ -f "$PaPWD/querydescarga.l.$a.lock" ];then
		    a=1
		    sleep 2
		fi
		a=$(expr $a + 1)
	    done
	    rm  -v "$nomprograma.lista0"
	    echo "X"
	    rm $pn.lock
	    sleep 4
	    $0 x &
	    exit
	fi
    fi
else    
    listacc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    while [ -f "$PaPWD/$listacc.c" ];do
	listacc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    done
    cat $PrPWD/listadescarga.c | $PrPWD/stdcar "unsigned char files[" > "$PaPWD/$listacc.c"
    rfile=$(curl -L "$remotepath/dirlistmt.php" 2>/dev/null| $PrPWD/stdcdr 'file="'|$PrPWD/stdcarsin '"')
    echo "<<$remotepath/$rfile>>"
    curl -L "$remotepath/$rfile"  | $PrPWD/stddeclaracionesdevariable |  $PrPWD/stdcdr 'files[' | $PrPWD/stdcarsin '
'  >> "$PaPWD/$listacc.c"
    cat $PrPWD/listadescarga.c | $PrPWD/stdcdr "unsigned char files[" | $PrPWD/stdcdr ';' >> "$PaPWD/$listacc.c"
    errors=$(gcc -o $PaPWD/$listacc "$PaPWD/$listacc.c" 2>&1)
    if [ -n "$errors" ];then
	echo "There are errors on $PaPWD/$listacc"
	rm $nomprograma.lista0
    else
	echo "$listacc"
	$PaPWD/$listacc > $nomprograma.lista0
	echo ">>"
    fi
    $0 n &
fi
exit
