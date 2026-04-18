campof=$(cat $1 | ./stdhttpcontent | ./stdcdr "boundary=" | ./stdcarsin $'\r' )
cadena="./stdcdr \"$campof\" "
estaenboundary=$(cat $1 | eval $cadena  | ./stdbuscaarg "$campof" )
i=1
n=0
nombre=$(echo $1 | ./stdcdr "$PWD/" | ./stdcarsin ".post" )
cadeneval=""
if [ ! -f $0.pso ];then
    echo 1 > $0.pso
    el=0;
    skips=$(dd if=$1 bs=1  | ./stdbuscaarg_donde_hasta "$campof" )
    skips=$(dd if=$1 bs=1  | ./stdbuscaarg_donde_hasta "$campof" )
    while [ -n "$estaenboundary" ];do
	skipo=$skips
	skips=$(dd if=$1 bs=1 skip=$skips | ./stdbuscaarg_donde_hasta "$campof" )
	skips=$(echo "$skips+$skipo" | bc)
	echo "------------------------------------------"
	echo "$campof"
	echo "------------------------------------------"
	campo=$(dd if=$1 bs=1 skip=$skips | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcar $'\r\n\r\n' | ./stdcdr "name=\"" | ./stdcarsin $'"' )
	echo -e "\n\n:: $campo $skips :::::::::::::::::::::::::::::::::"
	con=$( dd if=$1 bs=1 skip=$skips  | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcar $'\r\n\r\n'  | ./stdcdr "Content-Disposition: " | ./stdcarsin ";")
	sleep 10
	if [ "$campo" = "actualizar" ];then
	    elemento=$(dd if=$1 bs=1 skip=$skips  | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcdr $'\r\n\r\n' | ./stdcarsin $'\r'  | ./stdcarsin $'\n' )
	    if [ "$actualizar" = "actualizar" ];then
		olddir=$PWD
		cadena=";"
		while [ -n "$cadena" ];do
		    cd /dev;
		    cadena=$($PWD/listadodirectorio_special $cadenacdr | ./stdcarsin $'\n' )
		    cadenacdr="$cadenacdr | ./stdrcdr $'\n' "
		    if [ -n "$cadena" ];then
			donde=$(cat /proc/moounts | ./stdbuscaarg "$cadena" )
			if [ -z $donde ];then
			    listamedia="/media/A, /media/B, /media/C, /media/D"
			    cadenam=";"
			    while [ -n "$cadenam" ];do
				cadenam=$(echo "$listamedia" $cadenamcdr | ./stdcarsin "," )
				cadenamcdr="$cadenacdr | ./stdrcdr $'\n' "
				dondem=$(cat /proc/moounts | ./stdbuscaarg "$cadena" )
				if [ -z "$dondem" ];then
				    mount -v $cadena $cadenam -o force,rw
				fi
			    done
			fi
		    fi
		done
	    fi
	fi
    done
    rm $0.pso
fi
