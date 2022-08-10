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
encuentra="ALGO"
listc=$(curl -L "https://api.binance.com/api/v3/ticker/24hr")
listp=""
listq=""
encuentra="ALGO"
nomlistq=$(echo "$nomprograma -listq"|$PrPWD/stddelcar ' ')
echo $nomlistq
while [ -n "$encuentra" ];do
    symbolq=$(echo "$listc"|$PrPWD/stdcdr '"symbol":'|$PrPWD/stdcarsin ","|$PrPWD/stddelcar '"'|$PrPWD/stddelcar ' ')
    encuentra=$(cat "$nomlistq"|$PrPWD/stdbuscaarg "$symbolq;")
    if [ -z "$encuentra" ];then
	echo "$symbolq;"
        echo "$symbolq; " >> "$nomlistq"
    fi
    listc=$(echo "$listc" | $PrPWD/stdcdr '"symbol":')
    encuentra=$(echo "$listc"|$PrPWD/stdbuscaarg '"symbol":')
done
lista0=$(cat "$nomlistq"|sort|uniq|$PrPWD/stddelcar '
')
busca=".."
posicion=0;
dondes=$( echo "$lista0" |$PrPWD/stdbuscaarg_donde ";")
encuentra="ALGO"
touch $nomprograma.memoria
while [ -n "$dondes"  ];do
    listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin ';' | $PrPWD/stddelcar ' ')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	symbol="$listf"
	interval="15"
	timed=$(date +%s)
	timed=$(echo "0$timed -($interval*250*60)"|bc -l)
	times=$(echo "$timed*1000"|bc -l|$PrPWD/stdcarsin '.')
	echo " - .+ .+ .+ .+ .+ .+ .+ .+ "
	interval=$(echo -n "$interval m"|tr -d ' ')
	continua=1;
	while [ 0$continua -gt 0 ];do
	    paramt="symbol=$symbol&startTime=$times&interval=$interval&limit=1"
	    echo " % # % # % # % # % #    $paramt"
	    l=1;
	    while [ $l -lt 3 ];do
		rew=$(curl -L "https://api.binance.com/api/v3/klines?$paramt")
		echo "$rew"
		l=$(echo "$rew"|wc -c)
	    done
	    opena=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcarsin "," | tr -d '"')
	    rew=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcdr ",")
	    high=$(echo "$rew" | $PrPWD/stdcarsin "," | tr -d '"')
	    low=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcarsin ","  | tr -d '"')
	    closea=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcdr "," | $PrPWD/stdcarsin ","  | tr -d '"')
	    echo "($opena+$high+$low+$closea)/4"
	    price=$(echo "($opena+$high+$low+$closea)/4"|bc -l)
	    price2=$(echo "$price+($price*0.05)"|bc -l)
	    price3=$(echo "$price-($price*0.05)"|bc -l)
	    p1=$(echo "$price"|$PrPWD/stdcarn 1)
	    p2=$(echo "$price"|$PrPWD/stdcarn 1)
	    p3=$(echo "$price"|$PrPWD/stdcarn 1)
	    if [ "$p1" = "." ];then
		price=$(echo "0$price")
		price2=$(echo "0$price2")
		price3=$(echo "0$price3")
	    fi
	    interval="15"
	    timee=$timed
	    timed=$times #$(echo "$times/1000"|bc -l|$PrPWD/stdcarsin ".")
	    echo " - .- .- .- .- .- .- .- .- "
	    echo " $times "
	    echo " $timed "
	    echo " $price "
	    echo " $price2 "
	    echo " $price3 "
	    sleep 3
	    date --date $(echo -n "@"$(echo "$times"|bc -l|$PrPWD/stdcarsin "."))
	    echo "0$timed - ( $interval * 250 * 60 * 1000)"
	    echo "0$times"
	    date --date $(echo -n "@"$(echo "$timed"|bc -l|$PrPWD/stdcarsin "."))
	    echo " - .- .- .- .- .- .- .- .- "
	    interval=$(echo -n "$interval m"|tr -d ' ')
	    params="symbol=$symbol&startTime=$times&interval=$interval"
	    rew=$(curl -L "https://api.binance.com/api/v3/klines?$params")
	    echo "$rew"|$PrPWD/stdcarn 120
	    continua=0
	    if [ -z "$rew" ];then
		continua=1
		continue;
	    fi
	    rew=$(echo -n "$rew"|$PrPWD/stdcdr "[")
	    l2=$(echo "$rew" | $PrPWD/stdbuscaarg_count ",[")
	    l2=$(expr 0$l2 + 1)
	    l3=$(expr 0$l2 + 1)
	    echo " * s * s * s * s * s * s * s * s * s * s * >>>>>  |>|$orderid : $l2 |<| "
	    opentimes="{0"
	    highs="{0"
	    lows="{0"
	    opens="{0"
	    closes="{0"
	    while [ 0$l2 -gt 0 ];do
		opentime=$(echo "$rew" | $PrPWD/stdcarsin ","|$PrPWD/stddelcar ","|$PrPWD/stddelcar "[")
		opentime=$(echo "$opentime/1000"|bc -l|$PrPWD/stdcarsin ".")
		opena=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcarsin "," | tr -d '"')
		rew=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcdr ",")
		high=$(echo "$rew" | $PrPWD/stdcarsin "," | tr -d '"')
		low=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcarsin ","  | tr -d '"')
		closea=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcdr "," | $PrPWD/stdcarsin ","  | tr -d '"')
		rew=$(echo "$rew" | tr -d '
'|$PrPWD/stdcdr "]" | $PrPWD/stdcdr "[")
		opentimes=$(echo "$opentimes, $opentime" | tr -d '
')
		highs=$(echo "$highs, $high" | tr -d '
')
		lows=$(echo "$lows, $low" | tr -d '
')
		opens=$(echo -n "$opens, $opena" | tr -d '
')
		closes=$(echo -n "$closes, $closea" | tr -d '
')
		# continua=0;
		# if [ 0$opentime -gt 0 ];then
		#     continua=$(echo -n "$opentime"|wc -c|$PrPWD/stdcarsin " "|$PrPWD/stddelcar ","|$PrPWD/stddelcar "[")
		#     if [ 0$continua -lt 13 ];then
		# 	echo "OOOOO $opentime"
		# 	continua=1;
		# 	break;
		#     fi
		#     continua=0;
		# fi
		l2=$(expr 0$l2 - 1)
	    done
	done
	archname=$(echo -n "$PaPWD/$listf" | $PrPWD/stdcarsin ".")
	archname=$(echo -n "$archname-$nomprograma" | $PrPWD/stdcarsin ".")
	archname=$(echo -n "$archname-prices" | $PrPWD/stdcarsin ".")
	cat "$PrPWD/EMA.c" | $PrPWD/stdcar "double highs[" > "$archname-EMA.c"
	echo "$l3]=$highs };" | tr -d '
' >> "$archname-EMA.c"
	cat "$PrPWD/EMA.c" | $PrPWD/stdcdr "double highs[" | $PrPWD/stdcdr ";" >> "$archname-EMA.c"
	cat "$archname-EMA.c" | $PrPWD/stdcar "double lows[" > "$archname-EMA-ii.c"
	echo "$l3]=$lows };"| tr -d '
' >> "$archname-EMA-ii.c"
	cat "$archname-EMA.c" | $PrPWD/stdcdr "double lows[" | $PrPWD/stdcdr ";" >> "$archname-EMA-ii.c"
	mv "$archname-EMA-ii.c" "$archname-EMA.c"
	cat "$archname-EMA.c" | $PrPWD/stdcar "double closo[" > "$archname-EMA-ii.c"
	echo "$l3]=$closes };"| tr -d '
' >> "$archname-EMA-ii.c"
	cat "$archname-EMA.c" | $PrPWD/stdcdr "double closo[" | $PrPWD/stdcdr ";" >> "$archname-EMA-ii.c"
	mv "$archname-EMA-ii.c" "$archname-EMA.c"
	errores=$(gcc "$archname-EMA.c" -o "$archname-EMA-bin" 2>&1)
	if [ -n "$errores" ];then
	    echo "ERROR CREANDO EMA ! ! ! ! ! ! ! ! ! ! ! ! ! !"
	    mv "$archname-EMA.c" "$archname-EMA.txt"
	    echo "$errores"
	else
	    echo "#include <stdio.h>"  > "$archname-EMA-ii.c"
	    echo "#include <stdlib.h>" >> "$archname-EMA-ii.c"
	    echo "int main(int argc, char *argv[]) {" >> "$archname-EMA-ii.c"
	    $archname-EMA-bin >> "$archname-EMA-ii.c"
	    echo "long opentimes[$l3]=$opentimes};"  >> "$archname-EMA-ii.c"
	    echo "int i=1; while (i<$l3) { printf(\"%08ld %08.8lf 1.1 1.1 1.1\n\", opentimes[i], EMAi[i]); i++; }" >> "$archname-EMA-ii.c"
	    echo "}" >> "$archname-EMA-ii.c"
	    errores=$(gcc "$archname-EMA-ii.c" -o "$archname-EMA-ii" 2>&1)
	    if [ -n "$errores" ];then
		mv "$archname-EMA-ii.c" "$archname-EMA-ii.txt"
		echo "!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!"
		echo "$errores"
	    else
		$archname-EMA-ii > $archname-EMA.dat
		#cat "$archname-EMA.c" | $PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}" | tr ',' ' ' > $archname-EMA.dat
	    fi
	fi
	###############
	## Bollinger
	cat "$PrPWD/bollinger_bands.c" | $PrPWD/stdcar "double periodo=" > "$archname-bollinger.c"
	echo "20.00;" | tr -d '
' >> "$archname-bollinger.c"
	cat "$PrPWD/bollinger_bands.c" | $PrPWD/stdcdr "double periodo=" | $PrPWD/stdcdr ";" >> "$archname-bollinger.c"
	cat "$archname-bollinger.c" | $PrPWD/stdcar "double highs[" > "$archname-bollinger-ii.c"
	echo "$l3]=$highs };" | tr -d '
' >> "$archname-bollinger-ii.c"
	cat "$archname-bollinger.c" | $PrPWD/stdcdr "double highs[" | $PrPWD/stdcdr ";" >> "$archname-bollinger-ii.c"
	mv "$archname-bollinger-ii.c" "$archname-bollinger.c"

	cat "$archname-bollinger.c" | $PrPWD/stdcar "int l3=" > "$archname-bollinger-ii.c"
	echo "$l3;" | tr -d '
' >> "$archname-bollinger-ii.c"
	cat "$archname-bollinger.c" | $PrPWD/stdcdr "int l3=" | $PrPWD/stdcdr ";" >> "$archname-bollinger-ii.c"
	mv "$archname-bollinger-ii.c" "$archname-bollinger.c"

	cat "$archname-bollinger.c" | $PrPWD/stdcar "double media[" > "$archname-bollinger-ii.c"
	echo "$l3];" | tr -d '
' >> "$archname-bollinger-ii.c"
	cat "$archname-bollinger.c" | $PrPWD/stdcdr "double media[" | $PrPWD/stdcdr ";" >> "$archname-bollinger-ii.c"
	mv "$archname-bollinger-ii.c" "$archname-bollinger.c"

	cat "$archname-bollinger.c" | $PrPWD/stdcar "standard_deviation[" > "$archname-bollinger-ii.c"
	echo "$l3];" | tr -d '
' >> "$archname-bollinger-ii.c"
	cat "$archname-bollinger.c" | $PrPWD/stdcdr "standard_deviation[" | $PrPWD/stdcdr ";" >> "$archname-bollinger-ii.c"
	mv "$archname-bollinger-ii.c" "$archname-bollinger.c"

	cat "$archname-bollinger.c" | $PrPWD/stdcar "EMA[" > "$archname-bollinger-ii.c"
	echo "$l3];" | tr -d '
' >> "$archname-bollinger-ii.c"
	cat "$archname-bollinger.c" | $PrPWD/stdcdr "EMA[" | $PrPWD/stdcdr ";" >> "$archname-bollinger-ii.c"
	mv "$archname-bollinger-ii.c" "$archname-bollinger.c"

	cat "$archname-bollinger.c" | $PrPWD/stdcar "double lows[" > "$archname-bollinger-ii.c"
	echo "$l3]=$lows };"| tr -d '
' >> "$archname-bollinger-ii.c"
	cat "$archname-bollinger.c" | $PrPWD/stdcdr "double lows[" | $PrPWD/stdcdr ";" >> "$archname-bollinger-ii.c"
	mv "$archname-bollinger-ii.c" "$archname-bollinger.c"
	cat "$archname-bollinger.c" | $PrPWD/stdcar "double closo[" > "$archname-bollinger-ii.c"
	echo "$l3]=$closes };"| tr -d '
' >> "$archname-bollinger-ii.c"
	cat "$archname-bollinger.c" | $PrPWD/stdcdr "double closo[" | $PrPWD/stdcdr ";" >> "$archname-bollinger-ii.c"
	mv "$archname-bollinger-ii.c" "$archname-bollinger.c"
	errores=$(gcc "$archname-bollinger.c" -lm -o "$archname-bollinger-bin" 2>&1)
	if [ -n "$errores" ];then
	    echo "ERROR CREANDO BOLLINGER ! ! ! ! ! ! ! ! ! ! ! ! ! !"
	    mv "$archname-bollinger.c" "$archname-bollinger.txt"
	    echo "$errores"
	else
	    echo "#include <stdio.h>"  > "$archname-bollinger-ii.c"
	    echo "#include <stdlib.h>" >> "$archname-bollinger-ii.c"
	    echo "int main(int argc, char *argv[]) {" >> "$archname-bollinger-ii.c"
	    $archname-bollinger-bin >> "$archname-bollinger-ii.c"
	    echo "long opentimes[$l3]=$opentimes};"  >> "$archname-bollinger-ii.c"
	    echo "int i=1; while (i<$l3) { printf(\"%08ld %08.8lf %08.8lf\n\", opentimes[i], BOLU[i], BOLD[i]); i++; }" >> "$archname-bollinger-ii.c"
	    echo "}" >> "$archname-bollinger-ii.c"
	    errores=$(gcc "$archname-bollinger-ii.c" -o "$archname-bollinger-ii" 2>&1)
	    if [ -n "$errores" ];then
		mv "$archname-bollinger-ii.c" "$archname-bollinger-ii.txt"
		echo "!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!"
		echo "$errores"
	    else
		$archname-bollinger-ii > $archname-bollinger.dat
		#cat "$archname-bollinger.c" | $PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}" | tr ',' ' ' > $archname-bollinger.dat
	    fi
	fi
	###############
	cat "$PrPWD/EMA.c" | $PrPWD/stdcar "double highs[" > "$archname-EMA-50.c"
	echo "$l3]=$highs };" | tr -d '
' >> "$archname-EMA-50.c"
	cat "$PrPWD/EMA.c" | $PrPWD/stdcdr "double highs[" | $PrPWD/stdcdr ";" >> "$archname-EMA-50.c"
	cat "$archname-EMA.c" | $PrPWD/stdcar "double lows[" > "$archname-EMA-ii.c"
	echo "$l3]=$lows };"| tr -d '
' >> "$archname-EMA-ii.c"
	cat "$archname-EMA.c" | $PrPWD/stdcdr "double lows[" | $PrPWD/stdcdr ";" >> "$archname-EMA-ii.c"
	mv "$archname-EMA-ii.c" "$archname-EMA-50.c"
	errores=$(gcc "$archname-EMA.c" -o "$archname-EMA-bin" 2>&1)
	if [ -n "$errores" ];then
	    echo "ERROR CREANDO EMA ! ! ! ! ! ! ! ! ! ! ! ! ! !"
	    mv "$archname-EMA.c" "$archname-EMA.txt"
	    echo "$errores"
	else
	    echo "#include <stdio.h>"  > "$archname-EMA-ii.c"
	    echo "#include <stdlib.h>" >> "$archname-EMA-ii.c"
	    echo "int main(int argc, char *argv[]) {" >> "$archname-EMA-ii.c"
	    $archname-EMA-bin >> "$archname-EMA-ii.c"
	    echo "long opentimes[$l3]=$opentimes};"  >> "$archname-EMA-ii.c"
	    echo "int i=1; while (i<$l3) { printf(\"%08ld %08.8lf 1.1 1.1 1.1\n\", opentimes[i], EMAi[i]); i++; }" >> "$archname-EMA-ii.c"
	    echo "}" >> "$archname-EMA-ii.c"
	    errores=$(gcc "$archname-EMA-ii.c" -o "$archname-EMA-ii" 2>&1)
	    if [ -n "$errores" ];then
		mv "$archname-EMA-ii.c" "$archname-EMA-ii.txt"
		echo "!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!"
		echo "$errores"
	    else
		$archname-EMA-ii > $archname-EMA-50.dat
		#cat "$archname-EMA.c" | $PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}" | tr ',' ' ' > $archname-EMA.dat
	    fi
	fi
	###############
	cat "$PrPWD/buscaprice.c" | $PrPWD/stdcar "double opentimes[" > "$archname.c"
	opentimes=$(echo -n "$l3]=$opentimes };") 
	echo "$opentimes" | tr -d '
' >> "$archname.c"
	cat "$PrPWD/buscaprice.c" | $PrPWD/stdcdr "double opentimes[" | $PrPWD/stdcdr ";" >> "$archname.c"
	cat "$archname.c" | $PrPWD/stdcar "double highs[" > "$archname-ii.c"
	echo "$l3]=$highs };" | tr -d '
' >> "$archname-ii.c"
	cat "$archname.c" | $PrPWD/stdcdr "double highs[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
	mv "$archname-ii.c" "$archname.c"
	cat "$archname.c" | $PrPWD/stdcar "double lows[" > "$archname-ii.c"
	echo "$l3]=$lows };" | tr -d '
' >> "$archname-ii.c"
	cat "$archname.c" | $PrPWD/stdcdr "double lows[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
	mv "$archname-ii.c" "$archname.c"
	cat "$archname.c" | $PrPWD/stdcar "double openo[" > "$archname-ii.c"
	echo "$l3]=$opens };" | tr -d '
' >> "$archname-ii.c"
	cat "$archname.c" | $PrPWD/stdcdr "double openo[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
	mv "$archname-ii.c" "$archname.c"
	
	cat "$archname.c" | $PrPWD/stdcar "double closeo[" > "$archname-ii.c"
	closes=$(echo -n "$l3]=$closes };")
	echo -n "$closes" >> "$archname-ii.c"
	cat "$archname.c" | $PrPWD/stdcdr "double closeo[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
	mv "$archname-ii.c" "$archname.c"

	cat "$archname.c" | $PrPWD/stdcar "double price=" > "$archname-ii.c"
	echo "$price;" >> "$archname-ii.c"
	cat "$archname.c" | $PrPWD/stdcdr "double price=" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
	mv "$archname-ii.c" "$archname.c"
	
	cat "$archname.c" | $PrPWD/stdcar "double timestart=" > "$archname-ii.c"
	echo "$timee;" >> "$archname-ii.c"
	cat "$archname.c" | $PrPWD/stdcdr "double timestart=" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
	mv "$archname-ii.c" "$archname.c"

	cat "$archname.c" | $PrPWD/stdcar "int l3=" > "$archname-ii.c"
	echo "$l3;" >> "$archname-ii.c"
	cat "$archname.c" | $PrPWD/stdcdr "int l3=" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
	mv "$archname-ii.c" "$archname.c"
	archnamprice="B"
	errores=$(gcc "$archname.c" -o "$archname-bin" 2>&1)
	if [ -n "$errores" ];then
	    echo "! ! ! ! ! ! ! ! ! ! ! ! ! !"
	    mv "$archname.c" "$archname.txt"
	    echo "$errores"
	else
	    echo "#include <stdio.h>"  > "$archname-ii.c"
	    echo "#include <stdlib.h>" >> "$archname-ii.c"
	    echo "int main(int argc, char *argv[]) {" >> "$archname-ii.c"
	    $archname-bin >> "$archname-ii.c"
	    echo "}" >> "$archname-ii.c"
	    errores=$(gcc "$archname-ii.c" -o "$archname-ii" 2>&1)
	    if [ -n "$errores" ];then
		mv "$archname-ii.c" "$archname-ii.txt"
		echo "!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!"
		echo "$errores"
	    else
		variables=$(cat "$archname-ii.c" | $PrPWD/stddeclaracionesdevariable)
		echo "$variables"
		encuentra=$(echo ";$variables" | $PrPWD/stdcdr "long prefix_porencimadecincoadelante=" | $PrPWD/stdcarsin ";")
		if [ -n "$encuentra" ];then
		    if [ 0$encuentra -gt 0 ];then
			echo -n "0" >> "$archname-mascinco.dat"
			echo ";$variables" | $PrPWD/stdcdr "long prefix_porencimadecincoadelante=" | $PrPWD/stdcarsin ";" >> "$archname-mascinco.dat"
			echo -n " 0" >> "$archname-mascinco.dat"
			echo ";$variables" | $PrPWD/stdcdr "double prefix_priceporencimadecincoadelante=" | $PrPWD/stdcarsin ";" >> "$archname-mascinco.dat"
			echo ""  >> "$archname-mascinco.dat"
		    fi
		fi
		encuentra=$(echo ";$variables" | $PrPWD/stdcdr "long prefix_pordebajodecincoadelante=" | $PrPWD/stdcarsin ";")
		if [ -n "$encuentra" ];then
		    if [ 0$encuentra -gt 0 ];then
			echo -n "0" >> "$archname-menoscinco.dat"
			echo ";$variables" | $PrPWD/stdcdr "long prefix_pordebajodecincoadelante=" | $PrPWD/stdcarsin ";" >> "$archname-menoscinco.dat"
			echo -n " 0" >> "$archname-menoscinco.dat"
			echo ";$variables" | $PrPWD/stdcdr "double prefix_pricepordebajodecincoadelante=" | $PrPWD/stdcarsin ";" >> "$archname-menoscinco.dat"
			echo " " >> "$archname-menoscinco.dat"
		    fi
		fi
		################################
		supportadelante=0;
		encuentra=$(echo ";$variables" | $PrPWD/stdcdr "double prefix_supportadelante=" | $PrPWD/stdcarsin ";")
		if [ -n "$encuentra" ];then
		    supportadelante=$(echo ";$variables" | $PrPWD/stdcdr "double prefix_supportadelante=" | $PrPWD/stdcarsin ";")
		fi

		#################################
		################################
		resistanceadelante=0;
		encuentra=$(echo ";$variables" | $PrPWD/stdcdr "double prefix_resistanceadelante=" | $PrPWD/stdcarsin ";")
		if [ -n "$encuentra" ];then
		    resistanceadelante=$(echo ";$variables" | $PrPWD/stdcdr "double prefix_resistanceadelante=" | $PrPWD/stdcarsin ";")
		fi

		#################################
		################################
		supportatras=0;
		encuentra=$(echo ";$variables" | $PrPWD/stdcdr "double prefix_supportatras=" | $PrPWD/stdcarsin ";")
		if [ -n "$encuentra" ];then
		    supportatras=$(echo ";$variables" | $PrPWD/stdcdr "double prefix_supportatras=" | $PrPWD/stdcarsin ";")
		fi

		#################################
		################################
		resistanceatras=0;
		encuentra=$(echo ";$variables" | $PrPWD/stdcdr "double prefix_resistanceatras=" | $PrPWD/stdcarsin ";")
		if [ -n "$encuentra" ];then
		    resistanceatras=$(echo ";$variables" | $PrPWD/stdcdr "double prefix_resistanceatras=" | $PrPWD/stdcarsin ";")
		fi

		#################################
		encuentra=$(echo ";$variables" | $PrPWD/stdcdr "long prefix_porencimadecincoatras=" | $PrPWD/stdcarsin ";")
		if [ -n "$encuentra" ];then
		    if [ 0$encuentra -gt 0 ];then
			echo -n "0" >> "$archname-mascinco.dat"
			echo ";$variables" | $PrPWD/stdcdr "long prefix_porencimadecincoatras=" | $PrPWD/stdcarsin ";" >> "$archname-mascinco.dat"
			echo -n " 0" >> "$archname-mascinco.dat"
			echo ";$variables" | $PrPWD/stdcdr "double prefix_priceporencimadecincoatras=" | $PrPWD/stdcarsin ";" >> "$archname-mascinco.dat"
			echo ""  >> "$archname-mascinco.dat"
		    fi
		fi
		encuentra=$(echo ";$variables" | $PrPWD/stdcdr "long prefix_porebajodecincoatras=" | $PrPWD/stdcarsin ";")
		if [ -n "$encuentra" ];then
		    if [ 0$encuentra -gt 0 ];then
			echo -n "0" >> "$archname-menoscinco.dat"
			echo ";$variables" | $PrPWD/stdcdr "long prefix_pordebajodecincoatras=" | $PrPWD/stdcarsin ";" >> "$archname-menoscinco.dat"
			echo -n " 0" >> "$archname-menoscinco.dat"
			echo ";$variables" | $PrPWD/stdcdr "double prefix_pricepordebajodecincoatras=" | $PrPWD/stdcarsin ";" >> "$archname-menoscinco.dat"
			echo " " >> "$archname-menoscinco.dat"
		    fi
		fi
		archnamprice="$archname"
	    fi
	fi

	cat "$PrPWD/fromklinestorsi.c" | $PrPWD/stdcar "double opentimes[" > "$archname-rsi.c"
	echo "$opentimes" | tr -d '
' >> "$archname-rsi.c"
	cat "$PrPWD/fromklinestorsi.c" | $PrPWD/stdcdr "double opentimes[" | $PrPWD/stdcdr ";" >> "$archname-rsi.c"
	
	cat "$archname-rsi.c" | $PrPWD/stdcar "double highs[" > "$archname-rsi-ii.c"
	echo -n "$l3]=$highs };" >> "$archname-rsi-ii.c"
	cat "$archname-rsi.c" | $PrPWD/stdcdr "double highs[" | $PrPWD/stdcdr ";" >> "$archname-rsi-ii.c"
	mv "$archname-rsi-ii.c" "$archname-rsi.c"
	cat "$archname-rsi.c" | $PrPWD/stdcar "double lows[" >> "$archname-rsi-ii.c"
	echo "$l3]=$lows };" | tr -d '
' >> "$archname-rsi-ii.c"
	cat "$archname-rsi.c" | $PrPWD/stdcdr "double lows[" | $PrPWD/stdcdr ";" >> "$archname-rsi-ii.c"
	mv "$archname-rsi-ii.c" "$archname-rsi.c"
	cat "$archname-rsi.c" | $PrPWD/stdcar "double price=" > "$archname-rsi-ii.c"
	echo -n "$price;" >> "$archname-rsi-ii.c"
	cat "$archname-rsi.c" | $PrPWD/stdcdr "double price=" | $PrPWD/stdcdr ";" >> "$archname-rsi-ii.c"
	mv "$archname-rsi-ii.c" "$archname-rsi.c"
	cat "$archname-rsi.c" | $PrPWD/stdcar "int l3=" > "$archname-rsi-ii.c"
	echo "$l3;" >> "$archname-rsi-ii.c"
	cat "$archname-rsi.c" | $PrPWD/stdcdr "int l3=" | $PrPWD/stdcdr ";" >> "$archname-rsi-ii.c"
	mv "$archname-rsi-ii.c" "$archname-rsi.c"
	errores=$(gcc "$archname-rsi.c" -o "$archname-rsi-bin" 2>&1)
	if [ -n "$errores" ];then
	    mv "$archname-rsi.c" "$archname-rsi.txt"
	    echo "! ! ! ! ! ! ! ! ! ! ! ! ! !"
	    echo "$errores"
	else
	    echo "#include <stdio.h>"  > "$archname-rsi-ii.c"
	    echo "#include <stdlib.h>" >> "$archname-rsi-ii.c"
	    echo "int main(int argc, char *argv[]) {" >> "$archname-rsi-ii.c"
	    echo "long opentimes[$opentimes" >> "$archname-rsi-ii.c"
	    echo "double highs[$l3]=$highs };" >> "$archname-rsi-ii.c"
	    echo "double lows[$l3]=$lows };" >> "$archname-rsi-ii.c"
	    $archname-rsi-bin >> "$archname-rsi-ii.c"
	    echo "int l=1;while(l<$l3) {if (rsi[l]>0) printf(\"%08ld %08lf %08lf\n\", opentimes[l], rsi[l], (highs[l]+lows[l])/2);l++;};"  >> "$archname-rsi-ii.c"
	    echo "}" >> "$archname-rsi-ii.c"
	    errores=$(gcc "$archname-rsi-ii.c" -o "$archname-rsi-ii" 2>&1)
	    if [ -n "$errores" ];then
		echo "!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!"
		mv "$archname-rsi.c" "$archname-rsi.txt"
		echo "$errores"
	    else
		"$archname-rsi-ii" > "$archname-rsi.dat"
	    fi
	fi
	echo " * f * f * f * f * f * f * f * f * f * f * "
	echo "set term postscript landscape color solid" > "$archname.gnuplot"
	echo "set terminal png size 1600,800 enhanced font 'Helvetica,10'" >> "$archname.gnuplot"
	echo "set output '$archname-gnuplot.png'" >> "$archname.gnuplot"
	echo "set xdata time" >> "$archname.gnuplot"
	echo "set timefmt \"%s\"" >> "$archname.gnuplot"
	echo "set format x \"%m/%d/%Y %H:%M:%S\"" >> "$archname.gnuplot"
	echo "set xlabel \"time\"" >> "$archname.gnuplot"
	echo "set key top left" >> "$archname.gnuplot"
	echo "set autoscale" >> "$archname.gnuplot"
	echo "set title \"$status\"" >> "$archname.gnuplot"
	echo "set style line 12 lc rgb 'green' lt 1 lw 1" >> "$archname.gnuplot"
	echo "set style line 13 lc rgb 'pink' lt 1 lw 1" >> "$archname.gnuplot"
	echo "set style line 14 lc rgb '#226282' lt 1 lw 1" >> "$archname.gnuplot"
	echo "set style line 15 lc rgb '#533288' lt 1 lw 1" >> "$archname.gnuplot"
	#				echo "set grid xtics ytics mxtics mytics ls 12, ls 13" >> "$archname.gnuplot"
	#				echo "set mxtics 2" >> "$archname.gnuplot"
	#				echo "set mytics 2" >> "$archname.gnuplot"
	#				echo "set grid" >> "$archname.gnuplot"
	echo "set style function linespoints" >> "$archname.gnuplot"
	echo "set style line 1 lw 1 lc rgb '#c0ce42' ps 2 pt 1 pi 1" >> "$archname.gnuplot"
	echo "set style line 2 lw 1 lc rgb '#0511ff' ps 3 pt 1 pi 1" >> "$archname.gnuplot"
	echo "set style line 3 lw 1 lc rgb '#132ff8' ps 6 pt 2 pi 2" >> "$archname.gnuplot"
	echo "set style line 4 lw 1 lc rgb '#f81a13' ps 6 pt 2 pi 2" >> "$archname.gnuplot"
	echo "set style line 5 lw 1 lc rgb '#36b94b' ps 6 pt 2 pi 2" >> "$archname.gnuplot"
	echo "set style line 6 lw 1 lc rgb '#a636b9' ps 6 pt 2 pi 2" >> "$archname.gnuplot"
	echo "set multiplot layout 4,1 columnsfirst" >> "$archname.gnuplot"
	times=$(echo "$times/1000"|bc -l|$PrPWD/stdcarsin ".")
	echo "$times $price" > "$archnamprice-price0.dat"
	echo -n "plot \"$archname-rsi.dat\" using 1:3 ls 2 w lines title \"PRECIO\", \"$archnamprice-price0.dat\" using 1:2:(sprintf(\"$status (%s, %f)\", system (sprintf(\"date -d @%d +'%F %T'\", \$1)), \$2)) with labels point ps 2 pt 4 offset char 1,1 notitle" >> "$archname.gnuplot"
	if [ -n "$resistanceadelante" ];then
	    echo -n ", $resistanceadelante ls 14 w lines notitle "  >> "$archname.gnuplot"
	fi
	if [ -n "$supportadelante" ];then
	    echo -n ", $supportadelante ls 14 w lines notitle"  >> "$archname.gnuplot"
	fi
	if [ -n "$resistanceatras" ];then
	    echo -n ", $resistanceatras ls 14 w lines notitle"  >> "$archname.gnuplot"
	fi
	if [ -n "$supportatras" ];then
	    echo -n ", $supportatras ls 14 w lines notitle"  >> "$archname.gnuplot"
	fi
	if [ -f  "$archnamprice-menoscinco.dat" ];then
	    echo -n ",  \"$archnamprice-menoscinco.dat\" using 1:2:(sprintf(\"-5%% (%s, %f)\", system (sprintf(\"date -d @%d +'%F %T'\", \$1)), \$2)) with labels point ps 2 pt 6 offset char 1,1 notitle"  >> "$archname.gnuplot"
	fi
	if [ -f  "$archnamprice-mascinco.dat" ];then
	    echo -n ",  \"$archnamprice-mascinco.dat\" using 1:2:(sprintf(\"-5%% (%s, %f)\", system (sprintf(\"date -d @%d +'%F %T'\", \$1)), \$2)) with labels point ps 2 pt 6 offset char 1,1 notitle"  >> "$archname.gnuplot"
	fi
	echo ""  >> "$archname.gnuplot"
	echo "plot \"$archname-EMA-50.dat\" using 1:2 ls 4 w lines title \"EMA 50\", \"$archname-EMA.dat\"  using 1:2  ls 5 with lines title \"EMA 200\"" >> "$archname.gnuplot"
	echo "plot \"$archname-bollinger.dat\"  using 1:2  ls 5 with lines title \"Bollinger\", \"$archname-bollinger.dat\"  using 1:3  ls 6 with lines notitle"  >> "$archname.gnuplot"  >> "$archname.gnuplot"
	echo "plot \"$archname-rsi.dat\" using 1:2 ls 1 w lines title \"RSI\""  >> "$archname.gnuplot"  >> "$archname.gnuplot"
	gnuplot "$archname.gnuplot"
	size=$(echo -n "$archname-gnuplot.png"|wc -c)
	echo "#include <stdio.h>"  > "$archname-imagen.c"
	echo "#include <stdlib.h>" >> "$archname-imagen.c"
	echo "int main(int argc, char *argv[]) {" >> "$archname-imagen.c"
	echo "char imagen[$size]=\"$archname-gnuplot.png\";" >> "$archname-imagen.c"
	echo "}" >> "$archname-imagen.c"
	echo " * f * f * f * f * f * f * f * f * f * f * "
    fi
done
rm "$nomprograma.lock-$ps1"
$0

