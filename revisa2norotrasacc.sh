#!/bin/sh
if [ -n "$1" ];then
    skipo=$(dd bs=1 skip=$1 if=revisa.b  2>/dev/null  | ./stdbuscaarg_donde_hasta "0A")
    c=$(dd bs=1 skip=$1 if=revisa.b count=$skipo 2>/dev/null )
    b=$(echo "$c" | ./stdfromhex | ./stdcdrcon "nombre=" | ./stdcar Return | sed "s/Return/\"/g" )
    l=$((l+1))
    #b=$(cat $1);
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
    salta=0
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
			salta=1
		    fi
		fi
	    fi
	    if [ 0$salta -eq 0 ];then
		d=$(cat cuenta2.csv | ./stdcdr "$nrotra2" | ./stdtohex | ./stdcarsin 0A | ./stdfromhex )
		if [ -n "$d" ];then
		    monto_de_pago2=$(echo $monto_de_pago | ./stdcarsin " "  | ./stdcarsin "," )
		    montra=$(echo $d | ./stdcdr ";" | ./stdcdr ";" | ./stdcdr ";" | ./stdcarsin ";"  | ./stdcarsin " "  | ./stdcarsin "," )
		    nrotra3=$(echo $nrotra2 | ./ultimosn $len_nro_transaccion)
		    if [ "$montra"  = "$monto_de_pago2" ];then
			cedula2=$(echo $cedula |  tr -d '[A-Za-z.]')
			echo "$cedula2;$monto_de_pago2;$nro_transaccion;$nrotra;$banco_emisor"
			grep --color \"$cedula2\" radius.csv | cut -d ";" -f8,9,13
			MAC=$(grep --color \"$cedula2\" radius.csv | ./stdcdr '"' | ./stdcarsin '"')
			echo "/ip dhcp-server lease set [find mac-address=$MAC] address-lists=Disponible"
			echo "UPDATE FROM radius.rm_users WHERE username=$MAC SET expiration=Getdate()+31"
		    fi
		fi
	    fi
	fi
    fi
    skipo2=$(echo "$skipo+$1" | bc )
    $0 "$skipo2"
fi
