#!/bin/sh
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo ".$PrPWD/$stdcdrd")
done
if [ -n "$PrPWD" ];then
    PrPWD=$stdcdrd
else
    PrPWD="./"
fi
pasa=0
read expresion;
arreglos=$(echo "$expresion" | $PrPWD/bignum_to_binstring|$PrPWD/bignum_to_UV_toomcook|$PrPWD/stdtohex)
mayorlen=0;
arreglo2="$arreglos"
i=0;
ll=0
while [ -n "$arreglo2" ];do
    if [ -n "$arreglo2" ];then
	r=$(echo "$arreglo2"|$PrPWD/stdcarsin "0A"|$PrPWD/stdcdr 3D|$PrPWD/stdfromhex|$PrPWD/bignum_to_binstring|$PrPWD/bignum_to_r_toomcook)
	if [ 0$r -gt 0$mayorlen ];then
	    mayorlen=$r
	fi
    fi
    arreglo2=$(echo "$arreglo2"|$PrPWD/stdcdr "0A")
    if [ -n "$arreglo2" ];then
	r=$(echo "$arreglo2"|$PrPWD/stdcarsin "0A"|$PrPWD/stdcdr 3D|$PrPWD/stdfromhex|$PrPWD/bignum_to_binstring|$PrPWD/bignum_to_r_toomcook)
	if [ 0$r -gt 0$mayorlen ];then
	    mayorlen=$r
	fi
    fi
    arreglo2=$(echo "$arreglo2"|$PrPWD/stdcdr "0A")
done

i=$((2*r))
j=0;
#echo "([$expresion]) $r "
while [ $j -le $i ];do
    arreglo2="$arreglos"
    offset=0;
    indice=2
    Urj=0;
    Vrj=0;
    arreglo4="algo"
    erre=$((r+1))
    while [ $erre -gt 0 ];do
	arreglo4=$(echo -n "$arreglo2"|$PrPWD/stdcdrn 0$offset|$PrPWD/stdcarsin "0A"|$PrPWD/stdcdr 3D|$PrPWD/stdfromhex)
	arreglo5=$(echo -n "$arreglo2"|$PrPWD/stdcdrn 0$offset|$PrPWD/stdcdr "0A"|$PrPWD/stdcdr "0A"|$PrPWD/stdcarsin "0A"|$PrPWD/stdcdr 3D|$PrPWD/stdfromhex)
	if [ -n "$arreglo4" ];then
	    jhex=$(printf %02X $j)
	    Uri=$(echo -n "$arreglo4*$jhex"|$PrPWD/bignum_mul_m)	    
	    Uri=$(echo "$Uri+$arreglo5"|$PrPWD/bignum_add_m)
	    Urj=$(echo "0$Urj+$Uri"|$PrPWD/bignum_add_m);	    
	fi
	arreglo4=$(echo -n "$arreglo2"|$PrPWD/stdcdrn 0$offset|$PrPWD/stdcdr "0A"|$PrPWD/stdcarsin "0A"|$PrPWD/stdcdr 3D|$PrPWD/stdfromhex)
	arreglo5=$(echo -n "$arreglo2"|$PrPWD/stdcdrn 0$offset|$PrPWD/stdcdr "0A"|$PrPWD/stdcdr "0A"|$PrPWD/stdcdr "0A"|$PrPWD/stdcarsin "0A"|$PrPWD/stdcdr 3D|$PrPWD/stdfromhex)
	if [ -n "$arreglo4" ];then
	    jhex=$(printf %02X $j)
	    Uri=$(echo -n "$arreglo4*$jhex"|$PrPWD/bignum_mul_m)
	    Uri=$(echo "$Uri+$arreglo5"|$PrPWD/bignum_add_m)
	    Vrj=$(echo "0$Vrj+$Uri"|$PrPWD/bignum_add_m);
	fi
	offset2=$(echo "$arreglo2"|$PrPWD/stdcdrn 0$offset|$PrPWD/stdbuscaarg_donde_hasta "0A")
	offset=$((offset2+offset))
	offset2=$(echo "$arreglo2"|$PrPWD/stdcdrn 0$offset|$PrPWD/stdbuscaarg_donde_hasta "0A")
	offset=$((offset2+offset))
	erre=$((erre-1))
    done
    Urc=$(echo "Ur[$j]=$Urj"|$PrPWD/stdtohex)
    Urp=$(echo "$Urp $Urc")
    Urc=$(echo "Vr[$j]=$Vrj"|$PrPWD/stdtohex)
    Urp=$(echo "$Urp $Urc")
    if [ $(echo "$Urj"|$PrPWD/bignum_to_binstring|wc -c) -gt 16 -o $(echo "$Vrj"|$PrPWD/bignum_to_binstring|wc -c) -gt 16 ];then
	if [ -z "$1" ];then
	    l=1
	else
	    l=$(($1+1))
	fi
	echo "$Urj*$Vrj"|$0 $l
    fi
    j=$((j+1))
done
echo $Urp|$PrPWD/stdfromhex
#echo $Vrp
# i=$((2*r))
# j=0;
# while [ $j -le $i ];do
#     if [ $(echo ${Ur[$j]}|$PrPWD/bignum_to_binstring|wc -c) -gt 16 -o $(echo ${Vr[$j]}|$PrPWD/bignum_to_binstring|wc -c) -gt 16 ];then
# 	#echo "<<<<<<< Ur[$j]*Vr[$j]=${Ur[$j]}*${Vr[$j]} >>>>>>>>>>>><"
# 	echo "${Ur[$j]}*${Vr[$j]}" | sh $0
#     fi
#     j=$((j+1))
# done

