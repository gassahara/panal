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
sleep 0.1
listados="";
listado="";
if [ -d "$PrPWD/orders/" ];then
    listados=$(echo $PrPWD/orders|$PrPWD/listadodirectorio_dirs_from_std|$PrPWD/stdbuscaarg_donde '
')
    listado=$(echo $PrPWD/orders|$PrPWD/listadodirectorio_dirs_from_std)
    salta=0;
#    echo ".. $listados .."
#    echo "**** $listado _ _ _ "
    while [ -n "$listados" ];do
	presalta=$(echo -n "$listados" | $PrPWD/stdcar " ")
	salta=$(expr 0$presalta + 1)
#	echo " ))>    $salta     <(("
	dirn=$(echo -n "$listado"|$PrPWD/stdcdrn 0$salta | $PrPWD/stdcarn $presalta)
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std_extension_c )
	lista2=$(echo -n "$lista1
$lista0" )
	lista0=$lista2
	listados=$(echo -n "$listados" | $PrPWD/stdcdr " ")
	#	echo ">>> $lista0 _ _ _ "
    done
fi
busca=".."
posicion=0;
dondes=$( echo "$lista0" |$PrPWD/stdbuscaarg_donde "
")
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=""
    if [ -n "$listf" ];then
	chacha=$(cat "$listf"|$PrPWD/chacha20)
    fi
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -z "$encuentra" ];then
    echo ";$listf;$chacha;" >> $nomprograma.memoria
fi
ps1=1
while [ -f "$nomprograma.lock-$ps1" ];do
    if [ 0$ps1 -lt 3 ];then
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
		    times=""
		    symbol=""
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
			#			echo " - - - - - - - - - - - - - - - -  - - -    $listf            doubles |$varis| $variables"
			if [ -n "$list" ];then
			    variable2=$(echo -n "$variables"| $PrPWD/stdcarsin "$tipo $list;")
			    variable3=$(echo -n "$variables"| $PrPWD/stdcdr "$tipo $list;")
			    variables=$(echo -n $variable2$variable3);
			    reu=$(echo -n "$list" | $PrPWD/stdcdr '=')
			    rev=$(echo -n "$list" | $PrPWD/stdcarsin '=')
#			    echo " - - - - - - - - - - - - - - - -  - - -    $listf            $tipo |$varis| ($rev $reu))"
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "_price=")
			    if [ -n "$encuentra" ];then
				price=$reu
				echo "   *   *   *   *   *   * $price"
			    fi
			    
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "_time=")
			    if [ -n "$encuentra" ];then
				times=$reu
				echo "  *   *   *   *   *   * $times"
			    fi
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "_symbol")
			    if [ -n "$encuentra" ];then
				symbol=$(echo -n "$reu"|$PrPWD/stddelcar '"')
				echo "  *   *   *   *   *   * $symbol"
			    fi
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "_orderId")
			    if [ -n "$encuentra" ];then
				orderid=$(echo -n "$reu"|$PrPWD/stddelcar '"')
				echo "  *   *   *   *   *   * $orderid"
			    fi
			fi
		    done
		    if [ -n "$price" ];then
			if [ -n "$times" ];then
			    if [ -n "$symbol" ];then
				price2=$(echo "$price+($price*0.05)"|bc -l)
				price3=$(echo "$price-($price*0.05)"|bc -l)
				echo "TTTTTT      $times"
				continua=1;
				while [ 0$continua -gt 0 ];do
				    params="symbol=$symbol&startTime=$times&interval=15m"
				    rew=$(curl -H "X-MBX-APIKEY: $apikey" -L "https://api.binance.com/api/v3/klines?$params")
				    echo "$rew"|$PrPWD/stdcarn 20
				    continua=0
				    if [ -z "$rew" ];then
					continua=1
					continue;
				    fi
				    rew=$(echo -n "$rew"|$PrPWD/stdcdr "[")
				    l2=$(echo "$rew" | $PrPWD/stdbuscaarg_count ",[")
				    l2=$(expr 0$l2 + 1)
				    l3=$(expr 0$l2 + 1)
				    echo " * s * s * s * s * s * s * s * s * s * s * >>>>>    $l2"
				    opentimes="{0"
				    highs="{0"
				    lows="{0"
				    while [ 0$l2 -gt 0 ];do
					opentime=$(echo "$rew" | $PrPWD/stdcarsin ","|$PrPWD/stddelcar ","|$PrPWD/stddelcar "[")
					rew=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcdr ",")
					high=$(echo "$rew" | $PrPWD/stdcarsin "," | tr -d '"')
					low=$(echo "$rew" | $PrPWD/stdcdr "," | $PrPWD/stdcarsin ","  | tr -d '"')
					rew=$(echo -n "$rew" | $PrPWD/stdcdr "]" | $PrPWD/stdcdr "[")
					opentimes=$(echo -n "$opentimes, $opentime")
					highs=$(echo -n "$highs, $high")
					lows=$(echo -n "$lows, $low")
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
				archname=$(echo -n "$archname-$nomprograma")
				cat "$PrPWD/fromklinestorsi.c" | $PrPWD/stdcar "double opentimes[" > "$archname.c"
				opentimes=$(echo -n "$l3]=$opentimes };") 
				echo -n "$opentimes" >> "$archname.c"
				cat "$PrPWD/fromklinestorsi.c" | $PrPWD/stdcdr "double opentimes[" | $PrPWD/stdcdr ";" >> "$archname.c"
				cat "$archname.c" | $PrPWD/stdcar "int l3=" >> "$archname-ii.c"
				echo -n "$l3;" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "int l3=" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"

				cat "$archname.c" | $PrPWD/stdcar "double highs[" >> "$archname-ii.c"
				highs=$(echo -n "$l3]=$highs };")
				echo -n "$highs" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "double highs[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"
				cat "$archname.c" | $PrPWD/stdcar "double lows[" >> "$archname-ii.c"
				lows=$(echo -n "$l3]=$lows };")
				echo -n "$lows" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "double lows[" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"
				cat "$archname.c" | $PrPWD/stdcar "double price=" >> "$archname-ii.c"
				echo -n "$price;" >> "$archname-ii.c"
				cat "$archname.c" | $PrPWD/stdcdr "double price=" | $PrPWD/stdcdr ";" >> "$archname-ii.c"
				mv "$archname-ii.c" "$archname.c"
				errores=$(gcc "$archname.c" -o "$archname-bin" 2>&1)
				if [ -n "$errores" ];then
				    echo "! ! ! ! ! ! ! ! ! ! ! ! ! !"
				    echo "$errores"
				else
				    $archname-bin
				fi
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

