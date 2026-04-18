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
#echo "$nomprograma.."
sleep 0.1
$PrPWD/listadodirectorio_files_extension .c|$PrPWD/stdtohex > $nomprograma.lis
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
			    if [ "$campo" = "archivo" ];then
				clave=$((clave-1))
				archivo=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				r=$((r+1))
			    fi
			    if [ "$campo" = "nombre" ];then
				nombre=$(echo -n ""|./$ejec | $PrPWD/stdtohex| $PrPWD/stdcdrn $dondei | $PrPWD/stdcarn $((dondef-$dondei))  | $PrPWD/stdcdr "$name1" | $PrPWD/stdcdr "0D 0A 0D 0A" | $PrPWD/stdcarsin "0D 0A"|$PrPWD/stdfromhex)
				echo "<< NOMBRE $nombre >>"
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

 			if [ 0$r -eq 2 -a $clave -eq 1 ];then
			    echo "$archivo"|$PrPWD/stdfromhex > $nombre.fil
			    hh=$(echo -n "HTTP/1.1 200 OK"|$PrPWD/stdtohex)
			    if [ ! -f ../users/$nombre.key ];then
				hh3=$(echo "<HTML><BODY><p style=\"font-family: 'Sans';font-size:140px;color:green;\">La Clave de publica de $nombre no esta registrada </BODY></HTML>"|$PrPWD/stdtohex)

			    else
				gpg --batch --yes --no-default-keyring --keyring ../users/$nombre.key --trustdb-name ../users/$nombre.db  --trust-model always -sea -r $nombre $nombre.fil
				hh3=$(echo -n "<HTML><BODY><p style=\"font-family: 'Sans';font-size:140px;color:green;\">$(cat $nombre.fil.asc)</p></h2></BODY></HTML>"|$PrPWD/stdtohex)
			    fi
			    l=$(echo -n "$hh3"|$PrPWD/stdfromhex|wc -c)
			    hh2=$(echo -n "Content-Length: $l"|$PrPWD/stdtohex)
			    hh=$(echo -n "$hh 0A $hh2")
			    hh2=$(echo -n "Content-Type: text/html; "|$PrPWD/stdtohex)
			    hh=$(echo -n "$hh 0A 0D 0A 0D $hh3")
			    echo -n "$hh" |$PrPWD/stdfromhex
			    echo -n "$hh" |$PrPWD/stdfromhex| ./$ejec 1>/dev/null
			fi
		    fi
		    mkdir peticiones
    		    mv $fn.* peticiones/
		fi
	    fi
	fi
    fi
fi
