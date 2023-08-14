#!/bin/sh
cuenta="cuenta" 
monto="monto"
if [ -f "$PrPWD/users/cuentas/$cuenta" ];then
    utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    while [ -f "$dirfn/$utcc.c" ];do
	utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    done
    saldo_c=$(cat $PrPWD/users/cuentas/$cuenta | $PrPWD/stdcdr "double saldo="| $PrPWD/stdcarsin ";")
    saldo_m=$(cat $PrPWD/users/cuentas/$cuenta | $PrPWD/stdcdr "double monto="| $PrPWD/stdcarsin ";")
    echo "s $saldo"
    echo "c 0$saldo_c"
    echo "0$saldo_c - 0$saldo_m" | bc -l
    saldo=$(echo "0$saldo_c - 0$saldo_m" | bc -l)
    cat $PrPWD/users/cuentas/$cuenta | $PrPWD/stdcar "double saldo=" > $utcc
    echo  "0$saldo;" >> $utcc
    cat $PrPWD/users/cuentas/$cuenta | $PrPWD/stdcdr "double saldo=" | $PrPWD/stdcdr ";" >> $utcc
    cp -v $utcc "$PrPWD/users/cuentas/$cuenta"
    mkdir $PrPWD/users/output
    echo "$saldo_m descontados del saldo, saldo actualÑ $saldo" #> $PrPWD/users/output/$userd/$respuesta
else
    echo "Cedula No se Encuentra..." #> $PrPWD/users/output/$userd/$respuesta
fi
