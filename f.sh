
l=$(stat -c %s data/C1)
l=$(printf "%08X" $l)
d=$(date +%M%S%N | ./stdcarn 6 | ./stdtohex | ./stddelcar " " )
k1=$(echo "cat data/C1|./stdcdrcon comp|./stdcar $'}\n'" | base64 )
echo "$k1$l$d"
}
