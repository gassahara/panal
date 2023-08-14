esta=$(cat winankro | ./stdbuscaarg "boundary=\"" )
cadena=" ./stdcdr  \"boundary=\\\"\" " 
mkdir saldos
while [ -n "$esta" ];do
    boundary=$(cat winankro | eval $cadena | ./stdcar "\"" | tr -d '"' )
    echo "< <$boundary> >"
    if [ -n "$boundary" ];then
	cadena="$cadena ./stdcdr \"$boundary\" "
	estaenboundary=$(cat winankro | eval $cadena  | ./stdbuscaarg "$boundary" )
	while [ -n "$estaenboundary" ];do
	    establa=$(cat winankro | eval $cadena | ./stdcar "$boundary" | ./stdbuscaarg "Nuevo registro de pago" )
#	    echo "[ [ [ [ $cadena eb $estaenboundary t $establa "
	    if [ -n "$establa" ];then
#		echo "] ] ] "
		establa2=$(cat winankro | eval $cadena | ./stdcar "$boundary" | ./stdbuscaarg "$1" )
#		echo "$cadena < $establa2 > ($establa) ($1) "
		if [ -n "$establa2" ];then
	            echo "--------------------------------------------"
		    echo ">"
		    echo "<"
		    tabla=$(cat winankro  | eval $cadena | ./stdcar "$boundary" | ./stdcar "P=C3=A1gina")
		    tabla=$(echo $tabla  | ./stdcdr "Cedula/Rif" )
		    ced=$(echo $tabla | ./stdcar "=09" )
#		    echo "$ced >>>>>>>>"
		    tabla=$(echo $tabla | ./stdcdr "Forma de Pago" )
		    fro=$(echo $tabla | ./stdcar  "=09" )
#		    echo "[ $fro ]"
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
	    fi
	    cadena="$cadena | ./stdcdr \"$boundary\" "
	    estaenboundary=$(cat winankro | eval $cadena  | ./stdbuscaarg "$boundary" )
	done
	cadena="$cadena | ./stdcdr  \"boundary=\\\"\" "
	esta=$(cat winankro | eval $cadena | ./stdbuscaarg "boundary=\"" )
    fi
done 
