#!/bin/bash
while read nn;do
    case "$nn" in
	*yn)
	    nn=$(echo $nn | ./stdcarsin ".yn")
	    while [ -n "$(echo $nn | ./stdbuscaarg / )" ];do
		nn2=$(echo $nn | ./stdcdr "/")
		echo -n "."
		nn=$nn2
	    done
		echo $nn
	    if [ -n "$nn" ];then
		z=$(ps -emf  | ./stdbuscaarg "n3b\.sh $nn" )
		echo "$nn" "$z"
		if [ -z "$z" ];then
		    echo "$nn.yn" "$nn.req"
		    if [ -f "$nn.yn" ];then
			./n3b.sh $nn &
			disown
		    fi
		fi
	    fi
	    ;;
    esac
done < <(./listadodirectorio_files $n )
sleep 1
./n3a.sh &
disown
