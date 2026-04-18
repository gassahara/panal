#!/bin/bash
e="10001"
bitl=1024
nbits=$(echo "($bitl/8)" | bc)
pasan=1
while [ $pasan -eq 1 ];do
    n=1;
    while [ 1  ];do
	n=$(dd if=/dev/urandom  bs=1 count=$nbits skip=$nbits 2>/dev/null  |  hexdump -v -e '/1 "%02X"')
	nand=$(echo $n | ./bn2cdr | ./bn2and 1)
	if [ -z "$nand" ];then
	    n=$(echo "$n" | ./bn2add 1)
	fi
	nq=$(echo $n | ./bn2div $e)
	np=$(echo $nq | ./bn2mul $e)
	nr=$(echo $n | ./bn2sub $np)
	if [ "$nr" = "00000001" ];then continue;fi
	if [ $(echo $n | ./bn2bitlen ) -eq $bitl ];then break;fi
    done

    #  for ( uint64_t m = n-1; !(m & 1); ++s, m >>= 1 )
    m1=$(echo "$n" | ./bn2sub 1);
    s=0;
    mm=$(echo "$m1" | ./bn2and 1)
    while [ "$mm" = "0" -o -z "$mm"  ];do
	m1=$(echo "$m1" | ./bn2shiftr ); #./bn2div 2
	mm=$(echo "$m1" | ./bn2and 1)
	s=$((s+1));
    done
    
    #  for ( int i = 0; i < k; ++i ) {
    pasan=0
    i=12
    while [ $i -gt 0 ];do
	pasab=0
	a=1
	nm2=$(echo "$n" | ./bn2sub 1 );
	#    uint64_t a = rand_between(2, n-2);
	while [ $(echo $a | ./bn2cmp "2" ) -lt 1 ];do
	    a=$(dd if=/dev/urandom bs=1 count=$nbits skip=$(echo "$nbits/2" | bc) 2>/dev/null |  hexdump -v -e '/1 "%02X"' )
	    square=$(echo $a | ./bn2mul $a)
	    if [ $(echo $square | ./bn2cmp $n) -lt 1 ];then
		a=1
	    fi
	done
	echo "a=$a ($i)" 1>&2
	#  uint64_t x = pow_mod(a,d,n);
	#  uint64_t r=1;

	r=1
	aa=$a
	x=$m1
	divisor=$(echo -n "$n" | ./bn2sub 1);
	while [ -n "$x" ];do
	    xand=$(echo "$x" | ./bn2cdr | ./bn2and 1 )
	    if [ "$xand" = "00000001" ];then
		r=$(echo $r | ./bn2mul $aa)
		if [ $(echo $r | ./bn2cmp $divisor) -gt 0 ];then
		    divid=$r
		    #   c              a         /        b
		    cociente=$(echo $divid | ./bn2div $divisor )
		    #  t              b          *        c
		    resto1=$(echo $divisor | ./bn2mul $cociente )
		    #        a         -        t
		    r=$(echo 0$divid | ./bn2sub 0$resto1)
		fi
	    fi
	    aa=$(echo $aa | ./bn2mul $aa )
	    if [ $(echo $aa | ./bn2cmp $c) -gt 0 ];then
		divid=$aa
		#   c              a         /        b
		cociente=$(echo $divid | ./bn2div $divisor )
		#  t              b          *        c
		resto1=$(echo $divisor | ./bn2mul $cociente )
		#            a         -        t
		aa=$(echo $divid | ./bn2sub 0$resto1 )
	    fi
	    x=$(echo "$x" | ./bn2shiftr ) #./bn2div 2)
	    if [ -z "$x" ];then
		break
	    fi
	    #echo -n "." #c=${#c} cociente=${#cociente} resto1=${#resto1} aa=${#aa}"
	done
	x=$r

	paso=0
	m1=$(echo "$n" | ./bn2sub 1);
	if [ "$x" = "1" -o "$x" = "$m1" ];then
	    paso=1
	    pasan=1
	    i=12
	    pasab=1
	    break
	fi
	if [ 0$paso -eq 0 ];then
	    #    for ( int r = 1; r <= s-1; ++r ) {
	    #      x = pow_mod(x, 2, n);
	    rr=1
	    while [ $rr -le $((s-1)) ];do
		r=1
		aa=$x
		x=2
		divisor=$n;
		while [ -n "$x" ];do
		    xand=$(echo "$x" | ./bn2cdr | ./bn2and 1 )
		    if [ "$xand" = "00000001" ];then
			r=$(echo $r | ./bn2mul $aa)
			if [ $(echo $r | ./bn2cmp $divisor) -gt 0 ];then
			    divid=$r
			    #   c              a         /        b
			    cociente=$(echo $divid | ./bn2div $divisor )
			    #  t              b          *        c
			    resto1=$(echo $divisor | ./bn2mul $cociente )
			    #        a         -        t
			    r=$(echo 0$divid | ./bn2sub 0$resto1)
			fi
		    fi
		    aa=$(echo $aa | ./bn2mul $aa )
		    if [ $(echo $aa | ./bn2cmp $c) -gt 0 ];then
			divid=$aa
			#   c              a         /        b
			cociente=$(echo $divid | ./bn2div $divisor )
			#  t              b          *        c
			resto1=$(echo $divisor | ./bn2mul $cociente )
			#            a         -        t
			aa=$(echo $divid | ./bn2sub 0$resto1 )
		    fi
		    x=$(echo "$x" | ./bn2shiftr ) #./bn2div 2)
		    if [ -z "$x" ];then
			break
		    fi
		    #echo -n "--" #c=${#c} cociente=${#cociente} resto1=${#resto1} aa=${#aa}"
		done
		x=$r
		if [ "$x" = "1" ];then
		    echo "0"
		    rr=$((s+1))
		    pasan=1
		    pasab=1
		    i=12
		    break
		fi
		#      if ( x == n - 1 ) goto LOOP;
		xn=$(echo $n | ./bn2sub 1)
		if [ "$xn" = "$x" ];then
		    rr=$((s+1))
		fi
		rr=$((rr+1))
	    done
	    if [ $rr -ge $((s+1)) ];then
		i=12
		pasan=1
		pasab=1
		break
	    fi
	fi
	i=$((i-1))
    done
    echo "$n"
done
