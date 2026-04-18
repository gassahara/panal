#!/bin/sh
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
$PrPWD/listadodirectorio_files_extension .c|$PrPWD/stdtohex > $nomprograma.lis
PbPWD=$(echo "$PaPWD"|$PrPWD/stdcdr "$PrPWD")
busca=".."
echo -n "" > $nomprograma.cha
posicion=0;
dondes=$( cat "$nomprograma.lis" |$PrPWD/stdbuscaarg_donde "0A")
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(cat "$nomprograma.lis" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin "0A"|$PrPWD/stdfromhex)
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=$(echo "$listf"|$PrPWD/stdtohex |$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -z "$encuentra" ];then
    echo ";$listf;$chacha;" >> $nomprograma.memoria
fi
if [ -n "$dondes" ];then
    $0 &
else
    ps1=3
    while [ 0$ps1 -gt 2 ];do
    	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
    	sleep 2
    done
    $0 &
fi
if [ -z "$encuentra" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	while [ -n "$slash" ];do
	    fn=$(echo "$fn" | $PrPWD/stdcdr "/" )
	    slash=$(echo $fn | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
    	echo "0 $busca ($fn)"
	len=$(cat "$fn"|wc -c)
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - 0$closs)
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		ejec="$fn.$nomprograma.bin"
    		gcc -o ./$ejec $fn
		echo "$ejec"
		echo "__________"
    		r2t=$(echo -n ""|./$ejec |$PrPWD/stdhttp | $PrPWD/stdunescape| $PrPWD/stdhttpgetfilehtmlcomprueba )
		if [ -n "$r2t" ];then
		    cad1=$(echo -n ""|./$ejec |$PrPWD/stdhttp | $PrPWD/stdunescape | $PrPWD/stdhttpgetfilehtml )
		    cad2=$(echo -n ""|./$ejec |$PrPWD/stdhttpcontent)
		    echo ";$listf;$chacha;" >> $nomprograma.memoria
		    if [ -n "$cad1" -a -n "$cad2" ];then
			campof=$(echo -n ""|./$ejec | $PrPWD/stdhttpcontent | $PrPWD/stdcdr "boundary=" | $PrPWD/stdtohex | $PrPWD/stdcarsin 0D )
			echo "\n\n\n<campof $campof>"
			name1=$(echo -n 'name="' | $PrPWD/stdtohex )
			i=1
			n=0
			dondes=$(echo -n ""|./$ejec  | $PrPWD/stdtohex | $PrPWD/stdbuscaarg_donde "$campof" )
			clave=2
			while [ -n "$dondes" ];do
			    dondei=$(echo "$dondes"|$PrPWD/stdcarsin " ")
			    dondes=$(echo "$dondes" | $PrPWD/stdcdr " ")
			    dondef=$(echo "$dondes"|$PrPWD/stdcarsin " ")
			    echo "<$dondei $dondef>"
			    campo=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei)) | $PrPWD/stdcarsin "0D 0A 0D 0A" | $PrPWD/stdcdr "$name1" | $PrPWD/stdcarsin 22|$PrPWD/stdfromhex)
			    echo "--<$campo>--"
			    if [ "$campo" = "yeard" -a -z "$yeard" ];then
				yeard=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi
			    if [ "$campo" = "mond" -a -z "$mond" ];then
				mond=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi
			    if [ "$campo" = "dayd" -a -z "$dayd" ];then
				dayd=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi
			    if [ "$campo" = "horad" -a -z "$horad" ];then
				horad=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi
			    if [ "$campo" = "mind" -a -z "$mind" ];then
				mind=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi
			    if [ "$campo" = "sistemd" -a -z "$sistemd" ];then
				sistemd=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi
			    if [ "$campo" = "longitud" -a -z "$longitud" ];then
				longitud=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi
			    if [ "$campo" = "latitud" -a -z "$latitud" ];then
				latitud=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi

			    if [ "$campo" = "timezone" -a -z "$timezone" ];then
				timezone=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi
			    cad1=$(echo -n "$cad1" | $PrPWD/stdcdr "$campof")
			    i=$((i+1))
			done
			echo -e "\n\n\nr=$r i=$i"
			nn=$fn
    			while [ $(echo $nn | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    			    nn=$(echo $nn | $PrPWD/stdcdr "/" )
    			done

 			if [ 0$r -eq 9 ];then
			    echo "$archivo"|$PrPWD/stdfromhex > $nombre.fil
			    ffn=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$ffn.html" ];do
				ffn=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done

			    hh=$(echo -n "HTTP/1.1 200 OK"|$PrPWD/stdtohex)
			    hh3=$(echo "<HTML><HEAD><BODY ><iframe id='frama' style='width:80%; height: 500px; position: relative; left:10%' src=''  onload=\"setTimeout(function () { document.getElementById('boto').click();}, 1000); \"></iframe><input id='boto' type='button' onclick=\"if(!document.getElementById('frama').contentDocument) document.getElementById('frama').src='$PbPWD/$ffn.html'; if(document.getElementById('frama').contentDocument) { if(!document.getElementById('frama').contentDocument.body.innerHTML || document.getElementById('frama').contentDocument.body.innerHTML == '<p>Un momento por favor $ffn </p>') { document.getElementById('frama').src='$PbPWD/$ffn.html'; }} \"></input></body></html>"|$PrPWD/stdtohex);
			    l=$(echo -n "$hh3"|$PrPWD/stdfromhex|wc -c)
			    hh2=$(echo -n "Content-Length: $l"|$PrPWD/stdtohex)
			    hh=$(echo -n "$hh 0A $hh2")
			    hh2=$(echo -n "Content-Type: text/html; "|$PrPWD/stdtohex)
			    hh=$(echo -n "$hh 0A 0D 0A 0D $hh3")
			    echo -n "$hh" |$PrPWD/stdfromhex
			    echo -n "$hh" |$PrPWD/stdfromhex| ./$ejec 1>/dev/null

			    if [ "$sistemd" = "UTC" ];then
				timed=$(echo -n "$yeard/$mond/$dayd $horad:$mind $sistemd")
			    fi

			    echo "..:: $timed ::.."
			    cad=$(echo "$timed" | /media/A/nube/comp/cspice/planetas_std )
			    echo "$timed" | /media/A/nube/comp/cspice/planetas_std
			    et=$(echo "$cad" |  $PrPWD/stdcdr "double et=" | $PrPWD/stdcar ";")
			    echo "$cad"
			    sun=$(echo "$cad" |  $PrPWD/stdcdr "#SUN" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    sund=$(echo "$cad" |  $PrPWD/stdcdr "#SUN" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    moon=$(echo "$cad" |  $PrPWD/stdcdr "#MOON" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    moond=$(echo "$cad" |  $PrPWD/stdcdr "#MOON" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    mercury=$(echo "$cad" |  $PrPWD/stdcdr "#MERCURY" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    mercuryd=$(echo "$cad" |  $PrPWD/stdcdr "#MERCURY" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    venus=$(echo "$cad" |  $PrPWD/stdcdr "#VENUS" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    venusd=$(echo "$cad" |  $PrPWD/stdcdr "#VENUS" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    mars=$(echo "$cad" |  $PrPWD/stdcdr "#MARS" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    marsd=$(echo "$cad" |  $PrPWD/stdcdr "#MARS" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    jupiter=$(echo "$cad" |  $PrPWD/stdcdr "#JUPITER" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    jupiterd=$(echo "$cad" |  $PrPWD/stdcdr "#JUPITER" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    saturn=$(echo "$cad" |  $PrPWD/stdcdr "#SATURN" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    saturnd=$(echo "$cad" |  $PrPWD/stdcdr "#SATURN" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    uranus=$(echo "$cad" |  $PrPWD/stdcdr "#URANUS" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    uranusd=$(echo "$cad" |  $PrPWD/stdcdr "#URANUS" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    neptune=$(echo "$cad" |  $PrPWD/stdcdr "#NEPTUNE" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    neptuned=$(echo "$cad" |  $PrPWD/stdcdr "#NEPTUNE" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    pluto=$(echo "$cad" |  $PrPWD/stdcdr "#PLUTO" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    plutod=$(echo "$cad" |  $PrPWD/stdcdr "#PLUTO" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")


			    

			    aspecas=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$aspecas.c" ];do
				aspecas=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done

			    cat $PrPWD/swe/src/swe_ecl_a.c | $PrPWD/stdcar "double positions" > "$aspecas.c"
			    echo "[10]={$sun, $moon, $mercury, $venus, $mars, $jupiter, $saturn, $uranus, $neptune, $pluto };" >> "$aspecas.c"
			    cat $PrPWD/swe/src/swe_ecl_a.c | $PrPWD/stdcdr "double positions" | $PrPWD/stdcdr ";" >> "$aspecas.c"
			    cat "$aspecas.c" | $PrPWD/stdcar "char planets" > "$aspecas-1.c"
			    echo "[10][10]={\"SUN\",      \"MOON\",    \"MERCURIO\",  \"VENUS\",    \"MARTE\",    \"JUPITER\", \"SATURNO\",  \"URANO\",    \"NEPTUNO\",   \"PLUTON\"};" >> "$aspecas-1.c"
			    cat "$aspecas.c" | $PrPWD/stdcdr "char planets" | $PrPWD/stdcdr ";" >> "$aspecas-1.c"
			    cat "$aspecas-1.c" | $PrPWD/stdcar "double aspects" > "$aspecas.c"
			    echo "[5]={0,  60, 90, 120, 180}; " >> "$aspecas.c"
			    cat "$aspecas-1.c" | $PrPWD/stdcdr "double aspects" | $PrPWD/stdcdr ";" >> "$aspecas.c"
			    cat "$aspecas.c" | $PrPWD/stdcar "double toleranc" > "$aspecas-1.c"
			    echo "[5]={4.30, 2, 3, 3, 4};" >> "$aspecas-1.c"
			    cat "$aspecas.c" | $PrPWD/stdcdr "double toleranc" | $PrPWD/stdcdr ";" >> "$aspecas-1.c"
			    mv "$aspecas-1.c" "$aspecas.c"
			    errores2=$(gcc -o $aspecas $aspecas.c -lm 2>&1 )
			    errores="$errores$errores2"
			    cad=$($PaPWD/$aspecas)
			    echo "/*/*/*/*/*"
			    cat $aspecas.c
			    echo "$cad"
			    echo "*/*/*/*/*/*/"
			    aspecto=$(echo "$cad"|$PrPWD/stdbuscaarg "planet1=")
			    aspectosasc="<table>"
			    while [ -n "$aspecto" ];do
				aspecto=$(echo "$cad"|$PrPWD/stdcdr "aspect="|$PrPWD/stdcarsin ";")
				aspectosasc="$aspectosasc<tr><td>$aspecto</td>"
				aspecto=$(echo "$cad"|$PrPWD/stdcdr "planet1="|$PrPWD/stdcarsin ";")
				aspectosasc="$aspectosasc <td>$aspecto</td>"
				aspecto=$(echo "$cad"|$PrPWD/stdcdr "planet2="|$PrPWD/stdcarsin ";")
				aspectosasc="$aspectosasc <td>$aspecto</td>"
				aspecto=$(echo "$cad"|$PrPWD/stdcdr "grados="|$PrPWD/stdcarsin ";")
				aspectosasc="$aspectosasc <td>$aspecto</td></tr>"
				cad=$(echo "$cad"|$PrPWD/stdcdr "grados="|$PrPWD/stdcdr ";")
				aspecto=$(echo "$cad"|$PrPWD/stdbuscaarg "planet1=")
			    done
			    aspectosasc="$aspectosasc </table>"
			    
			    
			    
			    ffc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$ffc.c" ];do
				ffc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done

			    cat $PrPWD/ASC.c | $PrPWD/stdcar "double obslon=" > "$ffc.c"
			    echo "$longitud ;" >> "$ffc.c"
			    cat $PrPWD/ASC.c | $PrPWD/stdcdr "double obslon=" | $PrPWD/stdcdr ";" >> "$ffc.c"
			    cat "$ffc.c" | $PrPWD/stdcar "double obslat=" > "$ffc-1.c"
			    echo "$latitud ;" >> "$ffc-1.c"
			    cat "$ffc.c" | $PrPWD/stdcdr "double obslat=" | $PrPWD/stdcdr ";"  >> "$ffc-1.c"
			    cat "$ffc-1.c" | $PrPWD/stdcar "double et=" > "$ffc.c"
			    echo "$et ; // <-- A " >> "$ffc.c"
			    cat "$ffc-1.c" | $PrPWD/stdcdr "double et=" | $PrPWD/stdcdr ";"  >> "$ffc.c"
			    cat "$ffc.c" | $PrPWD/stdcar "double tz=" > "$ffc-1.c"
			    echo "$timezone ;" >> "$ffc-1.c"
			    cat "$ffc.c" | $PrPWD/stdcdr "double tz=" | $PrPWD/stdcdr ";"  >> "$ffc-1.c"
			    mv "$ffc-1.c" "$ffc.c"

			    errores2=$(gcc -o $ffc $ffc.c -lm 2>&1 )
			    errores="$errores$errores2"


			    tjdf=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$tjdf.c" ];do
				tjdf=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done

			    cat $PrPWD/utctojd.c | $PrPWD/stdcar "int Y=" > "$tjdf.c"
			    echo "$yeard ;" >> "$tjdf.c"
			    cat $PrPWD/utctojd.c | $PrPWD/stdcdr "int Y=" | $PrPWD/stdcdr ";" >> "$tjdf.c"
			    
			    cat "$tjdf.c" | $PrPWD/stdcar "int M=" > "$tjdf-1.c"
			    echo "$mond ;" >> "$tjdf-1.c"
			    cat "$tjdf.c" | $PrPWD/stdcdr "int M=" | $PrPWD/stdcdr ";"  >> "$tjdf-1.c"
			    
			    cat "$tjdf-1.c" | $PrPWD/stdcar "int D=" > "$tjdf.c"
			    echo "$dayd ; // <-- A " >> "$tjdf.c"
			    cat "$tjdf-1.c" | $PrPWD/stdcdr "int D=" | $PrPWD/stdcdr ";"  >> "$tjdf.c"
			    
			    cat "$tjdf.c" | $PrPWD/stdcar "double H=" > "$tjdf-1.c"
			    echo "$horad ;" >> "$tjdf-1.c"
			    cat "$tjdf.c" | $PrPWD/stdcdr "double H=" | $PrPWD/stdcdr ";"  >> "$tjdf-1.c"
			    
			    cat "$tjdf-1.c" | $PrPWD/stdcar "double N=" > "$tjdf.c"
			    echo "$mind ; //<-" >> "$tjdf.c"
			    cat "$tjdf-1.c" | $PrPWD/stdcdr "double N=" | $PrPWD/stdcdr ";"  >> "$tjdf.c"
			    
			    errores2=$(gcc -o $tjdf $tjdf.c -lm 2>&1 )
			    errores="$errores$errores2"
			    tjd=$($PaPWD/$tjdf)

			    swecl=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$swecl.c" ];do
				swecl=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done

			    cat $PrPWD/swe/src/swe_ecl.c | $PrPWD/stdcar "double geo_lon=" > "$swecl.c"
			    echo "$longitud ;" >> "$swecl.c"
			    cat $PrPWD/swe/src/swe_ecl.c | $PrPWD/stdcdr "double geo_lon=" | $PrPWD/stdcdr ";" >> "$swecl.c"			    
			    cat "$swecl.c" | $PrPWD/stdcar "double geo_lat=" > "$swecl-1.c"
			    echo "$latitud ;" >> "$swecl-1.c"
			    cat "$swecl.c" | $PrPWD/stdcdr "double geo_lat=" | $PrPWD/stdcdr ";"  >> "$swecl-1.c"
			    cat "$swecl-1.c" | $PrPWD/stdcar "double tjd=" > "$swecl.c"
			    echo "$tjd ; // <-- A " >> "$swecl.c"
			    cat "$swecl-1.c" | $PrPWD/stdcdr "double tjd=" | $PrPWD/stdcdr ";"  >> "$swecl.c"
			    errores2=$(gcc -o $swecl $swecl.c -lm -lswe -L$PrPWD/swe/src -I$PrPWD/swe/src 2>&1 )
			    errores="$errores$errores2"

			    cad=$($PaPWD/$swecl)
			    sole=$(echo "$cad" |  $PrPWD/stdcdr "#SOL" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    solde=$(echo "$cad" |  $PrPWD/stdcdr "#SOL" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    lunae=$(echo "$cad" |  $PrPWD/stdcdr "#LUNA" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    lunade=$(echo "$cad" |  $PrPWD/stdcdr "#LUNA" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    mercurioe=$(echo "$cad" |  $PrPWD/stdcdr "#MERCURIO" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    mercuriode=$(echo "$cad" |  $PrPWD/stdcdr "#MERCURIO" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    venuse=$(echo "$cad" |  $PrPWD/stdcdr "#VENUS" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    venusde=$(echo "$cad" |  $PrPWD/stdcdr "#VENUS" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    martee=$(echo "$cad" |  $PrPWD/stdcdr "#MARTE" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    martede=$(echo "$cad" |  $PrPWD/stdcdr "#MARTE" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    jupitere=$(echo "$cad" |  $PrPWD/stdcdr "#JUPITER" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    jupiterde=$(echo "$cad" |  $PrPWD/stdcdr "#JUPITER" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    saturnoe=$(echo "$cad" |  $PrPWD/stdcdr "#SATURNO" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    saturnode=$(echo "$cad" |  $PrPWD/stdcdr "#SATURNO" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    uranoe=$(echo "$cad" |  $PrPWD/stdcdr "#URANO" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    uranode=$(echo "$cad" |  $PrPWD/stdcdr "#URANO" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    neptunoe=$(echo "$cad" |  $PrPWD/stdcdr "#NEPTUNO" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    neptunode=$(echo "$cad" |  $PrPWD/stdcdr "#NEPTUNO" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    plutone=$(echo "$cad" |  $PrPWD/stdcdr "#PLUTON" | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")
			    plutonde=$(echo "$cad" |  $PrPWD/stdcdr "#PLUTON" | $PrPWD/stdcdr "DEC=" | $PrPWD/stdcarsin ";")
			    ascecl=$(echo "$cad" |  $PrPWD/stdcdr "#I " | $PrPWD/stdcdr "RA=" | $PrPWD/stdcarsin ";")




			    aspececl=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$aspececl.c" ];do
			     	aspececl=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done
		    
			    cat $PrPWD/swe/src/swe_ecl_a.c | $PrPWD/stdcar "double positions" > "$aspececl.c"
			    echo "[10]={$sole, $lunae, $mercurioe, $venuse, $martee, $jupitere, $saturnoe, $uranoe, $neptunoe, $plutone };" >> "$aspececl.c"
			    cat $PrPWD/swe/src/swe_ecl_a.c | $PrPWD/stdcdr "double positions" | $PrPWD/stdcdr ";" >> "$aspececl.c"
			    cat "$aspececl.c" | $PrPWD/stdcar "char planets" > "$aspececl-1.c"
			    echo "[10][10]={\"SOL\",      \"LUNA\",    \"MERCURIO\",  \"VENUS\",    \"MARTE\",    \"JUPITER\", \"SATURNO\",  \"URANO\",    \"NEPTUNO\",   \"PLUTON\"};" >> "$aspececl-1.c"
			    cat "$aspececl.c" | $PrPWD/stdcdr "char planets" | $PrPWD/stdcdr ";" >> "$aspececl-1.c"
			    cat "$aspececl-1.c" | $PrPWD/stdcar "double aspects" > "$aspececl.c"
			    echo "[5]={0,  60, 90, 120, 180}; " >> "$aspececl.c"
			    cat "$aspececl-1.c" | $PrPWD/stdcdr "double aspects" | $PrPWD/stdcdr ";" >> "$aspececl.c"
			    cat "$aspececl.c" | $PrPWD/stdcar "double toleranc" > "$aspececl-1.c"
			    echo "[5]={7, 3, 7, 7, 7};" >> "$aspececl-1.c"
			    cat "$aspececl.c" | $PrPWD/stdcdr "double toleranc" | $PrPWD/stdcdr ";" >> "$aspececl-1.c"
			    mv "$aspececl-1.c" "$aspececl.c"
			    errores2=$(gcc -o $aspececl $aspececl.c -lm 2>&1 )
			    errores="$errores$errores2"
			    cad=$($PaPWD/$aspececl)
			    echo "<*<*<*<*<*"
			    echo "$cad"
			    echo "*>*>*>*>*>*>"
			    aspecto=$(echo "$cad"|$PrPWD/stdbuscaarg "planet1=")
			    aspectosecl="<table>"
			    while [ -n "$aspecto" ];do
				aspecto=$(echo "$cad"|$PrPWD/stdcdr "aspect="|$PrPWD/stdcarsin ";")
				aspectosecl="$aspectosecl <table style=\"background-color: green;\"><tr><td>$aspecto</td>"
				aspecto=$(echo "$cad"|$PrPWD/stdcdr "planet1="|$PrPWD/stdcarsin ";")
				aspectosecl="$aspectosecl <td>$aspecto</td>"
				aspecto=$(echo "$cad"|$PrPWD/stdcdr "planet2="|$PrPWD/stdcarsin ";")
				aspectosecl="$aspectosecl <td>$aspecto</td>"
				aspecto=$(echo "$cad"|$PrPWD/stdcdr "grados="|$PrPWD/stdcarsin ";")
				aspectosecl="$aspectosecl <td>$aspecto</td>"
				cad=$(echo "$cad"|$PrPWD/stdcdr "planet1="|$PrPWD/stdcdr ";")
				aspecto=$(echo "$cad"|$PrPWD/stdbuscaarg "planet1=")
			    done
			    aspectosecl="$aspectosecl </table>"
			    
			    
			    ffd=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$ffd.c" ];do
				ffd=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done

			    mkdir peticiones
			    mv $ffc.c peticiones/
			    if [ -n "$errores" ];then
				echo "$errores" > $ffn.html
			    else
				ett=$(echo "$et" | ./$ffc)
				echo "<<< $ett >>>"
				ASC=$(echo "$ett" | $PrPWD/stdcdr ";ASC(ramc)=" | $PrPWD/stdcarsin ";")
				DASC=$(echo "$ett" | $PrPWD/stdcdr ";DECLASC=" | $PrPWD/stdcarsin ";")
				e=$(echo "$ett" | $PrPWD/stdcdr "e=" | $PrPWD/stdcarsin ";")
				MC=$(echo "$ett" | $PrPWD/stdcdr ";MC=" | $PrPWD/stdcarsin ";")
				ARMC=$(echo "$ett" | $PrPWD/stdcdr ";RAMC(p)=" | $PrPWD/stdcarsin ";")
				echo "<HTML><BODY><table><tr><td>ET: $et</td><td>JD: $tjd</td></tr></table> <table><tr style=\"background-color: lightgreen\"><th colspan=2>ASCENCIONAL</td><th colspan=2>ECLIPTICO</td></tr><tr><td><p>ASC: $ASC</p><p><p>SUN: $sun</p><p>MOON: $moon</p><p>MERCURY: $mercury</p><p>VENUS: $venus</p><p>MARS: $mars</p><p>JUPITER: $jupiter</p><p>SATURN: $saturn</p><p>URANUS: $uranus</p><p>NEPTUNE: $neptune</p><p>PLUTO: $pluto</p></td> <td>$aspectosasc</td>  <td><p> ASC: $ascecl</p><p>SUN: $sole </p><p>MOON: $lunae </p><p>MERCURY: $mercurioe </p><p>VENUS: $venuse </p><p>MARS: $martee </p><p>JUPITER: $jupitere </p><p>SATURN: $saturnoe </p><p>URANUS: $uranoe</p><p>NEPTUNE: $neptunoe </p><p>PLUTO: $plutone</p> </td> <td> $aspectosecl</td> </tr>  </BODY></HTML>" > $ffn.html
				cat $ffn.html
				mkdir peticiones
    				mv $ffd* peticiones/
			    fi			    
			fi
			mkdir peticiones
    			mv $swecl*.c peticiones/
    			mv $tjdf*.c peticiones/
			mv $aspecas*.c peticiones/
			mv $aspececl*.c peticiones/
    			mv $fn peticiones/
    			mv $ffc* peticiones/
    			mv $fn.* peticiones/
		    fi
		fi
	    fi
	fi
    fi
fi
