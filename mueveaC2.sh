#!/bin/bash
fn=""
cuant=$(echo "0$1+1" | bc)
PrPWD=$PWD
while [ ! -f stdcdr ];do
    cd ..
done
PaPWD=$PWD
cadena=$(echo ".tx" | ./stdtohex)
nomprograma=$0
while [ $(echo $nomprograma | ./stdbuscaarg_count "/") -gt 0 ];do
    nomprograma=$(echo $nomprograma | ./stdcdr "/" )
done
if [ ! -f $PrPWD/$nomprograma.memoria ];then
    cd $PrPWD
    $PaPWD/listadodirectorio_files  | $PaPWD/stdtohex > $nomprograma.memoria
    cd $PaPWD
fi
if [ ! -f $PrPWD/$nomprograma.procesados ];then
    touch $PrPWD/$nomprograma.procesados
fi
l1=$(../listadodirectorio_files | ../stdtohex )
cd ..
m1=$(cat $PrPWD/$nomprograma.memoria )
if [ "$l1" != "$m1" ];then
    echo "!"
    echo -n "$l1" > $PrPWD/$nomprograma.memoria
    echo -n "" > $PrPWD/$nomprograma.procesados
fi

cuant3=1
while [ 0$cuant3 -le $cuant ];do
    cuant=0$cuant3
    if [ $cuant -le $(cat $PrPWD/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" ) ];then
	cadt=$(cat)
	cad=$(echo "$cadt " | ./stdbuscaarg "$cadena" )
	if [ -n "$cad" ];then
	    cad=$(echo -n "$cadt" | ./stdbuscaarg_donde "$cadena" )
	    while [ 0$cuant -gt 0 ];do
		cuant2=$(echo -n $cad | ./stdcarsin " " )
		cad=$(echo -n $cad | ./stdcdr " " )
		cuant=$(echo "0$cuant-1" | bc)
	    done
	    cad=$(echo -n "$cadt" | ./stdcdrn 0$cuant2 | ./stdcarsin "$cadena" )
	    cadt=""
	    cuant=$(echo -n "$cad" | ./stdbuscaarg_donde 0A )
	    cadt=$(echo -n "$cad" | ./stdbuscaarg_count 0A )
	    while [ 0$cadt -gt 1 ];do
		cuant=$(echo -n $cuant | ./stdcdr " ")
		cadt=$((cadt-1))
	    done
	    cuant=$(echo $cuant | ./stdcar " ")
	    cadt=$(echo -n "$cad" | ./stdcdrn 0$cuant )
	    fn=$(echo $cadt | ./stdfromhex)
	    if [ -n "$fn" ];then
		echo $fn
		cad=$(cat $PrPWD/$nomprograma.procesados | ./stdbuscaarg ":$fn;" )
		if [ -z "$cad"  ];then
		    cat $fn >> $PaPWD/datas/C2
		    rm $fn
		fi
	    fi
	fi
    fi
    cuant3=$((cuant3+1))
done
