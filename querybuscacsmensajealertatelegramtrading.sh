#!/bin/bash
fn=""
PaPWD="$PWD"
PrPWD="/root/nube/"
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
listados="";
listado="";
dirdetelegram="/root/td/example/cpp/build/"
nompra=$(echo "$nomprograma" | $PrPWD/stdcarsin ".sh")
nomlis=$(echo "$nompra lista0"|tr -d ' ')
if [ ! -f "$nomlis" ];then
    if [ -d "$dirdetelegram" ];then
	echo "$dirdetelegram" | $PrPWD/listadodirectorio_files_from_std_extension_c > $nomlis
	cat $PrPWD/dataC1cdrn.c | $PrPWD/stdcar ' *filo="' > $nomlis.c
	echo "$PaPWD/$nomlis" | tr -d '
' >> $nomlis.c
	echo '";' >> $nomlis.c
	cat $PrPWD/dataC1cdrn.c | $PrPWD/stdcdr ' *filo="' | $PrPWD/stdcdr '
' >> $nomlis.c
	gcc -o $nomlis.bin $nomlis.c -lm -Wall 
    fi
fi
busca=".."
posicion="0";
dondes=$( cat $nomlis |$PrPWD/stdbuscaarg_donde "
")
encuentra="ALGO"
touch $nomprograma.memoria
echo "P:: $posicion"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$($PaPWD/$nomlis.bin "$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;")
    if [ -z "$listf" ];then
	encuentra="."
    fi
done

ps1=1
while [ -f "$nomprograma.lock-$ps1" ];do
    if [ 0$ps1 -lt 12 ];then
#	echo "W W W W W W W W W W W W W   $ps1"
	ps1=$(expr $ps1 + 1)
    else
	ps1=1
	sleep 1
    fi
done
touch "$nomprograma.lock-$ps1"
sh $0 &


if [ -z "$encuentra" -a -n "$listf" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	fn2="$fn"
	while [ -n "$slash" ];do
	    fn2=$(echo "$fn2" | $PrPWD/stdcdr "/" )
	    slash=$(echo "$fn2" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
	dirfn=$(echo "$fn"|$PrPWD/stdcarsin "/$fn2")
	len=$(cat "$fn" | $PrPWD/stdcarn 1)
	if [ -n "$len" ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - 0$closs)
	    echo "$len $opens-$closs"
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
		echo ";$listf;$chacha;" >> $nomprograma.memoria
 		ejec="$fn.$nomprograma.bin"
		errores=$(gcc -o "$ejec" "$fn" 2>&1 )
		if [ -z "$errores" ];then
		    nompra=$(echo "$nomprograma" | $PrPWD/stdcarsin ".sh")
		    fan=$(echo "$fn2" | $PrPWD/stdcarsin ".c")
		    nomin=$(echo "$fan $nompra.c"|tr -d ' '|$PrPWD/stdcarsin ".")
		    nomvar=$(echo "$PaPWD/$nomin variables"|tr -d ' ')
		    echo ";" | cat - "$fn" |$PrPWD/stddeclaracionesdevariable|tr -d '
'> "$nomvar"
		    echo " " >> "$nomvar"
		    varis="ALGO";
		    donde=$(cat "$nomvar" | $PrPWD/stdbuscaarg_donde ";char ")
		    while [ -n "$donde" ];do
			donden=$(echo "$donde" | $PrPWD/stdcar " ")
			donden=$(expr $donden + 6)
			donde=$(echo "$donde" |  $PrPWD/stdcdr " ")
			varis=$(cat "$nomvar" |$PrPWD/stdcdrn "$donden"  2>/dev/null|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "["|$PrPWD/stdcarsin "=")
			varos=$(cat "$nomvar" |$PrPWD/stdcdrn "$donden"  2>/dev/null|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "["|$PrPWD/stdcdr "="|$PrPWD/stdletras_muestra_y_signos_y_numeros_ascii_convierte|$PrPWD/stdbuscaarg "BUY" )
			if [ -n "$varos" ];then
			    echo " FOUND IN: $fn"
			    varos=$(cat "$nomvar" |$PrPWD/stdcdrn "$donden"  2>/dev/null|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "["|$PrPWD/stdcdr "="|$PrPWD/stdletras_muestra_y_signos_y_numeros_ascii_convierte)
 			    dondep=$(cat "$nomvar" |$PrPWD/stdcdrn "$donden"  2>/dev/null|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "["|$PrPWD/stdcdr "="|$PrPWD/stdletras_muestra_y_signos_y_numeros_ascii_convierte|$PrPWD/stdbuscaarg_binance)
			    dondeq=$dondep
			    dondep=0
			    while [ -n "$dondep" ];do
				symbol=$(cat "$nomvar" |$PrPWD/stdcdrn "$donden"  2>/dev/null|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "["|$PrPWD/stdcdr "="|$PrPWD/stdletras_muestra_y_signos_y_numeros_ascii_convierte|$PrPWD/stdcdrn "$dondeq"|$PrPWD/stdcdrn "$dondep"|$PrPWD/stdcarsin " "|tr -d ';')
				varnom=$(echo "$PaPWD/$nomin resul $symbol.c"|tr -d ' ')
				salta=$(echo "$symbol"|wc -c|$PrPWD/stdcarsin " ")
				if [ "0$salta" -lt 2 ];then
				    break
				fi
				fecha=$(cat "$fn" | $PrPWD/stdcdr 'time_t '| $PrPWD/stdcar ';')
				cenel=$(cat "$fn" | $PrPWD/stdcdr 'char canal['| $PrPWD/stdcar ';')
				echo "#include <time.h>" > "$varnom.c"
				echo "int main(int argc, char *argv[]) {"  >> "$varnom.c"
				echo "char canal[$cenel"   >> "$varnom.c"
				echo "time_t $fecha"   >> "$varnom.c"
				ns=$(echo "$varos"|wc -c | $PrPWD/stdcarsin " ")
				ns=$(expr $ns - 1)
				echo "char mensaje[$ns]=\"$varos\";"  >> "$varnom.c"
				ns=$(echo "$symbol"|wc -c | $PrPWD/stdcarsin " ")
				ns=$(expr $ns - 1)
				echo "char symbol[$ns]=\"$symbol\";"  >> "$varnom.c"
				echo "}"   >> "$varnom.c"
				echo "   >    >     >     >      $varnom.c"
				cat "$varnom.c"
				dondeq=$(expr $dondeq + $salta + $dondep)
 				dondep=$(cat "$nomvar" |$PrPWD/stdcdrn "$donden"  2>/dev/null|$PrPWD/stdcarsin ";"|$PrPWD/stdcdr "["|$PrPWD/stdcdr "="|$PrPWD/stdletras_muestra_y_signos_y_numeros_ascii_convierte|$PrPWD/stdcdrn "$dondeq"|$PrPWD/stdbuscaarg_binance)
				echo " . . . . . "
			    done
			    echo " - - - "
			fi
		    done
		else
		    echo "     !!!!      $errores"
		fi
	    fi
	fi
    fi
fi
rm -v "$nomprograma.lock-$ps1"

