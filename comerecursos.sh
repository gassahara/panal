#!/bin/bash
c=1
d=""
e=""
recursos="AGUA-=30;\n
fertilizante=\\$((fertilizante-5))\n
abono=\\$((abono-30))\n
carbon=\\$((carbon-15))\n
terreno=\\$((terreno-10))\n"
while read d;do
    puerto=$(netstat -nap 2>/dev/null | grep -w nc | sed "s/      / /g; s/   / /g" | cut -d " " -f4 | cut -d ":" -f2 | tail -n1)
    if [ -z "$puerto" ];then
	puerto=5000
    else
	puerto=$((puerto+1))
    fi
    nc -l -p $puerto -c "echo \"$d\" "
    echo "$d"
done < <(echo -e $recursos)
echo $AGUA
#-->
