pp=$(dirname $0)
if [ -z "$pp" -o "$pp" = "." ];then
    nn=$0
else
    nn=$(echo $0 | $pp/stdcdr "$pp/")
fi
echo $nn
listac=$($pp/listadodirectorio_dirs | $pp/stdtohex)
listar=$(cat $nn.memoria | $pp/stdtohex)
rm $nn.memoria.reg
i=1
listan=$(echo $listac | $pp/stdbuscaarg_count "0A")
bytes=0
if [ -z "$listar" ];then
    listar=" "
fi
n=1
echo $listan
currt=$(echo ".mpd" | $pp/stdtohex)
nl="0"
nm=0
while [ $i -lt $listan ];do
    currt=$(echo -n "$nn.memoria" | $pp/stdtohex)
    currz=$(echo "$curr" | $pp/stdbuscaarg "$currt")
    if [ -z "$currz" ];then
	echo $curr | $pp/stdfromhex
    fi
    echo -n $i.
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
