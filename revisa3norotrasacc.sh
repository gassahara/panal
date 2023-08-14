b=$(cat)
echo $b | ./stdcarn 50
echo
    nombre="";
    apellido="";
    cedula="";
    forma_de_pago="";
    banco_emisor="";
    banco_receptor="";
    fecha_de_pago="";
    nro_transaccion="";
    monto_de_pago=""
    eval "$b" 2>/dev/null
    len_nro_transaccion=$(echo -n $nro_transaccion | wc -c )
    if [ $len_nro_transaccion -gt 5 ];then
	len_nro_transaccion=5
    fi
    if [ -n "$monto_de_pago" -a -n "$nro_transaccion" -a "$banco_emisor" ];then
	nrotra2=$(echo $nro_transaccion | ./ultimosn $len_nro_transaccion)
	#    echo "$nrotra2"
	esta=$(cat cuenta2.csv | ./stdbuscaarg "$nrotra2")
	if [ -n "$esta" ];then
	    i=1
	    es=$(echo "$nrotra2 ;" | tr -d " ")
	    esta=$(cat cuenta2.csv | ./stdbuscaarg "$es")
	    if [ -z "$esta" ];then
		es=$(echo "$nrotra2 V" | tr -d " ")
		esta=$(cat cuenta2.csv | ./stdbuscaarg "$es")
		if [ -z "$esta" ];then
		    es=$(echo "$nrotra2 J" | tr -d " ")
		    esta=$(cat cuenta2.csv | ./stdbuscaarg "$es")
		    if [ -z "$esta" ];then
			continue
		    fi
		fi
	    fi
	    d=$(cat cuenta2.csv | ./stdcdr "$nrotra2" | ./stdtohex | ./stdcarsin 0A | ./stdfromhex )
	    if [ -n "$d" ];then
		monto_de_pago2=$(echo $monto_de_pago | ./stdcarsin " "  | ./stdcarsin "," )
		montra=$(echo $d | ./stdcdr ";" | ./stdcdr ";" | ./stdcdr ";" | ./stdcarsin ";"  | ./stdcarsin " "  | ./stdcarsin "," )
		echo "N $nrotra2 MONTO $montra != $monto_de_pago2"
		nrotra3=$(echo $nrotra2 | ./ultimosn $len_nro_transaccion)
		if [ "$montra"  = "$monto_de_pago2" ];then
		    echo "$cedula;$monto_de_pago2;$nro_transaccion;$nrotra;$banco_emisor"
		fi
	    fi
	fi
    fi
