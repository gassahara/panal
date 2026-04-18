#~/bin/bash
l=$(./stdtohex);
lm=$(echo $l|./stdtohex|./stdbuscaarg 0A)
while [ -n "$lm" ];do
    l2=$(echo "$l" |./stdcarsin "0A"|./stdfromhex)
    echo "<a href=../" '"' "$l2"'"'">$l2</a>"
    l=$(echo "$l"|./stdtohex|./stdcdr 0A )
    lm=$(echo $l|./stdtohex|./stdbuscaarg 0A)
done
