fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
PrPWD="/root/nube"
dirout="/root/nube/msgs/Fs"
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
lista0=$(grep -i  "BUY\|BOUGHT" *.c | cut -d ":" -f1 | sort | uniq)
posicion=0;
dondes=$( echo "$lista0" |$PrPWD/stdbuscaarg_donde "
")
encuentra="ALGO"
touch $nomprograma.memoria
while [ -n "$dondes"  ];do
        listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
	echo "<$listf>"
	posicion=$(echo -n "$dondes" |$PrPWD/stdcarsin " ")
	posicion=$(expr 0$posicion + 1)
	dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
	cp -v "$listf" "$dirout"
done
