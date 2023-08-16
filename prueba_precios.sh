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
sleep 0.1
listados="";
listado="";
symbolp=""
maosmenos="";
while [ true ];do
    APIKEY="16b5KmysU1hnh5rCrRTRSeWY0levJKL6oqgvEakUr6dVDSvFCapVZ74da085tSYj"
    SECKEY="80N22GHnrpHfFomqBz24icgAxmFyZgMMnbNHncJwuC0oYlifFKzZLnXrVrBv4z0g"
    reset
    echo " . . . .  . "
    if [ -f "buy" ];then
	echo " - - - - - - - - - - "
	symbol=$(cat buy | $PrPWD/stdcarsin = )
	price=$(cat buy | $PrPWD/stdcdr "=" | $PrPWD/stdcarsin '
')
	echo "S $symbol P $price"
	priceactual=0;
	token=$(echo $symbol | $PrPWD/stdcarsin ETH)
	saldo=0
	eval $(cat quant)
	eval $(cat long)
	if [ 0$long -gt 7 ];then long=7;fi
	echo " Q <$quant> L $long"
	s=$(echo "scale=$long;$quant-$saldo"|bc -l)
	while [ "$s" != "0" -a -n "$s" ];do
	    timed=$(date +%s%N|$PrPWD/stdcarn 13)
	    params="recvWindow=5000&timestamp=$timed"
	    signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$SECKEY" | $PrPWD/stdcdr "= ")
	    saldo=$(curl -H "X-MBX-APIKEY: $APIKEY" -L "https://api.binance.com/api/v3/account?$params&signature=$signature" 2>/dev/null | $PrPWD/stdcdr "$token\"," | $PrPWD/stdcdr ':' | $PrPWD/stdcarsin ',' | tr -d '"')
	    s=$(echo "scale=$long;$quant-$saldo"|bc -l)
	    saldoc=$(echo "$s"|$PrPWD/stdcarn 1)
	    if [ "$saldoc" = "." ];then s=$(echo "0$s");fi
	    if [ "$saldoc" = "-" ];then s=0;fi
	    echo "saldo=$saldo < $quant ($s) l=$long"
	    d=$(echo "scale=2;($s/$quant)*100"|bc -l|$PrPWD/stdcarsin ".")
	    echo "d=$d s=$s"
	    if [ "0$d" -lt "1" ];then s=0;fi
	    if [ "$s" != "0" -a -n "$s" ];then sleep 10;fi
	done

	saldoentoken=$(echo "$saldo*(10*$long)"|bc -l|$PrPWD/stdcarsin '.')
	#	quant=$(echo "scale=3;b=$quant/2;b*2"|bc -l)
	#	quantc=$(echo "$quant"|$PrPWD/stdcarn 1)
	#	if [ "$quantc" = "." ];then quant="0$quant";fi
	long2=$(echo "scale=0;(($long*2))/1"|bc -l)
	long3=$(echo "scale=0;(10^$long2)/1"|bc -l)
	echo "L $long $long2 $long3"
	pricet=$price
	longb=7
	if [ "$symbol" = "ETCETH" ];then
	    longb=6:
	fi
	if [ "$symbol" = "ADAETH" ];then
	    longb=7:
	fi
	if [ "$symbol" = "EOSETH" ];then
	    longb=6
	fi
	if [ "$symbol" = "LTCETH" ];then
	    longb=5
	fi
	if [ "$symbol" = "BNBETH" ];then
	    longb=4
	fi
	if [ "$symbol" = "SOLETH" ];then
	    longb=5
	fi
	if [ "$symbol" = "ADAETH" ];then
	    longb=7
	fi
	if [ "$symbol" = "TRXETH" ];then
	    longb=8
	fi
	if [ "$symbol" = "DOTETH" ];then
	    longb=6
	fi
	if [ "$symbol" = "NEOETH" ];then
	    longb=5
	fi
	if [ "$symbol" = "MATICETH" ];then
	    longb=7
	fi
	echo p $price
	pricec=$(echo "$price + ($price*0.0015)"|bc -l)
	if [ "$symbol" = "LTCETH" ];then pricec=$(echo "$price + ($price*0.0015)"|bc -l) ; fi
	if [ "$symbol" = "BNBETH" ];then pricec=$(echo "$price + ($price*0.0015)"|bc -l) ; fi
	if [ "$symbol" = "ADAETH" ];then pricec=$(echo "$price + ($price*0.0015)"|bc -l) ; fi
	if [ "$symbol" = "SOLETH" ];then pricec=$(echo "$price + ($price*0.002)"|bc -l) ; fi
	if [ "$symbol" = "ETCETH" ];then pricec=$(echo "$price + ($price*0.001)"|bc -l) ; fi
 	echo $pricec . $pricet
	price=$pricec
	pricec=$(echo "$price"|$PrPWD/stdcarn 1)
	if [ "$pricec" = "." ];then price=$(echo "0$price");fi
	lugar=$(echo "$price"|$PrPWD/stdbuscaarg_donde ".")
	longs=$(expr $lugar + 1 + $longb)
 	echo $price . $pricet
	price=$(echo "$price"|$PrPWD/stdcarn $longs)
	echo "PRICE=$price"
	quantentoken=$(echo "scale=$long;($quant*$price)*($long3)"|bc -l|$PrPWD/stdcarn "$long")
	echo $price $quantentoken
#	exit
	quantentoken=$(echo "$quantentoken"|$PrPWD/stdcarsin '.')
	echo "saldo(token)=$saldoentoken"
	saldoentokenactual=0
	quantentokenactual=0;
	echo "<<<$quant>  < $quantentoken> <$quantentokenactual>>"
	coin="ETH"
	symbolprice=$(echo "$symbol" "$coin"|tr -d ' '|tr -d '
')
	    longb=7
	    if [ "$symbol" = "ETCETH" ];then
		longb=5
	    fi
	    if [ "$symbol" = "LTCETH" ];then
		longb=5
	    fi
	    if [ "$symbol" = "EOSETH" ];then
		longb=6
	    fi
	    if [ "$symbol" = "BNBETH" ];then
		longb=4
	    fi
	    if [ "$symbol" = "SOLETH" ];then
		longb=5
	    fi
	    if [ "$symbol" = "TRXETH" ];then
		longb=8
	    fi
	    if [ "$symbol" = "DOTETH" ];then
		longb=6
	    fi
	    if [ "$symbol" = "NEOETH" ];then
		longb=5
	    fi
	    if [ "$symbol" = "MATICETH" ];then
		longb=7
	    fi
	    quantsuma=1
	while [ 0$quantsuma -ne 0 ];do
	    #    while [ "$price" -ge "0$priceactual" ];do
	    #    while [ "$saldoentoken" -ge "0$saldoentokenactual" ];do
	    priceactual=$(curl -L "https://api.binance.com/api/v3/ticker/price?symbols=%5B%22$symbol%22%5D" 2>/dev/null | sed "s/,/$/g" | sed "s/:/=/g" | sed 's/"symbol"/symbol/g' | sed 's/"price"=/price=/g' | tr [{}$] '
' | $PrPWD/stdcdr "price=" | tr -d '"' | tr -d '
')
	    echo " - - - $priceactual "
	    priceactual=$(echo "scale=$longb;$priceactual/1"|bc -l);
	    priceactualc=$(echo "$priceactual"|$PrPWD/stdcarn 1);
	    if [ "$priceactualc" = "." ]; then priceactual="0$priceactual";fi
	    echo "($symbol) ($price) ($priceactual)"
	    #	    priceactual=$(curl -L "https://api.binance.com/api/v3/ticker/price?symbol=$symbol" | $PrPWD/stdcdr price | $PrPWD/stdcdr ':' | $PrPWD/stdcarsin '}' | tr -d '"' )
	    lugar=$(echo "$priceactual"|$PrPWD/stdbuscaarg_donde ".")
	    longs=$(echo "$lugar+$longb+1")
	    
	quantentokenactual=$(echo "scale=$long;(($quant*$priceactual)*($long3))/1"|bc -l|$PrPWD/stdcarn "$long")
	quantentokenactual=$(echo "$quantentokenactual"|$PrPWD/stdcarsin '.')
#	    if [ "$quantentoken" -lt "0$quantentokenactual" ];then break; fi
	    echo "s $saldentoken p $priceactual"
	    saldoentokenactual=$(echo "$saldentoken*$priceactual"|bc -l|$PrPWD/stdcarsin '.')
	    #	echo Q $quant "P $price A $priceactual T 0$saldoentoken 0$saldoentokenactual"
	    echo $quantentoken-$quantentokenactual
	    quantsuma=$(echo "scale=0;($quantentoken-$quantentokenactual)/1"|bc -l)
	    echo "S $symbol Q $quant O $pricet P $price Q $quant A $priceactual S $quantsuma T <0$quantentoken> <0$quantentokenactual>"	    
	    random=$(cat /dev/urandom | $PrPWD/stdcdrn 20 | $PrPWD/stdcarn 4 | $PrPWD/stdtohex | tr -d ' ' | $PrPWD/stdcarn 4)
	    random=$(echo "scale=0;($random % 12)+1;"|bc -l)
#	    exit
	    echo S $random
	    sleep $random
	done
	echo "SOLD"
	timed=$(date +%s%N|$PrPWD/stdcarn 13)
	longs=1
	if [ "$symbol" = "LTCETH" ];then longs=3;fi
	if [ "$symbol" = "BNBETH" ];then longs=3;fi
	if [ "$symbol" = "TRXETH" ];then longs=0;fi
	if [ "$symbol" = "SLPETH" ];then longs=0;fi
	if [ "$symbol" = "EOSETH" ];then longs=1;fi
	if [ "$symbol" = "NEOETH" ];then longs=2;fi
	if [ "$symbol" = "MATICETH" ];then longs=1;fi
	saldoc=$(echo "$saldo"|$PrPWD/stdcarn 1)
	if [ "$saldoc" = "." ];then saldo=$(echo "0$saldo"|tr -d '
'); fi
	lugar=$(echo "$saldo"|$PrPWD/stdbuscaarg_donde ".")
	if [ 0$longs -eq 0 ];then longs=$lugar
	else longs=$(expr $lugar + 1 + $longs)
	fi
	saldo=$(echo "$saldo"|$PrPWD/stdcarn $longs)
	echo "QQ=$saldo"
	params="symbol=$symbol&side=SELL&type=LIMIT&timeInForce=GTC&quantity=$saldo&price=$priceactual&timestamp=$timed"
	signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$SECKEY" | $PrPWD/stdcdr "= ")
	curl -H "X-MBX-APIKEY: $APIKEY" -X POST "https://api.binance.com/api/v3/order" -d "$params&signature=$signature"  > orderSELL_temp 2>/dev/null
	err=$(cat orderSELL_temp | $PrPWD/stdbuscaarg '"code"')
	if [ -n "$err" ];then
	    echo "symbol=$symbol&quantity=$saldo&price=$priceactual"
	    cat orderSELL_temp
	    exit;
	fi
	cat orderSELL_temp >> orderSELL
	echo "" >> orderSELL
	echo "symbol=$symbol; quant=$quant; price=$priceactual" >> orderSELL
	cat orderSELL
	echo "%^%^%^%^%^%^%^%^%^%^%^%^%"

	quantentoken=$(echo "scale=2; $quantentoken/100"|bc -l)
	quantentokenactual=$(echo "scale=2;$quantentokenactual/100"|bc -l)
	ganancia=$(expr $saldoentokenactual - $saldoentoken)
	ganancia=$(echo "$quantentokenactual - $quantentoken" | bc -l)
	echo "ganancia = $ganancia"
	cat buy
	echo "$symbol $price $priceactual $ganancia $quantentokenactual - $quantentoken" >> resumen
	cat buy >> buy.bak
	rm buy

	timed=$(date +%s%N|$PrPWD/stdcarn 13)
	params="symbol=$symbol&timestamp=$timed"
	signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$SECKEY" | $PrPWD/stdcdr "= ")
	opens=$(curl -H "X-MBX-APIKEY: $APIKEY" -L "https://api.binance.com/api/v3/openOrders?$params&signature=$signature" 2>/dev/null)
	echo $opens  > orderSELL_temp
	echo $opens 
	len=$(echo "$opens" | wc -c|$PrPWD/stdcarsin " ")
	while [ 0$len -gt 3 ];do
	    timed=$(date +%s%N|$PrPWD/stdcarn 13)
	    params="symbol=$symbol&timestamp=$timed"
	    signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$SECKEY" | $PrPWD/stdcdr "= ")
	    opens=$(curl -H "X-MBX-APIKEY: $APIKEY" -L "https://api.binance.com/api/v3/openOrders?$params&signature=$signature" 2>/dev/null)
	    echo $opens  > orderSELL_temp
	    echo "$opens"
	    len=$(echo "$opens" | wc -c|$PrPWD/stdcarsin " ")
	done
	saldo=10;
	saldom=$(echo "($quant*$priceactual)*1000"|bc -l|$PrPWD/stdcarsin ".")
	while [ "0$saldom" -lt 1 ];do
	    timed=$(date +%s%N|$PrPWD/stdcarn 13)
	    params="recvWindow=5000&timestamp=$timed"
	    signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$SECKEY" | $PrPWD/stdcdr "= ")
	    saldo=$(curl -H "X-MBX-APIKEY: $APIKEY" -L "https://api.binance.com/api/v3/account?$params&signature=$signature" 2>/dev/null | $PrPWD/stdcdr 'ETH",' | $PrPWD/stdcdr ':' | $PrPWD/stdcarsin ',' | tr -d '"')
	    saldom=$(echo "$saldo*100"|bc -l|$PrPWD/stdcarsin ".")
	    sleep 10
	    echo "saldo=$saldo"
	done
	eval "M$symbol=\"\" "	
    fi

    #,%22XMRETH%22,%22LTCETH%22,
    #    precios=$(curl -L 'https://api.binance.com/api/v3/ticker/price?symbols=%5B%22EURETH%22,%22ETHETH%22,%22ETCETH%22,%22ADAETH%22,%22MATICETH%22,%22XRPETH%22,%22BTCETH%22%5D' | sed "s/,/$/g" | sed "s/:/=/g" | sed 's/"symbol"/symbol/g' | sed 's/"price"=/price=/g' | tr [{}$] '
    #')
    #    curl -L 'https://api.binance.com/api/v3/ticker/price?symbols=%5B%22ADAETH%22,%22MATICETH%22%5D'
    precios=$(curl -L 'https://api.binance.com/api/v3/ticker/price?symbols=%5B%22ETCETH%22,%22NEOETH%22,%22SLPETH%22,%22ADAETH%22,%22MATICETH%22,%22EOSETH%22,%22BNBETH%22,%22LTCETH%22,%22DOTETH%22%5D' 2>/dev/null | sed "s/,/$/g" | sed "s/:/=/g" | sed 's/"symbol"/symbol/g' | sed 's/"price"=/price=/g' | tr [{}$] '
')
    dondes=$( echo "$precios" |$PrPWD/stdbuscaarg_donde '
')
    encuentra="ALGO"
    pricea=0;
    saldo=0;
    
    while [ "0$saldo" -lt 1 ];do
	timed=$(date +%s%N|$PrPWD/stdcarn 13)
	params="recvWindow=5000&timestamp=$timed"
	signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$SECKEY" | $PrPWD/stdcdr "= ")
	saldo=$(curl -H "X-MBX-APIKEY: $APIKEY" -L "https://api.binance.com/api/v3/account?$params&signature=$signature" | $PrPWD/stdcdr 'ETH",' | $PrPWD/stdcdr ':' | $PrPWD/stdcarsin ',' | tr -d '"')
	echo $saldo
	saldo=$(echo "scale=0;($saldo*1000)/1"|bc -l)
	echo "saldo=$saldo"
	sleep 10	
    done
    while [ -n "$dondes" -a -n "$encuentra" ];do
	listf=$(echo "$precios" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
	echo $listf
	posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
	posicion=$(expr 0$posicion + 1)
	dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
	if [ -n "$listf" ];then
	    #	    echo "$listf"
	    eval "$listf"
	    if [ "$symbol" = "$symbolp" ];then
		echo "$symbol = $price"
		pricea=$price
		price=$(echo "$pricea*10000"|bc -l|$PrPWD/stdcarsin '.')
		long=$(echo "$pricea"|$PrPWD/stdcdr "."| wc -c | $PrPWD/stdcarsin ' ')
		if [ 0$long -gt 7 ];then long=7;fi
		if [ 0$long -lt 1 ];then long=1;fi
		eval "psymbol=\$P$symbol"
		longb=$(echo "$pricea"|$PrPWD/stdbuscaarg_donde "."|tr -d '
')
		longb=$(echo "scale=0;($longb+1+$long)/1"|bc -l)		
		suma=$(echo "($saldo*(0$psymbol-$pricea))/1" | bc -l|$PrPWD/stdcarn $longb)
		sumac=$(echo "$suma"|$PrPWD/stdcarn 1)
		if [ "$sumac" = "." ];then suma=$(echo "0$suma");fi
		sumac=$(echo "$suma"|$PrPWD/stdcarn 2)
		if [ "$sumac" = "-." ];then
		    sumac=$(echo "$suma"|$PrPWD/stdcdr  "-.")
		    suma=$(echo "-0.$sumac")
		fi
		sumab=$(echo "($suma/$pricea)*10000"|bc -l)
		sumac=$(echo "$sumab"|$PrPWD/stdcarn 1)
		if [ "$sumac" = "." ];then sumab=$(echo "0$sumab");fi
		sumab=$(echo $sumab|$PrPWD/stdcarsin ".")
		eval "echo \"::>> $symbol \$psymbol = $pricea ($suma)\" "
		mayoromenor=$(echo "$suma"|$PrPWD/stdbuscaarg "-")
		if [ "$suma" = "0.00" -o "$suma" = "0" ];then
		    Qsymbol="=";
		else
		    if [ -n "$mayoromenor" ];then
			Qsymbol="+";
		    else
			Qsymbol="-"
		    fi
		fi
		eval "P$symbol=$pricea"
		#	eval "echo \$P$symbol"
		
		if [ "$Qsymbol" = "+" ];then
		    eval "M$symbol=\"+ \$M$symbol\" "
		    eval "M$symbol=\$(echo \$M$symbol  | tr -d ' '| \$PrPWD/stdcarn 6)"
		fi
		if [ "$Qsymbol" = "=" ];then
		    eval "M$symbol=\"= \$M$symbol\" "
		    eval "M$symbol=\$(echo \$M$symbol  | tr -d ' '| \$PrPWD/stdcarn 6)"
		fi
		if [ "$Qsymbol" = "-" ];then
		    eval "M$symbol=\"- \$M$symbol\" "
		    eval "M$symbol=\$(echo \$M$symbol  | tr -d ' '| \$PrPWD/stdcarn 6)"
		fi
		eval "linea=\$(echo \$M$symbol | \$PrPWD/stdcarn 5)"
		len=$(echo $linea|tr -d '
'|wc -c | $PrPWD/stdcarsin " ")
		if [ 0$len -gt 2 ];then
		    echo "SSS $sumab"
		    if [ "0$sumab" -gt 2 ];then
			eval "\$M$symbol=\"\"";
			linea="";
		    fi
		fi
		mas=$(echo "$linea"|$PrPWD/stdbuscaarg_count "+")
		menos=$(echo "$linea"|$PrPWD/stdbuscaarg_count "-")
		iguales=$(echo "$linea"|$PrPWD/stdbuscaarg_count "=")
		ultimo=$(echo "$linea"|$PrPWD/stdcarn 1)
#		echo "+ $mas - $menos = $iguales"
		echo "$linea"
		BUY=""
		if [ 0$len -eq 5 ];then
		    if [ 0$mas -eq 5 ]; then
			BUY="BUY"
		    fi
		    if [ "$ultimo" = "+" ]; then
			if [ "0$menos" -eq 0 ];then
			    if [ "0$mas" -gt 1 ];then
				BUY="BUY"
			    fi
			fi
		    fi
		    if [ "$ultimo" = "-" ]; then
			if [ "0$mas" -gt 2 ];then
			    BUY="BUY"
			fi
		    fi
		    saldo=0;
		    while [ "$saldo" -lt 1 ];do
			timed=$(date +%s%N|$PrPWD/stdcarn 13)
			params="recvWindow=5000&timestamp=$timed"
			signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$SECKEY" | $PrPWD/stdcdr "= ")
			saldo=$(curl -H "X-MBX-APIKEY: $APIKEY" -L "https://api.binance.com/api/v3/account?$params&signature=$signature" 2>/dev/null | $PrPWD/stdcdr '"ETH",' | $PrPWD/stdcdr ':' | $PrPWD/stdcarsin ',' | tr -d '"')
			saldom=$saldo
			saldo=$(echo "scale=0;($saldo*1000)/1;"|bc -l)
			echo "saldo=$saldo"
			if [ $saldo -lt 1 ];then sleep 10;fi
		    done
		    saldo=$saldom
		    echo "scale=$long;a=($pricea-($pricea*0.0007));a/1"|bc -l
		    echo "_ _ _ _ _ _ _ _ _ _ __"
		    
		    if [ "$BUY" = "BUY" ];then
			echo "$pricea"
			if [ "$symbol" = "ETCETH" ];then long=5;fi
			if [ "$symbol" = "EOSETH" ];then long=6;fi
			if [ "$symbol" = "LTCETH" ];then long=5;fi
			if [ "$symbol" = "BNBETH" ];then long=4;fi
			if [ "$symbol" = "SOLETH" ];then long=5;fi
			if [ "$symbol" = "TRXETH" ];then long=8;fi
			if [ "$symbol" = "NEOETH" ];then long=5;fi
			if [ "$symbol" = "DOTETH" ];then long=6;fi
			if [ "$symbol" = "MATICETH" ];then long=7;fi
			pricec=$(echo "scale=$long;a=($pricea-($pricea*0.0002));a/1"|bc -l);
			if [ $mas -eq 5 ];then pricec=$(echo "scale=$long;a=($pricea-($pricea*0.0001));a/1"|bc -l); fi
			if [ $menos -gt 1 ];then pricec=$(echo "scale=$long;a=($pricea-($pricea*0.0005));a/1"|bc -l); fi
			if [ $menos -gt 1 ];then pricec=$(echo "scale=$long;a=($pricea-($pricea*0.0002));a/1"|bc -l); fi
			if [ "$symbol" = "LTCETH" ];then pricec=$(echo "scale=$long;$pricea/1"|bc -l); fi
			pricea=$pricec
			quantc=$(echo "$pricea"|$PrPWD/stdcarn 1)
			if [ "$quantc" = "." ];then pricea="0$pricea";fi
			echo "$pricea"
			#			exit 1
			longs=1
			if [ "$symbol" = "LTCETH" ];then longs=3;fi
			if [ "$symbol" = "BNBETH" ];then longs=3;fi
			if [ "$symbol" = "SLPETH" ];then longs=0;fi
			if [ "$symbol" = "TRXETH" ];then longs=0;fi
			if [ "$symbol" = "NEOETH" ];then longs=2;fi
			if [ "$symbol" = "SOLETH" ];then longs=3;fi
			if [ "$symbol" = "MATICETH" ];then longs=1;fi
			quant=$(echo "scale=$longs;a=($saldo/$pricea);a/1"|bc -l)
			quantc=$(echo "$quant"|$PrPWD/stdcarn 1)
			if [ "$quantc" = "." ];then quant="0$quant";fi
			echo "$saldo $pricea Q $quant"
			timed=$(date +%s%N|$PrPWD/stdcarn 13)
			params="symbol=$symbol&side=BUY&type=LIMIT&timeInForce=GTC&quantity=$quant&price=$pricea&timestamp=$timed"
			echo "$params"
			signature=$(echo -n "$params" | openssl dgst -sha256 -hmac "$SECKEY" | $PrPWD/stdcdr "= ")
			nomprog=$(echo -n "$nomprograma"|$PrPWD/stdcarsin ".")
			nomprog=$(echo -n "$nomprog .dat"|tr -d ' ')
			curl -H "X-MBX-APIKEY: $APIKEY" -X POST  "https://api.binance.com/api/v3/order" -d "$params&signature=$signature" > orderBUY_temp 2>/dev/null
			err=$(cat orderBUY_temp | $PrPWD/stdbuscaarg '"code"')
			if [ -n "$err" ];then
			    cat orderBUY_temp
			    exit;
			    continue
			fi
			cat orderBUY_temp >> orderBUY
			echo "" >> orderBUY
			echo "Q $quant S $symbol P $price" >> orderBUY
			cat orderBUY
			echo "%^%^%^%^%^%^%^%^%^%^%^%^%"
			
			echo "$symbol=$pricea" > buy
			echo "quant=$quant" > quant
			echo "Q $quant S $symbol P $price"
			break
		    fi
		fi
	    fi
	    symbolp=$symbol
	fi
    done
    if [ "$BUY" != "BUY" ];then
	random=$(cat /dev/urandom | $PrPWD/stdcdrn 20 | $PrPWD/stdcarn 4 | $PrPWD/stdtohex | tr -d ' ' | $PrPWD/stdcarn 4)
	random=$(echo "ibase=16;($random*1)"|bc)
	random=$(expr $random % 30)
	echo r $random
	random=$(expr $random + 25)
	echo r $random
	sleep $random
    fi
    echo "."
done
