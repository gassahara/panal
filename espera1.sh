#!/bin/bash
objetivos="siembra,COMO SEMBRARAS\nsiembra, CUANDO SEMBRARAS, siembra, QUIENES SEMBRARAN\nFABRICACION, PARA QUE FABRICARAS\nFABRICACION, QUIENES FABRICARAN\nFABRICACION, QUINES FABRICARAN\n"
c=1
d=""
puerto=5000
while [ ${#d} -lt 2 ];do
    e=$(nc 127.0.0.1 $puerto | grep "GET" | cut -d "=" -f2)
    puerto=$((puerto+1))
    if [ $puerto -gt 6000 ];then
	puerto=5000
    fi
    if [ -n "$e" ];then
	d=$(echo -e "$objetivos" | grep "$e")
    fi
done
nc -l  < echo $d | cut -d "," -f2

