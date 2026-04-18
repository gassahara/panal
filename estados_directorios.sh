pp=$(dirname $0)
if [ -z "$pp" -o "$pp" = "." ];then
    nn=$0
else
    nn=$(echo $0 | $pp/stdcdr "$pp/")
fi
listac=$(find ./ -type f | $pp/stdtohex)
listar=$(cat $nn.memoria | $pp/stdtohex)
rm $nn.memoria.reg
i=1
listan=$(echo $listac | $pp/stdbuscaarg_count "0A")
bytes=0
if [ -z "$listar" ];then
    listar=" "
fi
n=1
while [ $i -lt $listan ];do
    listac=$(echo $listac|$pp/stdcdr 0A )
    curr=$(echo $listac|$pp/stdcar 0A )
    b=$(stat -c %s "$(echo $curr | $pp/stdfromhex)" )
    bf=$(echo -n "$b;" | $pp/stdtohex)
    f=$(echo $listar | $pp/stdbuscaarg "$bf$curr" )
    echo "$bf$curr" | $pp/stdfromhex >> $nn.memoria.reg	
    if [ -z "$f" ];then
	currt=$(echo -n "$nn.memoria" | $pp/stdtohex)
	currz=$(echo "$curr" | $pp/stdbuscaarg "$currt")
	if [ -z "$currz" -a -n "$b" -a 0$b -gt 0 ];then
	    if [ $n -eq 1 ];then
		echo "Bytes       Nombre"
		n=2
	    fi
	    i2=$(echo $b | wc -c)
	    echo -n "$b"
	    while [ $i2 -lt 12 ];do
		echo -n " "
		i2=$((i2+1))
	    done
	    echo -n $curr | $pp/stdfromhex
	    bytes=$(echo "$bytes+$b" | bc)
	fi
    fi
    i=$((i+1))
done
if [ $n -ne 1 ];then
    mv $nn.memoria.reg $nn.memoria
    i=$(echo $b | wc -c)
    echo -n "$bytes"
    while [ $i -lt 12 ];do
	echo -n " "
	i=$((i+1))
    done
    echo TOTAL
fi