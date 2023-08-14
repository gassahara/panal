cat "$1.req" | ./stdhttpgetfileimagenes > $1.rei
reit=$(dd if="$1.rei" bs=1 count=1 2>/dev/null)
if [ -n "$reit" ];then
	    echo "> > I < <"
	    mv -v "$1.rei" "$1.out"
	    while [ -f "$1.out" ];do
		sleep 0.01
		campo=1
	    done
	    echo "< < I > >"
        rm -v $1.?n $1.re? 
	cuan=$(echo "$1" | ./stdbuscaarg_count "/")
	quita0a=" "
	while [ 0$cuan -gt 0 ];do
	    quita0a="$quita0a | ./stdcdr \$'/' "
	    cuan=$((cuan-1))
	done
	cc=$(echo "echo \"$1\" $quita0a | ./stdcarsin \".sh\" ")
	noo=$(eval $cc )
	kill $noo
fi
rm -v $1.rei
