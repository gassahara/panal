#!/bin/bash
fn=""
cuant=$(echo "0$1+1" | bc)
while [ ! -f stdcdr ];do
    cd ..
done
cadena=$(echo ".post" | ./stdtohex)
nomprograma=$0
while [ $(echo $nomprograma | ./stdbuscaarg_count "/") -gt 0 ];do
    nomprograma=$(echo $nomprograma | ./stdcdr "/" )
done
if [ ! -f data/$nomprograma.memoria ];then
    cd data
    ../listadodirectorio_files  | ../stdtohex > $nomprograma.memoria
    cd ..
fi
if [ ! -f data/$nomprograma.procesados ];then
    touch data/$nomprograma.procesados
fi
cuant=$(echo "0$1+1" | bc)
if [ $cuant -le $(cat data/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" ) ];then
    cat data/$nomprograma.memoria |  $0 $cuant &
else
    sleep 2
    cd data
    l1=$(../listadodirectorio_files | ../stdtohex )
    cd ..
    m1=$(cat data/$nomprograma.memoria )
    if [ "$l1" != "$m1" ];then
	echo "!"
	echo -n "$l1" > data/$nomprograma.memoria
	echo -n "" > data/$nomprograma.procesados
	echo -n "$l1" | $0 0 &
	exit
    else
	cuant=$(cat data/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" )
	cuant=$(echo "0$cuant+1" | bc)
	echo -n "$l1" | $0 $cuant &
	exit
    fi
fi
cuant=0$1
if [ $cuant -le $(cat data/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" ) ];then
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
	    cad=$(cat data/$nomprograma.procesados | ./stdbuscaarg ":$fn;" )
	    if [ -z "$cad"  ];then
		nn=$fn
		while [ $(echo $nn | ./stdbuscaarg_count "/") -gt 0 ];do
		    nn=$(echo $nn | ./stdcdr "/" )
		done
		l=$(cat datas/leader | ./stdcar $'\n')
		if [ "$l" = "127.0.0.1" ];then
		    cat datas/C1 $fn.tx > datas/C2
		    mv datas/C2 datas/C1
		else
		    curl -L "$leader:5001/wal.htm" -d "address=$nn&tx=$(cat $fn.tx)"
		fi
	    fi
	fi
    fi
fi
