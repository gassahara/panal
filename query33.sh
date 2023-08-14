#!/bin/bash
fn=""
cuant=$(echo "0$1+1" | bc)
PrPWD=$PWD
while [ ! -f stdcdr ];do
    cd ..
done
PaPWD=$PWD
sleep 1
cadena=$(echo ".post" | ./stdtohex)
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
cuant=$(echo "0$1+1" | bc)
if [ $cuant -le $(cat $PrPWD/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" ) ];then
    sleep 0.3
    cat $PrPWD/$nomprograma.memoria |  $0 $cuant &
else
    sleep 0.3
    cd data
    l1=$(../listadodirectorio_files | ../stdtohex )
    cd ..
    m1=$(cat $PrPWD/$nomprograma.memoria )
    if [ "$l1" != "$m1" ];then
	echo "!"
	echo -n "$l1" > $PrPWD/$nomprograma.memoria
	echo -n "" > $PrPWD/$nomprograma.procesados
	echo -n "$l1" | $0 0 &
	exit
    else
	cuant=$(cat $PrPWD/$nomprograma.memoria | ./stdbuscaarg_count "$cadena" )
	cuant=$(echo "0$cuant+1" | bc)
	echo -n "$l1" | $0 $cuant &
	exit
    fi
fi
cuant=0$1
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
	    cad=$(cat $PrPWD/$nomprograma.procesados | ./stdbuscaarg ":$fn;" )
	    if [ -z "$cad"  ];then
		campof=$(cat $fn.post | ./stdhttpcontent | ./stdcdr "boundary=" | ./stdcarsin $'\r'  | ./stddelcar "\"" )
		if [ -z "$campof" ];then
		    con=$( cat $fn.post | ./stdcdr "Content-Type: " |  ./stdtohex | ./stdcarsin 0A | ./stdfromhex | ./stdbuscaarg_donde_hasta "form-urlencoded")
		    if [ -n "$con" ];then
			cadena=" ./stdcdrn $con | ./stdtohex | ./stdcdr '0D 0A 0D 0A' | ./stdcar '0D 0A 0D 0A' | ./stdfromhex "
			i=1
			n=0
			r=0
			estaenboundary=1
			while [ -n "$estaenboundary" ];do
			    estaenboundary=$(cat $fn.post | eval $cadena  | ./stdcarsin "&" )
			    campo=$(cat $fn.post | eval $cadena | ./stdcarsin "=" )
			    if [ -n "$campo" ];then
				r=$((r+1))
				address=$(cat $fn.post | eval $cadena | ./stdcdr = | ./stdcarsin "&"  | base64 --decode | ./stdtohex | ./stdcar 0A | ./stdfromhex)
				addresst=$(echo $address | ./stddelcar " " | ./stddelcar "." | ./stddelcar "/" | ./stdtohex | ./stdcar 0A | ./stdfromhex | ./stdcarn 3) 
				echo "en $campo es $address y $addresst"
				if [ "$addresst" = "std" ];then
				    cat $fn.post | eval $cadena | ./stdcdr = | ./stdcar "&"
				    addressf=$(cat $fn.post | eval $cadena | ./stdcdr = | ./stdcarsin "&")
				    n=$((n+1))
				else
				    nn=$(echo $fn $r $campo.tx | ./stddelcar " ")
				    cat $fn.post | eval $cadena  | ./stdcdr = | ./stdcarsin "&"  > "$nn"
				    echo >> "$nn"
				    n=$((n+1))
				fi
			    fi
			    cadena="$cadena | ./stdcdr '&' "
			    echo ">->->- $i <$campo><$campof> 0$n"
			    i=$((i+1))
			done
			echo "n=$n r=$r"
			echo $fn
			if [ 0$n -gt 0 -a 0$r -gt 0 ];then
			    address=$addressf
			    echo "!!!!!!!! $address"
			    l=$(stat -c %s datas/C1)
			    d=$(date +%M%S%N | ./stdcarn 5 | ./stdtohex | ./stddelcar " " )
			    echo $l$d > "$l$d.tx"
			    echo $address >> "$l$d.tx"
			    cadena=$(cat "$l$d.tx" | ./stdtohex | ./stddelcar " ")
			    echo "echo \"$cadena\" | sh interpreta.sh " > "$l$d.tx"
			fi
			if [ 0$n -gt 1 -a 0$r -gt 1 ];then
			    echo $l$d > "$l$d.tx"
			    echo $address >> "$l$d.tx"
			    cat $fn*.tx  >> "$l$d.tx"
			    cadena=$(cat "$l$d.tx" | ./stdtohex | ./stddelcar " ")
			    echo "echo \"$cadena\" | sh interpreta.sh " > "$l$d.tx"
			fi
			if [ 0$n -gt 0 -a 0$r -gt 0 ];then
			    mkdir subir
			    cp "$l$d.tx" $l$d.tx
			    mv $l$d.tx subir/$l$d.tx
			fi
		    fi
		fi
	    fi
	fi
    fi
fi
