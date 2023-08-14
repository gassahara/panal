#!/usr/bin/bash
a=0
fn=""
cadena="./listadodirectorio_files posts/ $1 | ./stdbuscaarg .in "
ll=$( eval $cadena )
if [ -n "$ll" ];then
    ./n2query.sh "$1 | ./stdcdr .in " &
    disown
else
    sleep 0.1
    ./n2query.sh &
    disown
fi

if [ -z "$1" ];then
    fn=$(ls -1 *.in 2>/dev/null | ./stdcarsin .in )
else
    #    cadena="./listadodirectorio_files | ./stdcarsin .in  | ./stdcdr $'\n' "
    cadena="1"
    quita0a=" "
    while [ -n "$cadena" ];do
	quita0a="$quita0a | ./stdcdr \$'\n' "
	cc="./listadodirectorio_files posts/ $1 | ./stdcarsin .in $quita0a  | ./stdbuscaarg \$'\n'"
	cadena=$(eval $cc)
	#echo -n "{$cadena}"
    done
    cc=$(echo "./listadodirectorio_files posts $1 | ./stdcarsin .in $quita0a  | xxd -r -p ")
    fn=$(eval $cc)
    echo ".$fn." # $1 \n [$cc]"
    # fn=$(eval $cadena )
fi

if [ -n "$fn" ];then
    z=""
    if [ ! -f $fn.pso ];then
    ps -aemf  > $fn.pso
    z=$(cat $fn.pso | ./stdbuscaarg "bash n3b.sh $fn" )
    echo "$fn [$z] "
    if [ -z "$z" ];then
	bash n3b.sh $fn &
	echo ".."
	disown
    fi
    fi
fi
#disown
