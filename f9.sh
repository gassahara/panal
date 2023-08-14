    l=$(stat -c %s datas/C1)
    d=$(date +%M%S%N | ./stdcarn 5 | ./stdtohex | ./stddelcar " " )
    k=$(cat datas/C1 | ./stdbuscaarg_donde "comprobar(" | ./stdcdr " " | ./stdcar " " )
    kk=$(cat datas/C1 | ./stdcdrn $k | ./stdtohex | ./stdbuscaarg_donde_hasta "7D 0A")
    kk=$(echo "($kk/3)-2" | bc)
    k1=$(echo "./stdcdrn $k|./stdcarn $kk" | ./stdtohex)
    k2=$(echo "./stdcdrn $l;echo $d" | ./stdtohex)
    k1=$(echo "$k1 $k2" | ./stdfromhex | base64 |./stdcarsin =)
    echo "<$k1>"
    echo $k1 | base64 --decode
    
