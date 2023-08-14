echo "analizando $1"
mimes=" image/text/application/ "
skips=0
archivo="$1"
archivo2="$1"
if [ -n "$(echo "$1" | ./stdbuscaarg "/" )" ];then
    archivo2=$(echo "$1" | ./stdcdr "/" )
    punto="."
    while [ -n "$punto" ];do
	punto=$(echo "$archivo2" | ./stdcdr ".")
	archivo2=$(echo "$archivo2" | ./stdcarsin "." )
	archivo2="$archivo2-$punto"
    done
    echo "$archivo :::"
fi
echo -e "\n\n$archivo2 ::: $archivo\n\n"

cars="\r\n\r\n"
counts=1024
r=1
while [ -z "$esta" -a -n "$r" ];do
    esta=$(dd if=$archivo bs=1 count=$counts |  ./stdbuscaarg_donde_hasta $'\r\n\r\n' )
    if [ -z "$esta" ];then
	esta=$(dd if=$archivo bs=1 count=$counts |  ./stdbuscaarg_donde_hasta $'\n\n' )
	cars="\n\n"
    fi
    r=$(dd if=$1 bs=1 skip=$counts count=1)
    counts=$(echo "0$counts+1024" | bc )
    echo "$counts $1"
done

skips=0
echo "$cars"
echo "...................."

indFrom=$(dd if=$archivo bs=1 skip=$skips 2>/dev/null | ./stdbuscaarg_donde_hasta "From " | ./stdcarsin " " )
echo "i $indFrom"
skips_anterior=0
while [ -n $(dd if=$archivo bs=1 skip=$skips count=1) ];do
    skips=$(echo "0$skips+0$skips_anterior" | bc )
    cadd="dd if=$archivo bs=1 skip=$skips  |  ./stdbuscaarg_donde_hasta $'$cars' "
    indicecabecera=$(eval $cadd)

    if [ 0$indicecabecera -eq 0 ];then
	break
    fi
    echo "__ $cadd"
    
    echo "|||||||||||||"
    echo "0$skips+0$skips_anterior"
    dd if=$archivo bs=1 skip=$skips count=1500 #$indicecabecera  2>/dev/null 
    echo "|||||||||||||"

    echo "------------- indFrom=$indFrom skips=$skips indicecabecera=$indicecabecera $archivo "
    From=$(dd if=$archivo bs=1 skip=$skips 2>/dev/null |  ./stdcdr "From: " | ./stdcarsin $'\n' )
    echo "From=$From"
    campf=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera 2>/dev/null |  ./stdcdrline $'\nSubject: ' )
    echo "Subj=$campf"
    campf=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera 2>/dev/null |  ./stdcdrline $'\nDelivery-date: ' )
    echo "date=$campf"
    size=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera 2>/dev/null |  ./stdcdrline $'\nContent-Length: ' )
    echo "Size=$size"
    contype=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera  2>/dev/null | ./stdcdr $'\nContent-Type: ' | ./stdcar $'\n' )
    echo "Content=$contype"
    b64=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera 2>/dev/null | ./stdcdr $'\nContent-Transfer-Encoding: ' | ./stdcar $'\n' )
    echo "enc=$b64"

    campf=$(echo "$contype" | ./stdcar "/" )
    campf=$(echo "$mimes" | ./stdbuscaarg "$campf" )
    esta=0
    if [ -n "$campf" ];then
	esta=$(($esta+1))
    fi
    if [ -n "$b64" ];then
	esta=$(($esta+1))
    fi

    echo "------------- skips=$skips indFrom=$indFrom "
    skips_anterior=$indicecabecera
    
    mkdir mail
    
    if [ $esta -eq 2 -a -z "$From" ];then
	dd if=$archivo bs=1 skip=$skips count=$indicecabecera
	fname=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera  2>/dev/null | ./stdcdr "filename=\"" | ./stdcarsin "\"")
	echo "###### size $fname "
	if [ -z "$fname" ];then
	    fname=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera  2>/dev/null | ./stdcdr " name=\"" | ./stdcarsin "\"")
	fi
	skips=$(echo "$skips+$indicecabecera" | bc )
	echo "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
	dd if=$archivo bs=1 skip=$skips count=100
		ext=""
		echo "###### $fname "
		echo "CCCCCCCCC $contype -----------------CCCCCCCCCCCCCCCCCCCCCCCC"
		if [ -z "$fname" ];then
		    ext="eml"
		    aaa=$(echo "$contype"  | ./stdbuscaarg "/html" )
		    if [ -n "$aaa" ];then
			ext="html"
		    fi
		    aaa=$(echo "$contype"  | ./stdbuscaarg "/plain" )
		    if [ -n "$aaa" ];then
			ext="txt"
		    fi
		    fname=$(echo "$archivo2-$skips-" | ./stdcarsin "." )
		    fname=$(echo "$0-0$fname-$skips.$ext" | ./stdcdr "/" )
		    echo "==== $fname"
		fi
		fname="mail/$fname"
		if [ -f "$fname" ];then
		    ext=$(echo "$fname" | ./stdcdr "." )
		    fname=$(echo "$fname" | ./stdcarsin "." )
		    lista=$(ls "$fname*" | wc -l | ./stdcar " " | ./stdcar "\r" | ./stdcar "\n" )
		    fname="$fname-$lista.$ext"
		fi
			  
		echo -e "\n .\n  .\n   .\n    \n"
		echo "###### $fname @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		if [ "$b64" = "base64" ];then
		    dd if=$archivo bs=1 skip=$skips  | base64 -d >"$fname"
		else
		    echo "dd if=$archivo bs=1 skip=$skips ($1) /\/\/\/\/\/\/\/\/\/\/\/"
		    dd if=$archivo bs=1 skip=$skips of="$fname" 2>/dev/null 
		    echo "dd if=$archivo bs=1 skip=$skips  /\/\/\/\/\/\/\/\/\/\/\/"
		fi


		echo ">>> $bou $fname ------------------"
		if [ "$ext" = "eml" ];then
		    bash $0 "$fname"
		fi
		echo ">>> >>> $bou ------------------"
		echo "..........."
		break
    fi

    echo "S:$size:"
    campf=$(echo "$contype" | ./stdbuscaarg "multipart/" )
    if [ 0$size -gt 0 -a -z "$campf" ];then
	fname=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera  2>/dev/null | ./stdcdr "filename=\"" | ./stdcarsin "\"")
	echo "###### size $fname "
	if [ -z "$fname" ];then
	    fname=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera  2>/dev/null | ./stdcdr " name=\"" | ./stdcarsin "\"")
	    if [ -z "$fname" ];then
		fname=$(echo "$archivo2-$skips-" | ./stdcarsin "." )
		fname=$(echo "$0-0$fname-$skips.eml" | ./stdcdr "/" )
	    fi
	fi
	fname="mail/$fname"
	skips=$(echo "$skips+$indicecabecera" | bc )
	echo " MENSAJE $fname "
	if [ "$b64" = "base64" ];then
	    dd if=$archivo bs=1 skip=$skips count=$size  | base64 -d 1>"$fname" 2>/dev/null
	else
	    dd if=$archivo bs=1 skip=$skips count=$size of="$fname" 2>/dev/null
	fi
	skips=$(echo "0$skips+0$size" | bc )
	echo "$cabec+$size"
	bash $0 "$fname"
	skips_anterior=0
    fi
    echo "TTTTTTTTTTTT $campf ------- $esta "
    if [ -n "$campf"  -a ! 0$esta -eq 2 ];then
	esta=0
	fname=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera  2>/dev/null | ./stdcdr "filename=\"" | ./stdcarsin "\"")
	if [ -z "$fname" ];then
	    fname=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera  2>/dev/null | ./stdcdr " name=\"" | ./stdcarsin "\"")
	fi
	fname="mail/$fname"
	echo "###### $size $fname ################################"
	

	bou=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera 2>/dev/null |  ./stdcdr "boundary="  | dd bs=1 count=1 )
	if [ "$bou" = '"' ];then
	    bou=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera 2>/dev/null |  ./stdcdr "boundary=\"" | ./stdcarsin '"' )
	else
	    bou=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera 2>/dev/null |  ./stdcdr "boundary=" | ./stdcar $'\n' | ./stdcar $'\r' )
	fi
	dd if=$archivo bs=1 skip=$skips count=$indicecabecera 2>/dev/null |  ./stdcdr "boundary="
	echo "Boun=$bou"
	if [ -n "$bou" ];then
	    echo "[ H $indicecabecera F $indFrom ]"
	    skips=$(echo "$skips+$indicecabecera" | bc )
	    esta=$(dd if=$archivo bs=1 skip=$skips 2>/dev/null | ./stdbuscaarg_donde_hasta "$bou" )
	    if [ 0$esta -eq 0 ];then
		break
	    fi
	    estac=$(echo "$bou" | wc -c )
	    echo "< esta=$esta skips=$skips $archivo >"
	    skips=$(echo "$skips+$esta" | bc )
	    hasta=$(dd if=$archivo bs=1 skip=$skips 2>/dev/null | ./stdbuscaarg_donde_hasta "$bou-" )
	    if [ 0$hasta -eq 0 ];then
		break
	    fi
	    echo "< hasta=$hasta skips=$skips $archivo >"
	    echo "--------"
	else
	    skips=$(echo "$skips+indicecabecera" | bc )
	    fname=$(dd if=$archivo bs=1 skip=$skips count=$indicecabecera  2>/dev/null | ./stdcdr " name=\"" | ./stdcarsin "\"")
	    if [ -z "$fname" ];then
		fname=$(echo "$archivo2-$skips-" | ./stdcarsin "." )
		fname=$(echo "$0-0$fname-$skips.eml" | ./stdcdr "/" )
	    fi
	    echo "==== $fname"
	    fname="mail/$fname"
	    echo "###### $fname "

	    indFrom=$(dd if=$archivo bs=1 skip=$skips 2>/dev/null |  ./stdbuscaarg_donde_hasta $'\n\nFrom ' )
	    echo -e "\n^\n  ^\n   ^\n     ^\n"
	    if [ 0$indFrom -gt 0 ];then
		echo " @#~@#~@#~@#~ skips=$skips esta=$esta indFrom=$indFrom "
		skips=$(echo "$skips-$esta" | bc )
		indFrom=$(echo "$indFrom+$esta" | bc )
		echo " @#~@#~@#~@#~ skips=$skips esta=$esta indFrom=$indFrom "
		dd if=$archivo bs=1 of=$fname skip=$skips count=$indFrom
		skips=$(echo "$skips+$indFrom" | bc )
		echo "TFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFT"
		skips_anterior=0
	    fi
	fi

	while [ 0$esta -gt 0 ];do
	    echo "ESTA $esta hasta $hasta "
	    fname=$(echo "$archivo2-$skips" | ./stdcarsin "." )
	    fname=$(echo "$0-$fname-$skips.part" | ./stdcdr "/" )
	    fname="mail/$fname"
	    echo "< < $fname > >"
	    esta=$(dd if=$archivo bs=1 skip=$skips count=$hasta | ./stdbuscaarg_donde_hasta "$bou" )
	    if [ 0$esta -eq 0 ];then
		esta=$hasta
	    else
		esta=$(echo "$esta-$estac" | bc )
	    fi
	    dd if=$archivo bs=1 skip=$skips count=100
	    dd if=$archivo bs=1 skip=$skips count=$esta of="$fname"
	    echo "FFF"
	    bash $0 "$fname"
	    hasta=$(echo "$hasta-$esta" | bc )
	    skips=$(echo "$skips+$esta+$estac" | bc )
	    echo "$esta . $indicecabecera . $indFrom ***********"
	done
	skips_anterior=0
    fi

    echo -e "\n^\n  ^\n   ^\n     ^\n $skips"
done
