a=$(base64 --decode 2>/dev/null | ./stdcar ";" )
eval "cat data/C1 | ./stdcdrn $a"
