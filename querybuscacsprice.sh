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
if [ -d "$PrPWD/orders/" ];then
    listados=$(echo $PrPWD/orders|$PrPWD/listadodirectorio_dirs_from_std|$PrPWD/stdbuscaarg_donde '
')
    listado=$(echo $PrPWD/orders|$PrPWD/listadodirectorio_dirs_from_std)
    salta=0;
    while [ -n "$listados" ];do
	presalta=$(echo -n "$listados" | $PrPWD/stdcar " ")
	salta=$(expr 0$presalta + 1)
	dirn=$(echo -n "$listado"|$PrPWD/stdcdrn 0$salta | $PrPWD/stdcarn $presalta)
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std_extension_c )
	lista2=$(echo -n "$lista1
$lista0" )
	lista0=$lista2
	listados=$(echo -n "$listados" | $PrPWD/stdcdr " ")
    done
fi
busca=".."
posicion=0;
dondes=$( echo "$lista0" |$PrPWD/stdbuscaarg_donde "
")
encuentra="ALGO"
touch $nomprograma.memoria
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo -n "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=""
    if [ -n "$listf" ];then
	chacha=$(cat "$listf"|$PrPWD/chacha20)
    fi
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
    if [ -z "$listf" ];then
	encuentra="."
    fi
done
ps1=1
while [ -f "$nomprograma.lock-$ps1" ];do
    if [ 0$ps1 -lt 4 ];then
	echo "W W W W W W W W W W W W W   $ps1"
	ps1=$(expr 0$ps1 + 1)
    else
	ps1=1
	sleep 1
    fi
done
touch "$nomprograma.lock-$ps1"
$0 &
if [ -z "$encuentra" -a -n "$listf" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	fn2="$fn"
	while [ -n "$slash" ];do
	    fn2=$(echo -n "$fn2" | $PrPWD/stdcdr "/" )
	    slash=$(echo -n "$fn2" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
	dirfn=$(echo -n "$fn"|$PrPWD/stdcarsin "/$fn2")
	userd=$(echo -n "$fn"|$PrPWD/stdcdr "users/input/"|$PrPWD/stdcarsin "/")
	dirfn="$PrPWD/users/tooutput"
	mkdir "$dirfn"
	dirfn=$(echo -n "$dirfn/$userd/")
	mkdir "$dirfn"
 	echo "0 $busca ($fn2) $dirfn $userd"
	cat "$fn"|wc -c
	len=$(cat "$fn"|wc -c|$PrPWD/stddelcar " ")
	echo "----     $fn | $len"
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - 0$closs)
	    echo "$len $opens-$closs"
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
 		ejec="$fn.$nomprograma.bin"
		echo "E: $ejec"
		errores=$(gcc -o "$ejec" "$fn" 2>&1 )
		echo "     !!!!      $errores"   #borrar
		if [ -z "$errores" ];then
		    echo ";$listf;$chacha;" >> $nomprograma.memoria
		    variables=$(cat "$fn" |$PrPWD/stddeclaracionesdevariable|tr -d '
')
		    variables=";$variables"
		    varos="";
		    varis=$(echo -n "$variables" |$PrPWD/stdbuscaarg_count ";double")
		    varos="$varos$varis"
		    varis=$(expr $varis + $(echo -n "$variables"|$PrPWD/stdbuscaarg_count "{double") )
		    varos="$varos$varis"
		    varis=$(expr $varis + $(echo -n "$variables"|$PrPWD/stdbuscaarg_count ";char") )
		    varos="$varos$varis"
		    varis=$(expr $varis + $(echo -n "$variables"|$PrPWD/stdbuscaarg_count "{char") )
		    varos="$varos$varis"
		    price=""
		    status=""
		    times=""
		    symbol=""
		    stopprice=0
		    while [ 0$varis -ge 1 ];do
			tipo="double"
			list=$(echo -n "$variables"|$PrPWD/stdcdr ";$tipo " | $PrPWD/stdcarsin ";")
			if [ -z "$list" ];then
			    list=$(echo -n "$variables"|$PrPWD/stdcdr "{$tipo " | $PrPWD/stdcarsin ";")
			fi
			if [ -z "$list" ];then
			    tipo="char"
			    list=$(echo -n "$variables"|$PrPWD/stdcdr ";$tipo " | $PrPWD/stdcarsin ";")
			    if [ -z "$list" ];then
				list=$(echo -n "$variables"|$PrPWD/stdcdr "{$tipo " | $PrPWD/stdcarsin ";")
			    fi
			fi
			varis=$(expr 0$varis - 1)
			if [ -n "$list" ];then
			    variable2=$(echo -n "$variables"| $PrPWD/stdcarsin "$tipo $list;")
			    variable3=$(echo -n "$variables"| $PrPWD/stdcdr "$tipo $list;")
			    variables=$(echo -n $variable2$variable3);
			    reu=$(echo -n "$list" | $PrPWD/stdcdr '=')
			    rev=$(echo -n "$list" | $PrPWD/stdcarsin '=')
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "price=")
			    if [ -n "$encuentra" ];then
				price=$reu
				echo "   *   *   *   *   *   * $price"
			    fi
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "stopPrice=")
			    if [ -n "$encuentra" ];then
				stopprice=$reu
				echo "   *   *   *   *   *   * $price"
			    fi
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "time=")
			    if [ -n "$encuentra" ];then
				times=$reu
				echo "  *   *   *   *   *   * $times"
			    fi
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "status[")
			    if [ -n "$encuentra" ];then
				status=$(echo "$reu"|tr -d '"')
				echo "  *   *   *   *   *   * $status"
			    fi
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "symbol")
			    if [ -n "$encuentra" ];then
				symbol=$(echo -n "$reu"|$PrPWD/stddelcar '"')
				echo "  *   *   *   *   *   * $symbol"
			    fi
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "orderId")
			    if [ -n "$encuentra" ];then
				orderid=$(echo -n "$reu"|$PrPWD/stddelcar '"')
				echo "  *   *   *   *   *   * $orderid"
			    fi
			fi
		    done
		    if [ -n "$price" ];then
			if [ -n "$times" ];then
			    if [ -n "$symbol" ];then
				if [ "$status" = "CANCELED" ];then
				    status="CANCELADO"
				    price=$stopprice
				fi
				if [ "$status" = "EXPIRED" ];then
				    status="EXPIRADO"
				    price=$stopprice
				fi
				if [ "$status" = "FILLED" ];then
				    status="COMPLETADO"
				    price=$stopprice
				fi
				price2=$(echo "$price+($price*0.05)"|bc -l)
				price3=$(echo "$price-($price*0.05)"|bc -l)
				interval="15"
				timee=$times
				timed=$(echo "$times/1000"|bc -l|$PrPWD/stdcarsin ".")
				echo " - .- .- .- .- .- .- .- .- "
				date --date $(echo -n "@"$(echo "$times/1000"|bc -l|$PrPWD/stdcarsin "."))
				times=$(echo "0$times-($interval*250*60*1000)"|bc -l)
				date --date $(echo -n "@"$(echo "$times/1000"|bc -l|$PrPWD/stdcarsin "."))
				echo " - .- .- .- .- .- .- .- .- "
				interval=$(echo -n "$interval m"|tr -d ' ')
				echo "TTTTTT      $times"
				continua=1;
				while [ 0$continua -gt 0 ];do
				    params="symbol=$symbol&startTime=$times&interval=$interval"
				    rew=$(curl -H "X-MBX-APIKEY: $apikey" -L "https://api.binance.com/api/v3/klines?$params")
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
					opena=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcarsin "," | tr -d '"')
					rew=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcdr ",")
					high=$(echo "$rew" | $PrPWD/stdcarsin "," | tr -d '"')
					low=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcarsin ","  | tr -d '"')
					closea=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcdr "," | $PrPWD/stdcarsin ","  | tr -d '"')
					rew=$(echo -n "$rew" | $PrPWD/stdcdr "]" | $PrPWD/stdcdr "[")
					opentimes=$(echo -n "$opentimes, $opentime")
					highs=$(echo -n "$highs, $high")
					lows=$(echo -n "$lows, $low")
					opens=$(echo -n "$opens, $opena")
					closes=$(echo -n "$closes, $closea")
					continua=0;
					if [ 0$opentime -gt 0 ];then
					    continua=$(echo -n "$opentime"|wc -c|$PrPWD/stdcarsin " "|$PrPWD/stddelcar ","|$PrPWD/stddelcar "[")
					    if [ 0$continua -lt 13 ];then
						echo "OOOOO $opentime"
						continua=1;
						break;
					    fi
					    continua=0;
					fi
					l2=$(expr 0$l2 - 1)
				    done
				done
				archname=$(echo -n "$listf" | $PrPWD/stdcarsin ".")
				archname=$(echo -n "$archname-$nomprograma" | $PrPWD/stdcarsin ".")
				archname=$(echo -n "$archname-prices" | $PrPWD/stdcarsin ".")
				cat "$PrPWD/buscaprice.c" | $PrPWD/stdcar "double opentimes[" > "$archname.c"
				opentimes=$(echo -n "$l3]=$opentimes };") 
				echo -n "$opentimes" >> "$archname.c"
				cat "$PrPWD/buscaprice.c" | $PrPWD/stdcdr "double opentimes[" | $PrPWD/stdcdr ";" >> "$archname.c"
				
				cat "$archname.c" | $PrPWD/stdcar "double highs[" > "$archname-ii.c"
				highs=$(echo -n "$l3]=$highs };")
				echo -n "$highs" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "double highs[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"
				cat "$archname.c" | $PrPWD/stdcar "double lows[" > "$archname-ii.c"
				lows=$(echo -n "$l3]=$lows };")
				echo -n "$lows" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "double lows[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"

				cat "$archname.c" | $PrPWD/stdcar "double openo[" > "$archname-ii.c"
				opens=$(echo -n "$l3]=$opens };")
				echo -n "$opens" >> "$archname-ii.c"
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
				archnamprice=""
				errores=$(gcc "$archname.c" -o "$archname-bin" 2>&1)
				if [ -n "$errores" ];then
				    echo "! ! ! ! ! ! ! ! ! ! ! ! ! !"
				    echo "$errores"
				else
				    echo "#include <stdio.h>"  > "$archname-ii.c"
				    echo "#include <stdlib.h>" >> "$archname-ii.c"
				    echo "int main(int argc, char *argv[]) {" >> "$archname-ii.c"
				    echo "long orderId=$orderid;" >> "$archname-ii.c"
				    $archname-bin >> "$archname-ii.c"
				    echo "}" >> "$archname-ii.c"
				    errores=$(gcc "$archname-ii.c" -o "$archname-ii" 2>&1)
				    if [ -n "$errores" ];then
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

				archname=$(echo -n "$listf" | $PrPWD/stdcarsin ".")
				archname=$(echo -n "$archname-$nomprograma" | $PrPWD/stdcarsin ".")
				archname=$(echo -n "$archname-rsi" | $PrPWD/stdcarsin ".")
				cat "$PrPWD/fromklinestorsi.c" | $PrPWD/stdcar "double opentimes[" > "$archname.c"
				echo -n "$opentimes" >> "$archname.c"
				cat "$PrPWD/fromklinestorsi.c" | $PrPWD/stdcdr "double opentimes[" | $PrPWD/stdcdr ";" >> "$archname.c"
				
				cat "$archname.c" | $PrPWD/stdcar "double highs[" > "$archname-ii.c"
				echo -n "$highs" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "double highs[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"
				cat "$archname.c" | $PrPWD/stdcar "double lows[" >> "$archname-ii.c"
				echo -n "$lows" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "double lows[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"
				cat "$archname.c" | $PrPWD/stdcar "double price=" > "$archname-ii.c"
				echo -n "$price;" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "double price=" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"
				cat "$archname.c" | $PrPWD/stdcar "int l3=" > "$archname-ii.c"
				echo "$l3;" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "int l3=" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"
				errores=$(gcc "$archname.c" -o "$archname-bin" 2>&1)
				if [ -n "$errores" ];then
				    echo "! ! ! ! ! ! ! ! ! ! ! ! ! !"
				    echo "$errores"
				else
				    echo "#include <stdio.h>"  > "$archname-ii.c"
				    echo "#include <stdlib.h>" >> "$archname-ii.c"
				    echo "int main(int argc, char *argv[]) {" >> "$archname-ii.c"
				    echo "long orderId=$orderid;" >> "$archname-ii.c"
				    echo "long opentimes[$opentimes" >> "$archname-ii.c"
				    echo "double highs[$highs" >> "$archname-ii.c"
				    echo "double lows[$lows" >> "$archname-ii.c"
				    $archname-bin >> "$archname-ii.c"
				    echo "int l=1;while(l<$l3) {if (rsi[l]>0) printf(\"%08ld %08lf %08lf\n\", opentimes[l]/1000, rsi[l], (highs[l]+lows[l])/2);l++;};"  >> "$archname-ii.c"
				    echo "}" >> "$archname-ii.c"
				    errores=$(gcc "$archname-ii.c" -o "$archname-ii" 2>&1)
				    if [ -n "$errores" ];then
					echo "!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!"
					echo "$errores"
				    else
					"$archname-ii" > "$archname.dat"
				    fi
				fi
				echo " * f * f * f * f * f * f * f * f * f * f * "
				echo "set term postscript landscape color solid" > "$archname.gnuplot"
				echo "set terminal png size 1600,300 enhanced font 'Helvetica,10'" >> "$archname.gnuplot"
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
				echo "set style line 1 lw 1 lc rgb '#990042' ps 2 pt 1 pi 1" >> "$archname.gnuplot"
				echo "set style line 2 lw 1 lc rgb '#420082' ps 3 pt 1 pi 1" >> "$archname.gnuplot"
				echo "set style line 3 lw 1 lc rgb '#623092' ps 6 pt 2 pi 2" >> "$archname.gnuplot"
				echo "set multiplot layout 2,1 columnsfirst" >> "$archname.gnuplot"
				times=$(echo "$times/1000"|bc -l|$PrPWD/stdcarsin ".")
				echo "$timed $price" > "$archnamprice-price0.dat"
				echo -n "plot \"$archname.dat\" using 1:3 ls 2 w lines title \"PRECIO\", \"$archnamprice-price0.dat\" using 1:2:(sprintf(\"$status (%s, %f)\", system (sprintf(\"date -d @%d +'%F %T'\", \$1)), \$2)) with labels point ps 2 pt 4 offset char 1,1 notitle"  >> "$archname.gnuplot"
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
				echo "plot \"$archname.dat\" using 1:2 ls 1 w lines title \"RSI\""  >> "$archname.gnuplot"  >> "$archname.gnuplot"
				gnuplot "$archname.gnuplot"
				size=$(echo -n "$archname-gnuplot.png"|wc -c)
				echo "#include <stdio.h>"  > "$archname-imagen.c"
				echo "#include <stdlib.h>" >> "$archname-imagen.c"
				echo "int main(int argc, char *argv[]) {" >> "$archname-imagen.c"
				echo "long orderId=$orderid;" >> "$archname-imagen.c"
				echo "char imagen[$size]=\"$archname-gnuplot.png\";" >> "$archname-imagen.c"
				echo "}" >> "$archname-imagen.c"
				echo " * f * f * f * f * f * f * f * f * f * f * "
			    fi
			fi
		    fi
		fi
	    fi
	fi		    
    fi
fi
rm "$nomprograma.lock-$ps1"

