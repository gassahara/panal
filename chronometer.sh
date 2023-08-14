#!/bin/bash
hour=0
min=0
sec=0
while [ 1 ]; do
    echo -ne "$hour:$min:$sec\033[0K\r"
    sec=$(expr 0$sec + 1)
    sleep 1
    if [ "$sec" -eq 60 ];then
        sec=0;
	min=$(expr 0$min + 1)
    fi
    if [ "$min" -eq 60 ];then
        min=0;
	hour=$(expr $hour + 1)
    fi
done
