cat "$1.req" | ./stdhttpgetfilehtml > "$1.r2t"
reit=$(dd if=$1.r2t  bs=2 count=1 2>/dev/null)
if [ -n "$reit" ];then
    rec=$(cat "$1.in" | ./stdhttpcontent)
    if [ -z "$rec" ];then
	echo "TEXTO 2 > $1 <"
	echo "******"
	rm $1.in $1.req
	mv -v "$1.r2t" "$1.out"
	while [ -f "$1.out" ];do
	    sleep 0.01
	    campo=1
	done
	echo "--------------"
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
	echo "%%%%%%%%%"
    fi
fi
