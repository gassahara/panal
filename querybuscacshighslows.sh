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
		    varis=$(expr $varis + $(echo -n "$variables"|$PrPWD/stdbuscaarg_count ";long") )
		    varos="$varos$varis"
		    varis=$(expr $varis + $(echo -n "$variables"|$PrPWD/stdbuscaarg_count "{long") )
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
			if [ -z "$list" ];then
			    tipo="long"
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
			    rev=$(echo -n "$list" | $PrPWD/stdcarsin '=')
			    #			    echo " - - - - - - - - - - - - - - - -  - - -    $listf            $tipo |$varis| ($rev $reu))"
			    enes=0
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "_highs[")
			    if [ -n "$encuentra" ];then
				highs=$(echo -n "$list" | $PrPWD/stdcdr ']=')
				enes=$(echo -n "$list" | $PrPWD/stdcarsin ']='|$PrPWD/stdcdr "highs[")
				echo "   *   *   *   *   *   * $highs"
			    fi
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "_opentimes[")
			    if [ -n "$encuentra" ];then
				opentimes=$(echo -n "$list" | $PrPWD/stdcdr ']=')
				echo "   *   *   *   *   *   * $opentimes"
			    fi
			    
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "_lows[")
			    if [ -n "$encuentra" ];then
				lows=$(echo -n "$list" | $PrPWD/stdcdr ']=')
				echo "  *   *   *   *   *   * $lows"
			    fi
			    encuentra=$(echo -n "$list" | $PrPWD/stdbuscaarg "_orderId")
			    if [ -n "$encuentra" ];then
				orderid=$(echo -n "$list" | $PrPWD/stdcdr '=')
				echo "  *   *   *   *   *   * $orderid"
			    fi
			fi
		    done
		    if [ -n "$highs" ];then
			if [ -n "$lows" ];then
			    if [ -n "$opentimes" ];then
				if [ -n "$orderid" ];then
				    archname=$(echo -n "$listf" | $PrPWD/stdcarsin ".")
				    archname=$(echo -n "$archname-gnuplot")
				    echo "#include <stdio.h>"  > "$archname.c"
				    echo "#include <stdlib.h>" >> "$archname.c"
				    echo "int main(int argc, char *argv[]) {" >> "$archname.c"
				    echo "double altos[$enes]=$highs;"  >> "$archname.c"
				    echo "double bajos[$enes]=$lows;"  >> "$archname.c"
				    echo "double tiempos[$enes]=$opentimes;"  >> "$archname.c"
				    echo "i=1;while(i<$enes){printf(\"%08ld %08lf %08lf\", tiempos[i], altos[i], bajos[i]);i++;};}"  >> "$archname.c"
				    errores=$(gcc "$archname.c" -o "$archname" 2>&1)
				    if [ -n "$errores" ];then
					echo "!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!*-!"
					echo "$errores"
				    else
					archnameo=$(echo -n "$dirfn/$orderid-$omprograma-time-highs-lows.dat" | $PrPWD/stddelcar ".sh")
					$archname > "$archnameo"
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
fi
rm "$nomprograma.lock-$ps1"

