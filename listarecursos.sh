#!/bin/bash
c=1
d=""
e=""
recursos="AGUA=300\n
fertilizante=500\n
abono=3000\n
carbon=1500\n
terreno=100"
while read d;do
    echo ==  $d
    let $d
    d=$(echo $d | cut -d "=" -f1)
    d+="="
    while read e;do
	f=$(nc 127.0.0.1 $e -C -q 1 -vvvvv | grep "$d")
	echo -e "en $e $f"
	if [ -n "$f" ];then
	    let $f
	fi
    done< <(netstat -nap 2>/dev/null | grep -w nc | sed "s/      / /g; s/   / /g" | cut -d " " -f4 | cut -d ":" -f2)
done < <(echo -e $recursos)
echo $AGUA
#-->
