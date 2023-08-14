#!/bin/bash
b=$(cat $1);
eval $b
len_nro_transaccion=$(echo -n $nro_transaccion | wc -c )
if [ $len_nro_transaccion -gt 5 ];then
    len_nro_transaccion=5
fi
if [ -n "$monto_de_pago" -a -n "$nro_transaccion" -a "$banco_emisor" ];then
    nrotra2=$(echo $nro_transaccion | ./ultimosn $len_nro_transaccion)
    esta=$(cat cuenta.csv | ./stdbuscaarg "$nrotra2")
    if [ -n "$esta" ];then
	i=1
	f=$(dd bs=1 if=cuenta.csv  2> /dev/null | ./stdbuscaarg_donde_hasta $'\n')
	skipo=$f
	while [ 0$f -gt 0 ];do
	    e=$(dd bs=1 if=cuenta.csv skip=$skipo count=$f  2> /dev/null)
	    nrotra=$(echo $e | ./stdcdr ";" | ./stdcarsin ";" )
	    montra=$(echo $e | ./stdcdr ";" | ./stdcdr ";" | ./stdcdr ";" | ./stdcdr ";" | ./stdcarsin ";" )
	    nrotra3=$(echo $nrotra | ./ultimosn $len_nro_transaccion)
	    if [ "$nrotra2" = "$nrotra3" -a "$montra"  = "$monto_de_pago" ];then
		echo "$cedula;$monto_de_pago;$nro_transaccion;$nrotra;$banco_emisor"
		break
	    fi
	    skipo=$(echo "$skipo+$f" | bc )
	    if [ "$nrotra3" = "$nrotra2" -a "$montra"  != "$monto_de_pago" ];then
		monto2=$(echo "$monto_de_pago" | tr -d "." )
		monto_de_pago=$(echo "scale=2;$monto2/100000" | bc -l)
		montra=$(echo "$montra" | sed "s/\,/\./g" )
		if [ "$nrotra2" = "$nrotra3" -a $(echo "scale=2;$montra-$monto_de_pago" | bc -l) -eq 0 ];then
		    echo "$cedula;$monto_de_pago;$nro_transaccion;$nrotra;$banco_emisor"
		    break
		fi
	    fi
	    f=$(dd bs=1 if=cuenta.csv skip=$skipo  2> /dev/null | ./stdbuscaarg_donde_hasta $'\n' )
	done
    fi
fi
