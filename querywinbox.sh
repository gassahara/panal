#!/bin/bash
fn=""
cuant=$(echo "0$1+1" | bc)
while [ ! -f stdcdr ];do
    cd ..
done
sleep 1
cadena=$(echo ".get" | ./stdtohex)
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
    sleep 0.05
    cat data/$nomprograma.memoria |  $0 $cuant &
else
    sleep 0.05
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
		echo $cad
		campof=$(cat $fn.get | ./stdhttpcontent | ./stdcdr "?" | ./stdtohex | ./stdcarsin '0A' )
		if [ -z "$campof" ];then
		    cadena=" ./stdtohex |  ./stdcdr 3F | ./stdcarsin 0A | ./stdcarsin 20 "
		    i=1
		    n=0
		    r=0
		    estaenboundary=1
		    while [ -n "$estaenboundary" ];do
			estaenboundary=$(cat $fn.get | eval $cadena | ./stdcar 26 | ./stdfromhex  )
			campo=$(cat $fn.get | eval $cadena  | ./stdfromhex | ./stdcarsin "=" )
			echo $estaenboundary
			echo $campo
			if [ -n "$campo" ];then
			    r=$((r+1))
			fi
			
			if [ "$campo" = "tx" -o "$campo" = "rx" ];then
			    n=$((n+1))
			    imprime2=$(cat $fn.get | eval $cadena | ./stdcarsin 26  | ./stdfromhex )
			    imprime="$imprime $imprime2"
			fi
			cadena="$cadena | ./stdcdr 26 | ./stdcar 26 "
			echo ">->->- $i <$campo><$campof> 0$n"
			i=$((i+1))
		    done
		    echo "n=$n r=$r"
		    if [ 0$n -gt 0 -a 0$r -gt 0 ];then
			echo "!!!!!!!! $imprime"
		    fi
		fi
	    fi
	fi
    fi
fi
