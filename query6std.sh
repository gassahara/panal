skipo=0
echo "$1"
cars=1
ccount=0
esta=0
skipes=0
while [ -z $esta ];do
    skipes=$ccount
    ccount=$((ccount+500))    
    esta=$(dd if=$1 bs=1 skip=$skipes count=$ccount |  ./stdbuscaarg_donde_hasta $'\r\n\r\n' )
    if [ -z "$esta" ];then
	esta=$(dd if=$1 bs=1 skip=$skipes count=$ccount |  ./stdbuscaarg_donde_hasta $'\n\n' )
	cars=2
    fi
done
if [ $esta -gt 0 ];then
    esta=$((esta+$skipes))
fi
while [ 0$esta -gt 1 ];do
    echo "dd if=$1 bs=1 skip=$skipo"
    cabfn=$(dd if=$1 bs=1 skip=$skipo 2>/dev/null | ./stdbuscaarg_donde_hasta "From " )
    cabfn=$(echo "0$skipo+0$cabfn" | bc -l)
    echo "------------- skipo=$skipo cabfn=$cabfn "
    if [ $cars -eq 1 ];then
	cabhn=$(dd if=$1 bs=1 skip=$cabfn 2>/dev/null |  ./stdbuscaarg_donde_hasta $'\r\n\r\n' )
    else
	cabhn=$(dd if=$1 bs=1 skip=$cabfn 2>/dev/null |  ./stdbuscaarg_donde_hasta $'\n\n' )
    fi
    cabec=$cabhn
    cabhn=$(echo "0$cabfn+0$cabhn" | bc -l)
    echo "------------- cabfn=$cabfn skipo=$skipo cabhn=$cabhn "
    campf=$(dd if=$1 bs=1 skip=$cabfn 2>/dev/null |  ./stdcdr "From: " | ./stdcar $'\n' )
    echo "From=$campf"
    campf=$(dd if=$1 bs=1 skip=$cabfn count=$cabhn 2>/dev/null |  ./stdcdr "Subject: "  | ./stdcar $'\n' )
    echo "Subj=$campf"
    campf=$(dd if=$1 bs=1 skip=$cabfn count=$cabhn 2>/dev/null |  ./stdcdr "Delivery-date: "  | ./stdcar $'\n' )
    echo "date=$campf"

    fname=$(dd if=$1 bs=1 skip=$cabfn count=$cabhn  2>/dev/null | ./stdcdr "filename=\"" | ./stdcarsin "\"")
    b64=$(dd if=$1 bs=1 skip=$cabfn count=$cabhn  2>/dev/null | ./stdcdr "Content-Transfer-Encoding: " | ./stdcar $'\n' )
    echo "###### $fname "
    if [ -z "$fname" ];then
	fname=$(dd if=$1 bs=1 skip=$cabfn count=$cabhn  2>/dev/null | ./stdcdr " name=\"" | ./stdcarsin "\"")
	if [ -z "$fname" ];then
	    fname=$(echo "$0.$1.$cabfn.mai" | ./stdcdr "/" )
	fi
    fi
    fname="mail/$fname"

    size=$(dd if=$1 bs=1 skip=$cabfn count=$cabhn 2>/dev/null |  ./stdcdr "Content-Length: " | ./stdcarsin  $'"' )
    echo "Size=$size"
    
    if [ "$b64" = "base64" ];then
	dd if=$1 bs=1 skip=$cabfn count=$size  | base64 -d 1>"$fname" 2>/dev/null
    else
	dd if=$1 bs=1 skip=$cabfn count=$size  1>"$fname" 2>/dev/null
    fi
    cabhn=$(echo "$cabhn+$size" | bc -l )
    esta=$(dd if=$1 bs=1 skip=$cabhn 2>/dev/null |  ./stdbuscaarg_donde_hasta "From " )
    skipo=$(echo "0$esta+0$cabhn" | bc -l )
    echo "$esta $skipo ::::"
done
