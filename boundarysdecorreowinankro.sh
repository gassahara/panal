
esta=$(cat win4 | ./stdbuscaarg "boundary=\"" )
cadena=" ./stdcdr  \"boundary=\\\"\" " 
mkdir saldos
    boundary=$(cat win4 | eval $cadena | ./stdcar "\"" | tr -d '"' )
	cadena=" ./stdcdr 'boundary=\"$boundary\"' "
while [ -n "$esta" ];do
    if [ -n "$boundary" ];then
	echo "$boundary "
	cadena=" ./stdcdr 'boundary=\"$boundary\"' "
	echo $cadena
	cadena2=" ./stdcdr \"$boundary\" "
	estaenboundary=$(cat win4 | eval $cadena  | ./stdbuscaarg "$boundary" )
	while [ -n "$estaenboundary" ];do
 	    establa=$(cat win4 | eval $cadena | eval $cadena2 | ./stdbuscaarg "Nuevo registro de pago" )
	    if [ -n "$establa" ];then
		establa2=$(cat win4 | eval $cadena | eval $cadena2 | ./stdbuscaarg "$1" )
		echo "[ $establa . $establa2 ]"
		if [ -n "$establa2" ];then
		    echo ">"
		    echo "<"
		    tabla=$(cat win4  | eval $cadena | eval $cadena2 | ./stdcar "$boundary" | ./stdcdr "Nuevo registro de pago" | ./stdcar "P=C3=A1gina")
		    tabla=$(echo $tabla  | ./stdcdr "Cedula/Rif" )
		    echo -e "__________\n$tabla\n-------------\n"
		    ced=$(echo $tabla | ./stdcdr "<td" | ./stdcar "</td>" )
		    if [ -z "$ced" ];then
			ced=$(echo $tabla | ./stdbuscaarg "=09" )
			if [ -n "$ced" ];then
			    ced=$(echo $tabla | ./stdcar "=09" )
			fi
		    fi
		    if [ -n "$ced" ];then
			echo "$ced >>>>>>>>"
			tabla=$(echo $tabla | ./stdcdr "Forma de Pago" )

			fro=$(echo $tabla | ./stdcdr "<td" | ./stdcar "</td>" )
			if [ -z "$fro" ];then
			    fro=$(echo $tabla | ./stdbuscaarg "=09" )
			    if [ -n "$fro" ];then
				fro=$(echo $tabla | ./stdcar "=09" )
			    fi
			fi
			echo "[ $fro ]"
			tabla=$(echo $tabla | ./stdcdr "Banco Emisor" )
			banco=$(echo $tabla | ./stdcar  "=09" )
			tabla=$(echo $tabla | ./stdcdr "Banco Receptor" )
			banco2=$(echo $tabla | ./stdcar  "=09" )
			tabla=$(echo $tabla | ./stdcdr "Fecha de Pago" )
			fecha=$(echo $tabla | ./stdcar  "=09" )
			tabla=$(echo $tabla | ./stdcdr "Nro de Transacci=C3=B3n" )
			nro=$(echo $tabla | ./stdcar  "=09" )
			tabla=$(echo $tabla | ./stdcdr "Monto del Pago" )
			pago=$(echo $tabla | ./stdcar  "=09" )
			echo "$ced pago el monto $pago a traves de $fro por $banco a la cuenta $banco2 en $fecha nro de trans $nro"
		    fi
	    #echo "[ $tabla ]"
		fi
	    fi
	    cadena2=" $cadena2 | ./stdcdr \"$boundary\" "
	    estaenboundary=$(cat win4 | eval $cadena  | eval $cadena2 | ./stdbuscaarg "$boundary" )
	done
    fi
    esta=$(cat win4 | eval $cadena | ./stdbuscaarg "boundary=\"" )
    cadena="$cadena | ./stdcdr \"boundary=\\\"\" "
    boundary=$(cat win4 | eval $cadena | ./stdcar "\"" | tr -d '"' )
    echo $cadena
    echo $boundary
done 
