#!/bin/bash

gcc -o stdbuscaarg stdbuscaarg.c
while read e;do
    nombro=$(echo $e | cut -d "." -f1)
    echo $nombro
    pow=$(cat $nombro.c | ./stdbuscaarg "pow(")
    if [ -n "$pow" ];then
	gcc -O3 $e -o $nombro -lm -O3
    else
	gcc $e -o $nombro
    fi
done < <(ls -1 *.c)

while read e;do
    nombro=$(echo $e | cut -d "." -f1)
    nombr2=$(echo $e | cut -d "." -f1 | ./stdcdr bignum_ )
    nombr2=$(echo "bn2$nombr2")
    echo $nombro
    pow=$(cat $nombro.c | ./stdbuscaarg "pow(")
    if [ -n "$pow" ];then
	gcc $e -o $nombr2 -lm -O3
    else
	gcc $e -o $nombr2
    fi
done < <(ls -1 bignum*.c)

while read e;do
    if [ ! -x $e ];then
	chmod +x $e
    fi
done < <(ls -1 *.sh)

