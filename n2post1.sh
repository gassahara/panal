#!/usr/bin/bash
a=0
fn=""
ll=""
cuant=0$1
cadena=""
while [ $cuant -gt 0 ];do
    cadena="$cadena | ./stdcdr .post "
    cuant=$((cuant-1))
done
cadena2="./listadodirectorio_files $cadena | ./stdbuscaarg_count .post "
ll=$( eval $cadena2 )
cuant=0$1
lll="$0.$cuant.lll"
if [ $((cuant+1)) -lt 0$ll ];then
    $0 $((cuant+1)) & # "$1 | ./stdcdr .post " &
    disown
else
    sleep 1
    $0 &
    disown
fi

if [ 0$ll -gt 0 ];then
    if [ ! -f "$lll" ];then
	./listadodirectorio_files > $lll
	cc="cat $lll $cadena | ./stdcarsin .post | ./stdbuscaarg_count \$'\n'"
	cuan=$(eval $cc)
	quita0a=" "
	while [ 0$cuan -gt 0 ];do
	    quita0a="$quita0a | ./stdcdr \$'\n' "
	    cuan=$((cuan-1))
	done
	cc="cat $lll $cadena $quita0a  | ./stdcarsin .post "
	fn=$(eval $cc)
#	echo " :: $fn ::"

	if [ -n "$fn" ];then
	    # echo "##### $cuan - $fn << "
	    cuan=$(echo "$0" | ./stdbuscaarg_count "/")
	    quita0a=" "
	    while [ 0$cuan -gt 0 ];do
		quita0a="$quita0a | ./stdcdr \$'/' "
		cuan=$((cuan-1))
	    done
	    cc=$(echo "echo \"$0\" $quita0a | ./stdcarsin \".sh\" ")
	    noo=$(eval $cc )
	    if [ ! -f "$fn.$noo.pso" ];then
		echo 1 >  "$fn.$noo.pso"
		if [ -n $(dd if="$fn.post" bs=1 count=1 2>/dev/null ) ];then
		    ./query4.sh $fn.post &
		    disown
		fi
		rm "$fn.$noo.pso"
	    fi
	fi
        rm "$lll"
	#disown
    fi
fi
