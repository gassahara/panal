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
SWESRC="/run/media/user/4T/nube/swe/src"
cspiceloc="/run/media/user/4T/nube/comp/cspice" #linux
cd $PaPWD
#echo "$nomprograma.."
sleep 0.1
listados="";
listado="";
if [ -d "$PrPWD/users/input" ];then
    listados=$(echo $PrPWD/users/input|$PrPWD/listadodirectorio_dirs_from_std|$PrPWD/stdbuscaarg_donde '
')
    listado=$(echo $PrPWD/users/input|$PrPWD/listadodirectorio_dirs_from_std)
    salta=0;
    while [ -n "$listados" ];do
	presalta=$(echo -n "$listados" | $PrPWD/stdcar " ")
	dirn=$(echo -n "$listado"|$PrPWD/stdcdrn 0$salta | $PrPWD/stdcarn $presalta)
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std_extension_c )
	lista2=$(echo -n "$lista1
$lista0" )
	lista0=$lista2
	salta=$(expr $presalta + 1)
	listados=$(echo -n "$listados" | $PrPWD/stdcdr " ")
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
    if [ -f "$list.lock" ];then
	encuentra="ALGO"
    fi
done
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
touch "$fn.lock"
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
	mkdir "$dirfn/data"
	dirfn=$(echo -n "$dirfn/data" )
	len=$(cat "$fn"|wc -c|tr -d ' '|tr -d '
')
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - $closs)
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		ejec="$fn.$nomprograma.bin"
		echo "E: $ejec"
		errores=$(gcc -o "$ejec" "$fn" 2>&1 )
		if [ -z "$errores" ];then
		    echo ";$listf;$chacha;" >> $nomprograma.memoria
		    utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
		    while [ -f "$dirfn/$utcc.c" ];do
			utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
		    done
		    variables=$(cat "$fn" |$PrPWD/stddeclaracionesdevariable|tr '
' ';')
		    varos="";
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "long prefix_")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "long $varos"
		    else
			exit 0
		    fi		    
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "double prefix_latituddatos=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "lat $varos"
		    else
			exit 0
		    fi		    
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "double prefix_ascendente=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "lat $varos"
		    else
			exit 0
		    fi		    
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "double prefix_longituddatos=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "long $varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "double prefix_positions[")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "pos $varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "char prefix_planets[")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "pla $varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "char prefix_descripcion[")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "des $varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables"|$PrPWD/stdbuscaarg "int prefix_dias=")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "dia $varos"
		    else
			exit 0
		    fi
		    if [ "$varos" = "********" ];then
			fechan=$(echo  ";$variables" |$PrPWD/stdcdr ";long "|$PrPWD/stdcarsin ";"|$PrPWD/stdcarsin "=")
			fecha=$(echo  ";$variables" |$PrPWD/stdcdr "$fechan="|$PrPWD/stdcarsin ";")
			latitud=$(echo  ";$variables"|$PrPWD/stdcdr "double prefix_latituddatos="|$PrPWD/stdcarsin ";")
			longitud=$(echo  ";$variables"|$PrPWD/stdcdr "double prefix_longituddatos="|$PrPWD/stdcarsin ";")
		        ascendente=$(echo  ";$variables"|$PrPWD/stdcdr "double prefix_ascendente="|$PrPWD/stdcarsin ";")
			timezone=$(echo  ";$variables"|$PrPWD/stdcdr "float prefix_timezone="|$PrPWD/stdcarsin ";")
			positions=$(echo  ";$variables"|$PrPWD/stdcdr "double prefix_positions["|$PrPWD/stdcarsin ";")
			planets=$(echo  ";$variables"|$PrPWD/stdcdr "char prefix_planets["|$PrPWD/stdcarsin ";")
		        descripcion=$(echo  ";$variables"|$PrPWD/stdcdr "char prefix_descripcion["|$PrPWD/stdcarsin ";")
			dias=$(echo  ";$variables"|$PrPWD/stdcdr "int prefix_dias="|$PrPWD/stdcarsin ";")
			echo "fechanon: $fechan fechav: $fecha $latitud $longitud .............."
			utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			while [ -f "$dirfn/$utcc.c" ];do
			    utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			done
			cat $PrPWD/tmtoutcdate.c | $PrPWD/stdcar "time_t t=" > "$dirfn/$utcc.c"
			echo -n "$fecha;" >> "$dirfn/$utcc.c"
			cat $PrPWD/tmtoutcdate.c |  $PrPWD/stdcdr "time_t t=" | $PrPWD/stdcdr ";" >> "$dirfn/$utcc.c"
			timeerrores=$(gcc -o "$dirfn/$utcc" "$dirfn/$utcc.c" -lm 2>&1 )
			if [ -z "$timeerrores" ];then
			    timed=$("$dirfn/$utcc")
			    yeard=$(echo "$timed"|$PrPWD/stdcarsin "/"|$PrPWD/stddelcar " ")
			    mond=$(echo "$timed"|$PrPWD/stdcdr "/"|$PrPWD/stdcarsin "/"|$PrPWD/stddelcar " ")
			    dayd=$(echo "$timed"|$PrPWD/stdcdr "/"|$PrPWD/stdcdr "/"|$PrPWD/stdcarsin " "|$PrPWD/stddelcar " ")
			    horad=$(echo "$timed"|$PrPWD/stdcdr "/"|$PrPWD/stdcdr " "|$PrPWD/stdcarsin ":"|$PrPWD/stddelcar " ")
			    mind=$(echo "$timed"|$PrPWD/stdcdr "/"|$PrPWD/stdcdr ":"|$PrPWD/stdcarsin " "|$PrPWD/stddelcar " ")
			    tjdf=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$dirfn/$tjdf.c" ];do
				tjdf=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done
			    cat $PrPWD/utctojd.c | $PrPWD/stdcar "int Y=" > "$dirfn/$tjdf.c"
			    echo "$yeard ;" >> "$dirfn/$tjdf.c"
			    cat $PrPWD/utctojd.c | $PrPWD/stdcdr "int Y=" | $PrPWD/stdcdr ";" >> "$dirfn/$tjdf.c"
			    cat "$dirfn/$tjdf.c" | $PrPWD/stdcar "int M=" > "$dirfn/$tjdf-1.c"
			    echo "$mond ;" >> "$dirfn/$tjdf-1.c"
			    cat "$dirfn/$tjdf.c" | $PrPWD/stdcdr "int M=" | $PrPWD/stdcdr ";"  >> "$dirfn/$tjdf-1.c"
			    cat "$dirfn/$tjdf-1.c" | $PrPWD/stdcar "int D=" > "$dirfn/$tjdf.c"
			    echo "$dayd ; // <-- A " >> "$dirfn/$tjdf.c"
			    cat "$dirfn/$tjdf-1.c" | $PrPWD/stdcdr "int D=" | $PrPWD/stdcdr ";"  >> "$dirfn/$tjdf.c"
			    cat "$dirfn/$tjdf.c" | $PrPWD/stdcar "double H=" > "$dirfn/$tjdf-1.c"
			    echo "$horad ;" >> "$dirfn/$tjdf-1.c"
			    cat "$dirfn/$tjdf.c" | $PrPWD/stdcdr "double H=" | $PrPWD/stdcdr ";"  >> "$dirfn/$tjdf-1.c"
			    cat "$dirfn/$tjdf-1.c" | $PrPWD/stdcar "double N=" > "$dirfn/$tjdf.c"
			    echo "$mind ; //<-" >> "$dirfn/$tjdf.c"
			    cat "$dirfn/$tjdf-1.c" | $PrPWD/stdcdr "double N=" | $PrPWD/stdcdr ";"  >> "$dirfn/$tjdf.c"			    
			    utctojulianerror=$(gcc -o "$dirfn/$tjdf" "$dirfn/$tjdf.c" -lm 2>&1 )
			    echo "E:::: < { $utctojulianerror } >:>:>:>:>      $tjdf "
			    tjd=$("$dirfn/$tjdf")			    

			    echo "..:: $timed ::.."
			    echo "CAD"
			    echo "$cad"
			    echo "PLA $planets"
			    echo "POS $positions"
			    
			    aspececl=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$dirfn/$aspececl.c" ];do
				aspececl=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done
			    cat $SWESRC/swe_ecl_v.c | $PrPWD/stdcar "double positions[" > "$dirfn/$aspececl.c"
			    echo "$positions;" >> "$dirfn/$aspececl.c"
			    cat $SWESRC/swe_ecl_v.c | $PrPWD/stdcdr "double positions[" | $PrPWD/stdcdr ";" >> "$dirfn/$aspececl.c"
			    cat "$dirfn/$aspececl.c" | $PrPWD/stdcar "char planets[" > "$dirfn/$aspececl-1.c"
			    echo "$planets;" >> "$dirfn/$aspececl-1.c"
			    cat "$dirfn/$aspececl.c" | $PrPWD/stdcdr "char planets[" | $PrPWD/stdcdr ";" >> "$dirfn/$aspececl-1.c"
			    cat "$dirfn/$aspececl-1.c" | $PrPWD/stdcar "double aspects" > "$dirfn/$aspececl.c"
			    echo "[13]={0,  15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180}; " >> "$dirfn/$aspececl.c"
			    cat "$dirfn/$aspececl-1.c" | $PrPWD/stdcdr "double aspects" | $PrPWD/stdcdr ";" >> "$dirfn/$aspececl.c"
			    mv "$dirfn/$aspececl.c" "$dirfn/$aspececl-1.c"
			    cat "$dirfn/$aspececl-1.c" | $PrPWD/stdcar "double geo_lon=" > "$dirfn/$aspececl.c"
			    echo "$longitud; " >> "$dirfn/$aspececl.c"
			    cat "$dirfn/$aspececl-1.c" | $PrPWD/stdcdr "double geo_lon=" | $PrPWD/stdcdr ";" >> "$dirfn/$aspececl.c"
			    mv "$dirfn/$aspececl.c" "$dirfn/$aspececl-1.c"
			    cat "$dirfn/$aspececl-1.c" | $PrPWD/stdcar "double geo_lat=" > "$dirfn/$aspececl.c"
			    echo "$latitud; " >> "$dirfn/$aspececl.c"
			    cat "$dirfn/$aspececl-1.c" | $PrPWD/stdcdr "double geo_lat=" | $PrPWD/stdcdr ";" >> "$dirfn/$aspececl.c"

			    cat "$dirfn/$aspececl.c" | $PrPWD/stdcar "double tjd=" > "$dirfn/$aspececl-1.c"
			    echo "$tjd;" >> "$dirfn/$aspececl-1.c"
			    cat "$dirfn/$aspececl.c" | $PrPWD/stdcdr "double tjd=" | $PrPWD/stdcdr ";" >> "$dirfn/$aspececl-1.c"
			    
			    cat "$dirfn/$aspececl-1.c" | $PrPWD/stdcar "double tjd2=" > "$dirfn/$aspececl.c"
			    echo "$tjd + $dias" | bc -l | tr -d '
' >> "$dirfn/$aspececl.c"
			    echo ";"  >> "$dirfn/$aspececl.c"
			    cat "$dirfn/$aspececl-1.c" | $PrPWD/stdcdr "double tjd2=" | $PrPWD/stdcdr ";" >> "$dirfn/$aspececl.c"
			    aspectoseclipticoserrores=$(gcc -o "$dirfn/$aspececl" "$dirfn/$aspececl.c" -lm -lswe -L$SWESRC -I$SWESRC 2>&1 )
			    userd=$(echo -n "$fn"|$PrPWD/stdcdr "users/input/"|$PrPWD/stdcarsin "/")
			    mkdir $PrPWD/users/tooutput
			    mkdir $PrPWD/users/tooutput/$userd
			    mkdir peticiones
			    if [ -z "$aspectoseclipticoserrores" ];then
				echo "- * - * - *    $dirfn/$aspececl"
				"$dirfn/$aspececl" > "$PrPWD/users/tooutput/$userd/$aspececl.js"
				echo "var ascendente=$ascendente;"  >> "$PrPWD/users/tooutput/$userd/$aspececl.js"
				echo "double prefix_positions[$positions;" | $PrPWD/stddeclaracionesdevariable_tojs  | tr -d '
' >> "$PrPWD/users/tooutput/$userd/$aspececl.js"
				echo ";" | tr '
' ' ' >> "$PrPWD/users/tooutput/$userd/$aspececl.js"
				echo "char prefix_planets[$planets;" | $PrPWD/stddeclaracionesdevariable_tojs  | tr -d '
' >> "$PrPWD/users/tooutput/$userd/$aspececl.js"
				echo ";" | tr '
' ' ' >> "$PrPWD/users/tooutput/$userd/$aspececl.js"
				echo "char descripcion[$descripcion;" | $PrPWD/stddeclaracionesdevariable_tojs  | tr -d '
' >> "$PrPWD/users/tooutput/$userd/$aspececl.js"
				echo ";" | tr '
' ' ' >> "$PrPWD/users/tooutput/$userd/$aspececl.js"
				echo "<.<.(.(..  - - - -   ..).).>.>"
				cat "$PrPWD/users/tooutput/$userd/$aspececl.js"
				echo "<.<.(.(..  - - - -   ..).).>.>"
				echo "$dirfn/$aspececl.c"
				echo "$PrPWD/users/tooutput/$userd/$aspececl.js"
			    else
				echo " E R R O R ! ! "
				echo "$aspectoseclipticoserrores"
			    fi			
			    echo "uuuuUUUUU   $userd UUUUuuuu "
			else
			    echo " EEEEEE $timeerrores "
			fi
		    fi
		fi
	    fi
	fi
    fi
fi
rm "$fn.lock"
