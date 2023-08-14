l=$(stat -c %s datas/C1)
l=$(printf "%06X" $l)
d=$(date +%M%S%N | ./stdcarn 5 | ./stdtohex | ./stddelcar " " )
k=$(cat datas/C1 | ./stdbuscaarg_donde "comprobar(" | ./stdcdr " " | ./stdcar " " )
kk=$(cat datas/C1 | ./stdcdrn $k | ./stdbuscaarg_donde_hasta $'}\n')
k1=$(echo "./stdcdrn $k|./stdcarn $kk" | base64 |./stdcarsin =)
echo "$k1$l$d"
