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
    echo "$listf"
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    if [ -n "$listf" ];then
	chacha20=$(cat "$listf"|sha512sum|$PrPWD/stdcarsin " ")
	encuentra=$(cat "$nomprograma.memoria"|$PrPWD/stdbuscaarg ";$chacha20;")
	if [ -z "$encuentra" ];then
	    fn=$listf
	    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
	    if [ -n "$ttest" ];then
		slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
		fn2="$fn"
		while [ -n "$slash" ];do
		    fn2=$(echo -n "$fn2" | $PrPWD/stdcdr "/" )
		    slash=$(echo -n "$fn2" | $PrPWD/stdbuscaarg_donde_hasta "/" )
		done
		dirfn=$(echo -n "$fn"|$PrPWD/stdcarsin "/$fn2")
		touch "$dirfn/$nomprograma.js"
		nomprogvars=$(echo -n "$nomprograma"|$PrPWD/stdcarsin ".")
		nomprogvars=$(echo -n "$nomprogvars vars.js"|tr -d ' ')
		nomprogvars=$(echo -n "$dirfn/$nomprogvars"|tr -d ' ')
		touch "$nomprogvars"
		nomprogcods=$(echo -n "$nomprograma"|$PrPWD/stdcarsin ".")
		nomprogcods=$(echo -n "$nomprogcods cods.js"|tr -d ' ')
		nomprogcods=$(echo -n "$dirfn/$nomprogcods"|tr -d ' ')
		touch "$nomprogcods"
		cat "$fn"|wc -c
		len=$(cat "$fn"|wc -c|$PrPWD/stddelcar " ")
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
			    if [ -n "$orderId" ];then
				echo " . . . . . .       $listf       $orderId"
				encuentra=$(cat "$nomprogvars"|$PrPWD/stdbuscaarg "var orderId=new Array();")
				if [ -z "$encuentra" ];then
				    echo "var orderId=new Array();" >> "$nomprogvars"
				fi
				codigo="orderId[orderId.length]=$orderId;"
				encuentra=$(cat "$nomprogvars"|$PrPWD/stdbuscaarg "$codigo")
				if [ -z "$encuentra" ];then
				    echo "$codigo" >> "$nomprogvars"
				fi
				variables=$(cat "$fn" |$PrPWD/stddeclaracionesdevariable_tojs|tr -d '
')
				encuentra="ALGO"
				while [ -n "$encuentra" ];do
				    list=$(echo -n "$variables;"|$PrPWD/stdcar ";")
				    variables2=$(echo -n "$variables"|$PrPWD/stdcarsin "$list")
				    variables3=$(echo -n "$variables"|$PrPWD/stdcdr "$list")
				    variables=$(echo -n "$variables2$variables3")
				    encuentra=$(echo -n ";$list"|$PrPWD/stdbuscaarg ";var ")
				    echo " - . - . - . - . - . - . - . - . $listf [ $(echo  \"$list\"|$PrPWD/stdcarn 40) ]"
				    if [ -n "$encuentra" ];then
					encuentra=$(cat "$nomprogvars"|$PrPWD/stdbuscaarg 'var variables=new Array();')
					if [ -z "$encuentra" ];then
					    echo 'var variables=new Array();' >> "$nomprogvars"
					fi
					encuentra=$(cat "$nomprogcods"|$PrPWD/stdbuscaarg "$list")
					if [ -z "$encuentra" ];then
					    encuentra=$(echo -n "$list"|$PrPWD/stdbuscaarg "=")
					    if [ -n "$encuentra" ];then
						encuentra=$(echo -n "$list"|$PrPWD/stdcarsin "="|$PrPWD/stdbuscaarg '"')
						if [ -z "$encuentra" ];then
						    rev=$(echo -n ";$list"|$PrPWD/stdcdr ";var "|$PrPWD/stdcarsin "=")
						    reu=$(echo -n ";$list"|$PrPWD/stdcdr ";var "|$PrPWD/stdcdr "=")
						    largo=$(echo -n "$reu"|wc -c | $PrPWD/stdcarsin " ")
						    echo "< $largo >"
						    if [ 0$largo -lt 120 ];then
							echo " #>#>#>#># var $rev=new Array(); "
							echo " #<#<#<#<#  $nomprogvars"
							cat "$nomprogvars"|$PrPWD/stdbuscaarg "var $rev=new Array"
							echo "-.-.-.-.-.-..-.-.-.-.-.-.-.-.-..-"
							encuentra=$(cat "$nomprogvars"|$PrPWD/stdbuscaarg "var $rev=new Array")
							if [ -z "$encuentra" ];then
							    echo -n "var $rev=new "  >> "$nomprogvars"
							    echo 'Array();' >> "$nomprogvars"
							    echo "variables[variables.length]=\"$rev\";" >> "$nomprogvars"
							fi
							encuentra=$(echo -n "$list"|$PrPWD/stdbuscaarg "$dirfn")
							if [ -n "$encuentra" ];then
							    variables2=$(echo -n "$reu"|$PrPWD/stdcarsin "$dirfn")
							    variables3=$(echo -n "$reu"|$PrPWD/stdcdr "$dirfn")
							    reu=$(echo -n "$variables2.$variables3")
							fi
							encuentra=$(echo -n "$list"|$PrPWD/stdcdr "="|$PrPWD/stdbuscaarg '*')
							if [ -n "$encuentra" ];then
							    encuentra=$(echo -n "$list"|$PrPWD/stdcdr "="|$PrPWD/stdbuscaarg '"')
							    if [ -z "$encuentra" ];then
								reu=0
							    fi
							fi
							codigo="var contador=0;while(orderId[contador]!=$orderId && contador<orderId.length){contador++;};if(contador<orderId.length) $rev[contador]=$reu;"
							encuentra=$(cat "$nomprogcods"|$PrPWD/stdbuscaarg "$codigo")
							if [ -z "$encuentra" ];then
							    codigo2="var contador=0;while(orderId[contador]!=$orderId && contador<orderId.length){contador++;};if(contador<orderId.length) $rev[contador]="
							    if [ -n "$encuentra" ];then
								cat "$nomprogcods"|$PrPWD/stdcar "$codigo2" > "$dirfn/$nomprograma.js.ii"
								echo "$reu;" >> "$dirfn/$nomprograma.js.ii"
								cat "$nomprogcods"|$PrPWD/stdcdr "$codigo2"|$PrPWD/stdcdr ";" >> "$dirfn/$nomprograma.js.ii"
								mv "$dirfn/$nomprograma.js.ii" "$nomprogcods"
							    else 
								echo "$codigo" >> "$nomprogcods"
							    fi
							fi
						    fi
						fi
					    fi
					fi
				    fi
				    encuentra=$(echo -n ";$variables"|$PrPWD/stdbuscaarg ";var ")
				    echo "$nomprogvars -.- $dirfn/$nomprogcods"
				    cat "$nomprogvars" "$nomprogcods" > "$dirfn/$nomprograma-ii.js"
				    mv -v "$dirfn/$nomprograma-ii.js" "$dirfn/$nomprograma.js"
				done
				echo ";$chacha20;" >> "$nomprograma.memoria"
			    fi
			fi
		    fi
		fi
	    fi
	fi
	nomproghtml=$(echo -n "$nomprograma"|$PrPWD/stdcarsin ".")
	nomproghtml=$(echo -n "$nomproghtml .html"|tr -d ' ')
	cp -v "$PrPWD/$nomproghtml" "$dirfn/"
    fi
done
$0
