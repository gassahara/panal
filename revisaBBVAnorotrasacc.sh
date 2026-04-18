#!/bin/bash
b=$(cat $1);
eval $b
len_nro_transaccion=$(echo -n $nro_transaccion | wc -c )
if [ $len_nro_transaccion -gt 5 ];then
    len_nro_transaccion=5
fi
if [ "$banco_emisor" = "Banco Provincial BBVA" -a "$forma_de_pago" = "Transferencia Bancaria" ];then
    i=1
    f=$(dd bs=1 if=cuenta.csv  2> /dev/null | ./stdbuscaarg_donde_hasta $'\n')
    skipo=$f
    while [ $f -ge 0 ];do
	echo -n "."
	f=$(dd bs=1 if=cuenta.csv skip=$skipo  2> /dev/null | ./stdbuscaarg_donde_hasta $'\n' )
	f=$((f-1))
	e=$(dd bs=1 if=cuenta.csv skip=$skipo count=$f  2> /dev/null)
	nrotra=$(echo $e | ./stdcdr ";" | ./stdcarsin ";" )
	montra=$(echo $e | ./stdcdr ";" | ./stdcdr ";" | ./stdcdr ";" | ./stdcdr ";" | ./stdcarsin ";" )
	nrotra2=$(echo $nro_transaccion | ./ultimosn $len_nro_transaccion)
	nrotra3=$(echo $nrotra | ./ultimos5hastaVoJ | ./ultimosn $len_nro_transaccion)
	if [ "$nrotra2" = "$nrotra3" -a "$montra"  = "$monto_de_pago" ];then
	    echo $cedula - $nrotra3 + $nrotra2 - $nrotra
	fi
	skipo=$((skipo+$f+1))
	if [ "$nrotra3" = "$nrotra2" -a "$montra"  != "$monto_de_pago" ];then
	    monto2=$(echo $monto_de_pago | tr -d "." )
	    monto_de_pago=$(echo "$monto2/100000" | bc -l)
	    montra=$(echo "$montra" | sed "s/\,/\./g" )
	    echo "|$monto_de_pago>$montra"
	    if [ "$nrotra2" = "$nrotra3" -a $(echo "$montra-$monto_de_pago" | bc -l) -eq 0 ];then
		echo $cedula - $nrotra3 + $nrotra2 - $nrotra
	    fi
	    #	    echo "$len_nro_transaccion $nro_transaccion  - $nrotra3 + $nrotra2 - $nrotra + $banco_emisor - $forma_de_pago : $montra > $monto_de_pago"
	fi
    done
fi
