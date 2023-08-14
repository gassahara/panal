#!/usr/bin/bash
a=0
fn=""
ll=""
cuant=0$1
cadena=""
while [ $cuant -gt 0 ];do
    cadena="$cadena | ./stdcdr .bc "
    cuant=$((cuant-1))
done
cadena2="./listadodirectorio_files $cadena | ./stdbuscaarg_count .bc "
ll=$( eval $cadena2 )
cuant=0$1
lll="$0.$cuant.lll"
if [ $((cuant+1)) -lt 0$ll ];then
    ./n2.sh $((cuant+1)) # "$1 | ./stdcdr .bc " &
    disown
else
    sleep 1
    ./n2.sh &
    disown
fi

if [ 0$ll -gt 0 ];then
    if [ ! -f "$lll" ];then
	echo " %% $cuant $ll $lll %%"
	./listadodirectorio_files > $lll
	cc="cat $lll $cadena | ./stdcarsin .bc | ./stdbuscaarg_count \$'\n'"
	cuan=$(eval $cc)
	quita0a=" "
	while [ 0$cuan -gt 0 ];do
	    quita0a="$quita0a | ./stdcdr \$'\n' "
	    cuan=$((cuan-1))
	done
	cc="cat $lll $cadena $quita0a  | ./stdcarsin .bc "
	fn=$(eval $cc)
	echo $fn

	if [ -n "$fn" ];then
	    # echo "##### $cuan - $fn << "
	    ll=$(cat $fn.bc | ./stdbuscaarg  $'\r\n\r\n' )
	    if [ -n "$ll" ];then
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
#		    cat "$fn.req"
		    if [ -z $(cat "$fn.req") ];then
			echo "_ $fn $noo _"
			if [ -n $(cat "$fn.bc" | ./stdhttp) ];then
			    cat "$fn.bc" | ./stdhttp > "$fn.req"
			fi
		    fi
		    rm "$fn.$noo.pso"
		fi
	    fi
	fi
	#disown
	rm $lll
    fi
fi
