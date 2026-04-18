#!/bin/bash
i=0;
echo -n "{"
while  [ 0$i -le 8 ];do
	j=0;
	while  [ 0$j -le 15 ];do
		potencia1=$(echo "obase=16;$j*(16^$i)"|bc)
		echo -n "$potencia1,";
		j=$((j+1))
	done
	echo -n "}, {"
	i=$((i+1))
done
echo -n "}"
