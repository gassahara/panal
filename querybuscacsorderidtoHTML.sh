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
    #echo ".. $listados .."
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
while [ -n "$dondes" ];do
    listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    echo "$lista0"
    echo "$listf"
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    if [ -n "$listf" ];then
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
			encuentra=$(cat "$listf"|$PrPWD/stdbuscaarg "orderId")
			if [ -n "$encuentra" ];then
			    orderId=$(cat "$listf"|$PrPWD/stdcdr "orderId=" | $PrPWD/stdcarsin ";")
			fi
			echo "$orderId"
			encuentra=$(cat "$dirfn/$nomprograma.js"|$PrPWD/stdbuscaarg "var orderId[];")
			if [ -z "$encuentra" ];then
			    echo "var orderId[];" >> "$dirfn/$nomprograma.js"
			fi
			encuentra=$(cat "$dirfn/$nomprograma.js"|$PrPWD/stdbuscaarg "orderId[]=$orderId;")
			if [ -z "$encuentra" ];then
			    echo "orderId[]=$orderId;" >> "$dirfn/$nomprograma.js"
			fi
			variables=$(cat "$fn" |$PrPWD/stddeclaracionesdevariable_tojs|tr -d '
')
			encuentra="ALGO"
			while [ -n "$encuentra" ];do
			    list=$(echo -n "$variables"|$PrPWD/stdcar ";")
			    variables2=$(echo -n "$variables"|$PrPWD/stdcarsin "$list")
			    variables3=$(echo -n "$variables"|$PrPWD/stdcdr "$list")
			    variables=$(echo -n "$variables2$variables3")
			    encuentra=$(echo -n ";$variables"|$PrPWD/stdbuscaarg ";var ")
			    echo "$variables"
			    if [ -n "$encuentra" ];then
				echo " -. -. -. -. -. -. -. -. $dirfn/$nomprograma.js"
				touch "$dirfn/$nomprograma.js"
				encuentra=$(cat "$dirfn/$nomprograma.js"|$PrPWD/stdbuscaarg "$list")
				if [ -z "$encuentra" ];then
				    encuentra=$(echo -n "$list"|$PrPWD/stdbuscaarg "=")
				    if [ -n "$encuentra" ];then
					encuentra=$(echo -n "$list"|$PrPWD/stdcarsin "="|$PrPWD/stdbuscaarg '"')
					if [ -z "$encuentra" ];then
					    rev=$(echo -n ";$list"|$PrPWD/stdcdr ";var "|$PrPWD/stdcarsin "=")
					    reu=$(echo -n ";$list"|$PrPWD/stdcdr ";var "|$PrPWD/stdcdr "=")
					    encuentra=$(cat "$dirfn/$nomprograma.js"|$PrPWD/stdbuscaarg "var $rev[];")
					    if [ -z "$encuentra" ];then
						echo "var $rev[];" >> "$dirfn/$nomprograma.js"
					    fi
					    codigo="var contador=0;while(orderId[contador]!=\"$orderId\" && contador<orderId.length){contador++;};if(contador<orderId.length) $rev[contador]=$reu;"
					    encuentra=$(cat "$dirfn/$nomprograma.js"|$PrPWD/stdbuscaarg "$codigo")
					    if [ -z "$encuentra" ];then
						codigo2="var contador=0;while(orderId[contador]!=\"$orderId\" && contador<orderId.length){contador++;};if(contador<orderId.length) $rev[contador]="
						if [ -n "$encuentra" ];then
						    cat "$dirfn/$nomprograma.js"|$PrPWD/stdcar "$codigo2" > "$dirfn/$nomprograma.js.ii"
						    echo "$reu;" >> "$dirfn/$nomprograma.js.ii"
						    cat "$dirfn/$nomprograma.js"|$PrPWD/stdcdr "$codigo2"|$PrPWD/stdcdr ";" >> "$dirfn/$nomprograma.js.ii"
						    mv "$dirfn/$nomprograma.js.ii" "$dirfn/$nomprograma.js"
						else
						    echo "$codigo" >> "$dirfn/$nomprograma.js"
						fi
					    fi
					fi
				    fi
				fi
			    fi
			    encuentra=$(echo -n ";$variables"|$PrPWD/stdbuscaarg ";var ")
			done
		    fi
		fi		    
	    fi
	fi
    fi
done
#$0
