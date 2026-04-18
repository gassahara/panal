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

    listc=$(curl -L "https://fapi.binance.com/fapi/v1/ticker/24hr")
    listp=""
    encuentra="ALGO"
    while [ -n "$encuentra" ];do
	symbol=$(echo -n "$listc"|$PrPWD/stdcdr '"symbol":'|$PrPWD/stdcarsin ","|$PrPWD/stddelcar '"')
	echo "<>$symbol<>"
	encuentra=$(echo "$listp"|$PrPWD/stdbuscaarg "$symbol;")
	if [ -z "$encuentra" ];then
	    listp=$(echo -n "$symbol ; $listp"|$PrPWD/stddelcar ' ')
	fi
	listc=$(echo -n "$listc" | $PrPWD/stdcdr '"symbol":')
	encuentra=$(echo -n "$listc"|$PrPWD/stdbuscaarg '"symbol":')
    done
    listp=$(echo -n ";$listp")
    pares="$PrPWD/binance_pares.key"
    echo "$listp" > "$pares"
    dondet=$( cat "$pares" |$PrPWD/stdbuscaarg_donde ';')
    posicionb=0
    while [ -n "$dondet" ];do
	listp=$(cat "$pares" | $PrPWD/stdcdrn "0$posicionb"|$PrPWD/stdcarsin ';')
	posicionb=$(echo "$dondet" |$PrPWD/stdcarsin " ")
	posicionb=$(expr 0$posicionb + 1)
	dondet=$(echo "$dondet" |$PrPWD/stdcdr " ")
	symbol=$(echo -n "$listp" | $PrPWD/stdcarsin ';')
	echo ">    >    $symbol"
	echo "$user"
	echo "$apikey"
	echo "$secretKey"
	echo "FECHA;HORA;PAR;CANTIDAD;TIPO;PRECIO;Id_Orden;\n"  > "Binance_History_$user"
        times=$(date --date "01/01/2021" +%s%N|$PrPWD/stdcarn 13)
	timef=$(date +%s%N|$PrPWD/stdcarn 13)
        fechad=$(echo "$times<$timef"|bc -l)
	while [  0$fechad -eq 1 ];do
	    timed=$(date +%s%N|$PrPWD/stdcarn 13)
            params="recvWindow=5000&startTime=$times&symbol=$symbol&timestamp=$timed"
            signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$secretKey" | $PrPWD/stdcdr "= ")
            URL="https://api.binance.com/fapi/v3/allOrders?$params$signature=$signature"
	    echo "https://fapi.binance.com/fapi/v1/allOrders?$params&signature=$signature"
	    res=$(curl -H "X-MBX-APIKEY: $apikey" -L "https://fapi.binance.com/fapi/v1/allOrders?$params&signature=$signature")
	    echo "%^%^%^%^%^%^%^%^%^%^%^%^%"
	    echo $res | $PrPWD/stdcarn 120
	    donder=$( echo "$res" |$PrPWD/stdbuscaarg_donde '}')
	    posicionc=0
	    while [ -n "$donder" ];do
		listr=$(echo "$res" | $PrPWD/stdcdrn "0$posicionc"|$PrPWD/stdcarsin ';')
		posicionc=$(echo "$donder" |$PrPWD/stdcarsin " ")
		posicionc=$(expr 0$posicionc + 1)
		donder=$(echo "$donder" |$PrPWD/stdcdr " ")
		ret=$(echo "$listr" | $PrPWD/stdcarsin '}' | tr ',' '
' | tr -d '"' | tr ':' '=' | tr -d "[{}\[\]]" )
		mkdir "$PrPWD/orders" 2>/dev/null
		mkdir "$PrPWD/orders/$user" 2>/dev/null
		archnombre=$(echo "$ret"|$PrPWD/stdcdr "orderId="|$PrPWD/stdcarsin '
')
		archnombre=$(echo -n "$PrPWD/orders/$user/$archnombre.c")
		echo " - - - - - -- - -          $archnombre"
		echo "#include <stdio.h>" > $archnombre
		echo "int main(int argc, char *argv[]) {" >> $archnombre
		dondeu=$( echo "$ret" |$PrPWD/stdbuscaarg_donde '
')
		posiciond=0
#		filas=$(echo -n "$filas <tr>")
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
			    echo "char $rev[$l]=\"$reu\";" >> "$archnombre"
			else 
			    echo "double $rev=$reu"
			    echo "double $rev=$reu;" >> "$archnombre"
			fi
		    fi
		done
		echo "}" >>  "$archnombre"
		# 	    rex=$(cat "$archnombre" | $PrPWD/stddeclaracionesdevariable_tojs)
		# 	    dondev=$( echo "$rex" |$PrPWD/stdbuscaarg_donde '
		# ')
		# 	    posicione=0
		# 	    while [ -n "$dondev" ];do
		# 		mkdir "$PrPWD/orders/$user" 2>/dev/null
		# 		listt=$(echo "$rex" | $PrPWD/stdcdrn "0$posicione"|$PrPWD/stdcarsin ';' | $PrPWD/stdcdr "var ")
		# 		nombre=$(echo -n "$listt" | $PrPWD/stdcarsin "=")
		# 		touch "$PrPWD/orders/$user/$archnombrejs.js"
		# 		encuentra=$(cat "$PrPWD/orders/$user/$archnombrejs.js"  | $PrPWD/stdbuscaarg "var $nombre")
		# 		if [ -z "$encuentra" ];then
		# 		    echo "var $nombre[];" >> "$PrPWD/orders/$user/$archnombrejs.js"
		# 		    cabecera=$(echo -n "$cabecera <td>$nombre</td>")
		# 		fi
		# 		encuentra=$(echo -n "$listt" | $PrPWD/stdbuscaarg "=" )
		# 		if [ -n "$encuentra" ];then
		# 		    echo -n "$listt" | $PrPWD/stdcarsin "=" >> "$PrPWD/orders/$user/$archnombrejs.js"
		# 		    echo -n "[]=" >> "$PrPWD/orders/$user/$archnombrejs.js"
		# 		    echo -n "$listt" | $PrPWD/stdcdr "=" >> "$PrPWD/orders/$user/$archnombrejs.js"
		# 		    nombre=$(echo -n "$listt" | $PrPWD/stdcdr "=")
		# 		    filas=$(echo -n "$filas <td>$nombre</td>")
		# 		    echo ";" >> "$PrPWD/orders/$user/$archnombrejs.js"
		# 		fi
		# 		posicione=$(echo "$dondev" |$PrPWD/stdcarsin " ")
		# 		posicione=$(expr 0$posicione + 1)
		# 		dondev=$(echo "$dondev" |$PrPWD/stdcdr " ")
		# 	    done
		# 	    filas=$(echo -n "$filas </tr>")
	    done
	    times=$(echo "$times+604800000"|bc -l|$PrPWD/stdcarn 13)
            fechad=$(echo "$times<$timef"|bc -l)
	done
    done
    # echo "<HTML><table>" > "$PrPWD/orders/$user/$archnombrejs.html"
    # echo "<tr>$cabecera</tr>" >> "$PrPWD/orders/$user/$archnombrejs.html"
    # echo "$filas" >> "$PrPWD/orders/$user/$archnombrejs.html"
    # echo "</table></HTML>" >> "$PrPWD/orders/$user/$archnombrejs.html"
    
    # echo " - - - - - - - - - - - - - - - - - - - - - - - - - - - "
    #  echo "SUBIENDO"
    #  echo " - - - - - - - - - - - - - - - - - - - - - - - - - - - "
    #   cat "$PrPWD/orders/$user/$archnombrejs.js"
    #  fn=$(echo -n "$user" | sha512sum | $PrPWD/stdcarsin " ")
    #  echo -n "encrypted="'`' > "$fn.js"
    #  cat "$PrPWD/orders/$user/$archnombrejs.js" | gpg --no-default-keyring --keyring ../user/key.key --trustdb-name ../user/key.trustdb  -u "$user" -a --sign >> $fn.js
    #  echo '`'";"  >> "$fn.js"
    #  echo "processed=255;"  >> "$fn.js"
    #  curl --insecure  --user "$usuarioftp:$passwordftp" -T "$fn.js" "ftp://$remotepath/panal/msgs/$fn.js"

    #  fn=$(echo -n "$user HTML" | sha512sum | $PrPWD/stdcarsin " ")
    #  echo -n "encrypted="'`' > "$fn.js"
    #  cat "$PrPWD/orders/$user/$archnombrejs.html" | gpg --no-default-keyring --keyring ../user/key.key --trustdb-name ../user/key.trustdb  -u "$user" -a --sign >> $fn.js
    #  echo '`'";"  >> "$fn.js"
    #  echo "processed=255;"  >> "$fn.js"
    #  curl --insecure  --user "$usuarioftp:$passwordftp" -T "$fn.js" "ftp://$remotepath/panal/msgs/$fn.js"

    #  fn=$(echo -n "$user key" | sha512sum | $PrPWD/stdcarsin " ")
    #  echo -n "pubkey="'`' > "$fn.js"
    #  gpg --no-default-keyring --keyring ../user/key.key --trustdb-name ../user/key.trustdb  -u "$user" -a --export >> $fn.js
    #  echo '`'";"  >> "$fn.js"
    #  echo "processed=255;"  >> "$fn.js"
    #  curl --insecure  --user "$usuarioftp:$passwordftp" -T "$fn.js" "ftp://$remotepath/panal/msgs/$fn.js"

    #  fn=$(echo -n "$user sha512" | sha512sum | $PrPWD/stdcarsin " ")
    #  echo -n "encrypted="'`' > "$fn.js"
    #  cat "$PrPWD/orders/$user/$archnombrejs.js" | sha512sum | $PrPWD/stdcarsin " " | gpg --no-default-keyring --keyring ../user/key.key --trustdb-name ../user/key.trustdb  -u "$user" -a --sign >> $fn.js
    #  echo '`'";"  >> "$fn.js"
    #  echo "processed=255;"  >> "$fn.js"
    #  echo " - - - - - - - - - - - - - - - - - - - - - - - - - - - "
    #  echo " - - - - - - - - - - - - - - - - - - - - - - - - - - - "
    #  echo $user $archnombrejs.js
    #  cat "$PrPWD/orders/$user/$archnombrejs.js" | sha512sum
    #  curl --insecure  --user "$usuarioftp:$passwordftp" -T "$fn.js" "ftp://$remotepath/panal/msgs/$fn.js"
done
$0
