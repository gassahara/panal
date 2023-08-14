reit=$(cat "$1.req" | ./stdhttpgetfilehtml )
if [ -z "$reit" ];then
    reit=$(cat "$1.req" | ./stdhttpgetfileimagenes )
    if [ -z "$reit" ];then
	echo "BB $1 "
	cat "$1.req" | ./stdhttpgetfilehtml
	cat "$1.in" | ./stdhttprange > "$1.rer"
	rer=$(dd if="$1.rer" bs=1 count=1 2>/dev/null)
	if [ -z "$rer" ];then
	    cat "$1.req" | ./stdhttpgetfileoctect > "$1.reb"
	else
	    cat "$1.req" "$1.rer" | ./stdhttpgetfileoctect-range > "$1.reb"		    
	fi

	reit=$(dd if="$1.reb" bs=1 count=1 2>/dev/null)
	if [ -n "$reit" ];then
	    mv -v "$1.reb" "$1.out"
	    echo "BINARIO"
	    cat "$1.req"	    
	fi
	rm -v $1.?n $1.re?

	    cuan=$(echo "$1" | ./stdbuscaarg_count "/")
	    quita0a=" "
	    while [ 0$cuan -gt 0 ];do
		quita0a="$quita0a | ./stdcdr \$'/' "
		cuan=$((cuan-1))
	    done
	    cc=$(echo "echo \"$1\" $quita0a ")
	    noo=$(eval $cc )
	kill $noo
    fi
fi
