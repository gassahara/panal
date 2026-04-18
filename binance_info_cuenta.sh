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
#echo "$nomprograma.."
sleep 0.1
archivo="$PrPWD/binance.key"
dondes=$( cat "$archivo" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
posiciona=0
remotepath="ftpupload.net/htdocs"
usuarioftp="b14_26624723"
passwordftp="Effata1581"
while [ -n "$dondes" ];do
    listf=$(cat "$archivo" | $PrPWD/stdcdrn "0$posiciona"|$PrPWD/stdcarsin '
')
    echo "* ****** ******   *****      $listf"
    posiciona=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posiciona=$(expr 0$posiciona + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    cabecera="";
    filas=""
    user=$(echo -n "$listf" | $PrPWD/stdcarsin ';')
    archnombrejs=$(date +"%s")
    archnombrejs=$(echo -n "$user-$archnombrejs"|sha512sum|$PrPWD/stdcarsin " ")
    secretKey=$(echo -n "$listf" | $PrPWD/stdcdr ';'|$PrPWD/stdcarsin ';')
    apikey=$(echo -n "$listf" | $PrPWD/stdcdr ';'|$PrPWD/stdcdr ';'|$PrPWD/stdcarsin ';')

    echo "$user"
    echo "$apikey"
    echo "$secretKey"
    echo "FECHA;HORA;PAR;CANTIDAD;TIPO;PRECIO;Id_Orden;\n"  > "Binance_History_$user"
    timed=$(date +%s%N|$PrPWD/stdcarn 13)
    params="recvWindow=5000&timestamp=$timed"
    signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$secretKey" | $PrPWD/stdcdr "= ")
    nomprog=$(echo -n "$nomprograma"|$PrPWD/stdcarsin ".")
    nomprog=$(echo -n "$nomprog .dat"|tr -d ' ')
    curl -H "X-MBX-APIKEY: $apikey" -L "https://fapi.binance.com/fapi/v2/account?$params&signature=$signature" > "$nomprog"
    echo "%^%^%^%^%^%^%^%^%^%^%^%^%"
    cat "$nomprog" | $PrPWD/stdcarn 120
    errores=$(cat "$nomprog" | $PrPWD/stdcarn 120|$PrPWD/stdbuscaarg "error")
    if [ -z "$errores" ];then
	listb=$(cat "$nomprog" | $PrPWD/stdcdrn "0$posicionc"|$PrPWD/stdcarsin ';')
	ret=$(cat "$nomprog" | $PrPWD/stdcarsin '[' | tr ',' '
' | tr -d '"' | tr ':' '=' | tr -d "[{}\[\]]" )
	mkdir "$PrPWD/orders" 2>/dev/null
	mkdir "$PrPWD/orders/$user" 2>/dev/null
	archnombre=$(echo "$user-account")
	archnombre=$(echo "$PrPWD/orders/$user/$archnombre.c")
	echo " - - - - - -- - -          $archnombre"
	echo "#include <stdio.h>" > $archnombre
	echo "int main(int argc, char *argv[]) {" >> $archnombre
	l=$(echo -n "$user"|wc -c | $PrPWD/stdcarsin " ")
	echo "char cuenta[$l]=\"$user\";" >> "$archnombre"
	dondeu=$( echo "$ret" |$PrPWD/stdbuscaarg_donde '
')
	posiciond=0
	while [ -n "$dondeu" ];do
	    lists=$(echo "$ret" | $PrPWD/stdcdrn "0$posiciond"|$PrPWD/stdcarsin '
')
	    posiciond=$(echo "$dondeu" |$PrPWD/stdcarsin " ")
	    posiciond=$(expr 0$posiciond + 1)
	    dondeu=$(echo "$dondeu" |$PrPWD/stdcdr " ")
	    if [ -n "$lists" ];then
		reu=$(echo "$lists" | $PrPWD/stdcdr '=')
		rev=$(echo "$lists" | $PrPWD/stdcarsin '=')
		esn=$(echo -n "$reu" | $PrPWD/stdesnumero)
		if [ -n "$esn" ];then
		    l=$(echo -n "$reu" | wc -c | $PrPWD/stdcarsin " ")
		    echo "char $rev[$l]=\"$reu\""
		    if [ -n "$reu" ];then
			echo "char $rev[$l]=\"$reu\";" >> "$archnombre"
		    else
			echo "char $rev[1]={0};" >> "$archnombre"
		    fi
		else 
		    echo "double $rev=$reu"
		    if [ -n "$reu" ];then
			echo "double $rev=$reu;" >> "$archnombre"
		    else
			echo "double $rev=0;" >> "$archnombre"
		    fi
		fi
	    fi
	done
	echo "}" >>  "$archnombre"
	donder=$( cat "$nomprog"|$PrPWD/stdbuscaarg_donde '}')
	posicionc=$(cat "$nomprog"|$PrPWD/stdbuscaarg_donde_hasta '{')
	while [ -n "$donder" ];do
	    listr=$(cat "$nomprog" | $PrPWD/stdcdrn "0$posicionc"|$PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}")
	    posicionc=$(echo "$donder" |$PrPWD/stdcarsin " ")
	    posicionc=$(expr 0$posicionc + 1)
	    donder=$(echo "$donder" |$PrPWD/stdcdr " ")
	    ret=$(echo "$listr" | tr ',' '
' | tr -d '"' | tr ':' '=' | tr -d "[{}\[\]]" )
	    mkdir "$PrPWD/orders" 2>/dev/null
	    mkdir "$PrPWD/orders/$user" 2>/dev/null
	    asset=$(echo "$listr" | $PrPWD/stdcdr 'asset":'| $PrPWD/stdcarsin ","|tr -d '"')
	    if [ -z "$asset" ];then
		asset=$(echo "$listr" | $PrPWD/stdcdr 'symbol":'| $PrPWD/stdcarsin ","|tr -d '"')
	    fi
	    archnombre=$(echo -n "$user-account-$asset")
	    archnombre=$(echo -n "$PrPWD/orders/$user/$archnombre.c")
	    echo " - - - - - -- - -          $archnombre"
	    echo "#include <stdio.h>" > $archnombre
	    echo "int main(int argc, char *argv[]) {" >> $archnombre
	    l=$(echo -n "$user"|wc -c | $PrPWD/stdcarsin " ")
	    echo "char cuenta[$l]=\"$user\";" >> "$archnombre"
	    dondeu=$( echo "$ret" |$PrPWD/stdbuscaarg_donde '
')
	    posiciond=0
	    while [ -n "$dondeu" ];do
		lists=$(echo "$ret" | $PrPWD/stdcdrn "0$posiciond"|$PrPWD/stdcarsin '
')
		posiciond=$(echo "$dondeu" |$PrPWD/stdcarsin " ")
		posiciond=$(expr 0$posiciond + 1)
		dondeu=$(echo "$dondeu" |$PrPWD/stdcdr " ")
		if [ -n "$lists" ];then
		    reu=$(echo "$lists" | $PrPWD/stdcdr '=')
		    rev=$(echo "$lists" | $PrPWD/stdcarsin '=')
		    if [ "$rev" = "symbol" ];then
			rev="asset"
		    fi
		    esn=$(echo -n "$reu" | $PrPWD/stdesnumero)
		    if [ -n "$esn" ];then
			l=$(echo -n "$reu" | wc -c | $PrPWD/stdcarsin " ")
			echo "char $rev[$l]=\"$reu\""
			echo "char $rev[$l]=\"$reu\";" >> "$archnombre"
		    else 
			echo "double $rev=$reu"
			echo "double $rev=$reu;" >> "$archnombre"
		    fi
		fi
	    done
	    echo "}" >>  "$archnombre"
	done
    fi
done
$0
