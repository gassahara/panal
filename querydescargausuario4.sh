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
remotepath=$(cat $PrPWD/host.c|$PrPWD/stddeclaracionesdevariable | $PrPWD/stdcdr host|$PrPWD/stdcdr = |$PrPWD/stdcdr '"'|$PrPWD/stdcarsin '"')
echo ":>:>:>:>>>> $remotepath"
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
echo "O"
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
	if [ -f "$PaPWD/querydescarga.l.$ii" -a -f "$PaPWD/querydescarga.l.$ii.lock" ];then
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
		    # Salir si $encuentra está vacío
		    if [ -z "$encuentra" ]; then
			echo ";$listf;" > "$fn.memoria"
			exit 0
		    fi
		    echo "<:<$remotepath/$listf >:>"
		    # Obtener el código de respuesta
		    respcode=$(curl --head --silent --fail "$remotepath/$listf" | $PrPWD/stdbuscaarg "HTTP/1.1 200 OK")
		    # Salir si no se encuentra el archivo remoto
		    if [ -z "$respcode" ]; then
			exit 0
		    fi
		    # Descargar el archivo
		    curl -L "$remotepath/$listf" 2>/dev/null > "$fn"
		    echo -n ">"
		    if [ ! -f "$fn" ]; then
			exit 0
		    fi
		    echo -n "F"
		    # Obtener el tamaño del archivo
		    size=$(wc -c < "$fn" | $PrPWD/stdcarsin ' ')
		    # Contar mensajes PGP
		    opens=$(grep -c "BEGIN PGP MESSAGE" "$fn")
		    closs=$(grep -c "END PGP MESSAGE" "$fn")
		    # Manejar archivo no PGP o con mensaje PGP balanceado
		    if [ "$opens" -eq 0 ]; then
			if [ "$size" -le 1 ]; then
			    exit 0
			fi

			firstchar=$(head -c 2 "$fn")
			case "$firstchar" in
			    '--'|'BE'|' -'|'- ') ;;
			    *)
				echo ";$listf;" > "$fn.memoria"
				echo ">> >> >> $size $opens $closs"
				exit 0
				;;
			esac
		    else
			balan=$((opens - closs))
			if [ "$balan" -ne 0 ]; then
			    exit 0
			fi

			echo "SAVED PGP"
			echo ";$listf;" > "$fn.memoria"

			gpg --homedir "$PrPWD/user/" --no-default-keyring --keyring "$PrPWD/user/key.key" \
			    --secret-keyring "$PrPWD/user/key.gpg" --trustdb-name "$PrPWD/user/trustdb.gpg" \
			    -d < "$fn" > "$fn.c" 2>/dev/null

			balan=$(wc -c < "$fn.c" | $PrPWD/stddelcar " ")
			if [ "$balan" -le 0 ]; then
			    exit 0
			fi

			tr -d ' ' < "$fn.c" > "$fn.tmp"
			mv -v "$fn.tmp" "$fn.c"

			mains=$(grep " main" "$fn.c")
			opens=$(echo "$mains" | grep -o "{" | wc -l)
			closs=$(echo "$mains" | grep -o "}" | wc -l)

			if [ "$opens" -gt 0 ] && [ "$((opens - closs))" -eq 0 ] && [ -n "$mains" ]; then
			    errors=$(gcc "$fn.c" 2>&1)
			    if [ -n "$errors" ]; then
				rm "$fn" "$fn.c"
				echo "There are errors on $fn.c"
			    else
				mkdir -p "$PrPWD/users/input/unencrypted"
				mv -v "$fn.c" "$PrPWD/users/input/unencrypted"
				echo "$errors"
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
		    sleep 1
		fi
		a=$(expr $a + 1)
	    done
	    rm  -v "$nomprograma.lista0"
	    echo "X"
	    rm $pn.lock
	    sleep 10
	    #$0 x &
	    exit
	fi
    fi
else
    echo "I"
    listacc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    while [ -f "$PaPWD/$listacc.c" ];do
	listacc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    done
    echo "$listacc" "$remotepath/dirlistmt.php"
    cat $PrPWD/listadescarga.c | $PrPWD/stdcar "unsigned char files[" > "$PaPWD/$listacc.c"
    curl -L "$remotepath/dirlistmt.php"
    rfile=$(curl -L "$remotepath/dirlistmt.php" 2>/dev/null | $PrPWD/stdcdr 'file="'|$PrPWD/stdcarsin '"')
    echo "<<$remotepath/$rfile>>"
    curl -L "$remotepath/$rfile"  | $PrPWD/stddeclaracionesdevariable |  $PrPWD/stdcdr 'files[' | $PrPWD/stdcarsin '
'  >> "$PaPWD/$listacc.c"
    cat $PrPWD/listadescarga.c | $PrPWD/stdcdr "unsigned char files[" | $PrPWD/stdcdr ';' >> "$PaPWD/$listacc.c"
    errors=$(gcc -o $PaPWD/$listacc "$PaPWD/$listacc.c" 2>&1)
    if [ -n "$errors" ];then
	echo "There are errors on $PaPWD/$listacc"
	rm -v "$PaPWD/$listacc" "$PaPWD/$listacc.c"
	rm $nomprograma.lista0
    else
	echo "$listacc"
	$PaPWD/$listacc > $nomprograma.lista0
	echo ">>"
    fi
    rm "$PaPWD/$listacc" "$PaPWD/$listacc.c"
    $0 n &
fi
exit
