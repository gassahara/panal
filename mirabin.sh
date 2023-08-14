#!/bin/bash
e="10001"
bitl=1024
nbits=$(echo "($bitl/8)" | bc)
echo "nbits=$nbits"
pasab=1
while [ $pasab -gt 0 ];do
    pasan=1
    pasab=0
    while [ $pasan -eq 1 -a ! -f primeA ];do
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
	    if [ "$n" = "00000001" ];then n=1;fi
	    if [ $(echo $n | ./bn2bitlen ) -eq $bitl ];then break;fi
	done
	echo "n=[$n]"

	#  for ( uint64_t m = n-1; !(m & 1); ++s, m >>= 1 )
	m1=$(echo "$n" | ./bn2sub 1);
	s=0;
	mm=$(echo "$m1" | ./bn2and 1)
	while [ "$mm" = "0" -o -z "$mm"  ];do
	    m1=$(echo "$m1" | ./bn2shiftr ); #./bn2div 2
	    mm=$(echo "$m1" | ./bn2and 1)
	    s=$((s+1));
	done
	echo "$m1 $s:"
	
	#  for ( int i = 0; i < k; ++i ) {
	pasan=0
	i=12
	while [ $i -gt 0 ];do
	    pasab=0
	    a=1
	    nm2=$(echo "$n" | ./bn2sub 1 );
	    #    uint64_t a = rand_between(2, n-2);
	    while [ $(echo $a | ./bn2cmp "2" ) -lt 1 ];do
		a=$(dd if=/dev/urandom bs=1 count=$(echo "$nbits/2" | bc) 2>/dev/null |  hexdump -v -e '/1 "%02X"' )
		square=$(echo $a | ./bn2mul $a)
		if [ $(echo $square | ./bn2cmp $n) -lt 1 ];then
		    a=1
		fi
	    done
	    echo "a=$a"
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
		echo -n "." #c=${#c} cociente=${#cociente} resto1=${#resto1} aa=${#aa}"
	    done
	    x=$r
	    echo
	    echo "P ($i) << $x >>"

	    paso=0
	    m1=$(echo "$n" | ./bn2sub 1);
	    if [ "$x" = "1" -o "$x" = "$m1" ];then
		paso=1
		pasan=1
		echo " n=$n"
		echo " x=$x"
		echo "xn=$divisor"
		echo "0"
		i=12
		pasab=1
		break
	    fi
	    if [ 0$paso -eq 0 ];then
		#    for ( int r = 1; r <= s-1; ++r ) {
		#      x = pow_mod(x, 2, n);
		rr=1
		echo "rr $rr s $s"
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
			echo -n "--" #c=${#c} cociente=${#cociente} resto1=${#resto1} aa=${#aa}"
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
	echo "P                 $n "
	echo "pasan=$pasan i $i "
	P=$n
    done
    if [  ! -f primeA ];then echo "$n" > primeA;fi
    P=$(cat primeA)

    pasan=1
    pasab=0
    G=2
    while [ $pasan -eq 1 -a ! -f primeB ];do
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
	    if [ "$n" = "00000001" ];then n=1;fi
	    if [ $(echo $n | ./bn2bitlen ) -eq $bitl ];then break;fi
	done
	Q=$n
	if [ $(echo "$Q" | ./bn2cmp "$P") -gt 0 ];then
	    P1=$Q
	    Q=$P
	    P=$P1
	fi
	#        MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &H, &ctx->P, &ctx->Q ) );
	#        if( mbedtls_mpi_bitlen( &H ) <= ( ( nbits >= 200 ) ? ( ( nbits >> 1 ) - 99 ) : 0 ) )
	H=$(echo $P | ./bn2sub $Q )
	G=$(echo "obase=16;$bitl" | bc | ./bn2shiftr 1)
	G=$(echo $G | ./bn2sub 63 | ./bn2cdrd)
	if [ $(echo $H | ./bn2bitlen ) -lt $G ];then pasab=1;pasan=1;continue;fi
	H=$(echo $P | ./bn2mul $Q )
	P=$(echo $P | ./bn2sub 1)
	Q=$(echo $Q | ./bn2sub 1)
	G=$(./bn2gcd $P $Q)
	L=$(echo $H | ./bn2div $G)
	P=$(echo $P | ./bn2add 1)
	Q=$(echo $Q | ./bn2add 1)
	echo "P1 = $P1"
	echo "Q1=$Q1"
	echo "H=$H"
	echo "G=$G"
	echo "L=$L"
	pasan=1
	iii=0
	#/*
	#Y^-1 mod X X->M Y->A
	# * Modular inverse: X = A^-1 mod M  (HAC 14.61 / 14.64)
	# */
	Y=$e
	X=$L
	g=1

	#/*
	#Y^-1 mod X X->M Y->A
	# * Modular inverse: X = A^-1 mod M  (HAC 14.61 / 14.64)
	# */
	# int mul_inv(int a, int b)
	# {
	#     int b0 = b, t, q;
	#     int x0 = 0, x1 = 1;
	#     if (b == 1) return 1;
	#        while (a > 1) {
	# 		 q = a / b;
	# 		 t = b, b = a % b, a = t;
	# 		 t = x0, x0 = x1 - q * x0, x1 = t;
	# 	     }
	# 	     if (x1 < 0) x1 += b0;
	# 		return x1;
	# }
	r=$X
	t=0
	newt=1
	newr=$Y
	pasab=0
	while [ 1 ];do
	    quotient=$(echo $r | ./bn2div $newr)
	    if [ $(echo $r | ./bn2cmp $newr) -lt 0 ];then quotient=$r;fi
	    temporal=$newt
	    newt1=$(echo $quotient | ./bn2mul $newt)
	    newt=$(echo $t | ./bn2sub $newt1)
	    if [ 0$signot -eq 0 -a $(echo $t | ./bn2cmp $newt1) -lt 0 ];then
		signot=1
		newt=$(echo $newt1 | ./bn2sub $t)
	    fi
	    if [ 0$signot -eq 1 ];then
		newt=$(echo $newt1 | ./bn2add $t)
	    fi
	    t=$temporal
	    temporal=$newr
	    newr1=$(echo $quotient | ./bn2mul $newr)
	    newr=$(echo $r | ./bn2sub $newr1)
	    if [ $(echo $r | ./bn2cmp $newr1) -lt 0 ];then
		signor=1
		newr=$(echo $newr1 | ./bn2sub $r)
	    fi
	    r=$temporal
	    if [ -z "$newr" ];then break;fi
	done
	if [ $(echo $r | ./bn2cmp 1) -gt 0 ];then echo "NO INV";pasab=1;pasan=1;continue;fi
	if [ 0$signot -eq 1 ];then
	    while [ $(echo $t | ./bn2cmp $X) -ge 0 ];do
		t=$(echo $t | ./bn2sub $X)
	    done
	    t=$(echo $X | ./bn2sub $t); 
	fi
	D=$t
	g1=$(echo $t | ./bn2mul $e)
	gq=$(echo $g1 | ./bn2div $L)
	gr=$(echo $gq | ./bn2mul $L)
	echo $gr
	g2=$(echo $g1 | ./bn2sub $gr)
	echo "d*e%u ($t * $e) % $L = $g2 ${#g2}"
	if [ "$g2" != "00000001" ];then pasab=1;pasan=1;continue;fi
	echo "n=[$n]"
	#  for ( uint64_t m = n-1; !(m & 1); ++s, m >>= 1 )
	m1=$(echo "$n" | ./bn2sub 1);
	s=0;
	mm=$(echo "$m1" | ./bn2and 1)
	while [ "$mm" = "0" -o -z "$mm"  ];do
	    m1=$(echo "$m1" | ./bn2shiftr ); #./bn2div 2
	    mm=$(echo "$m1" | ./bn2and 1)
	    s=$((s+1));
	    echo "$m1 $s:"
	done
	
	#  for ( int i = 0; i < k; ++i ) {
	pasan=0
	i=12
	while [ $i -gt 0 ];do
	    pasab=0
	    a=1
	    nm2=$(echo "$n" | ./bn2sub 1 );
	    #    uint64_t a = rand_between(2, n-2);
	    while [ $(echo $a | ./bn2cmp "2" ) -lt 1  ];do
		a=$(dd if=/dev/urandom bs=1 skip=$nbits count=$(echo "$nbits/2" | bc) 2>/dev/null |  hexdump -v -e '/1 "%02X"' )
		square=$(echo $a | ./bn2mul $a)
		if [ $(echo $square | ./bn2cmp $n) -lt 1 ];then
		    a=1
		fi
	    done
	    echo "a=$a"
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
		echo -n "." #c=${#c} cociente=${#cociente} resto1=${#resto1} aa=${#aa}"
	    done
	    x=$r
	    echo
	    echo "Q $i ___________ << $x >>"

	    paso=0
	    m1=$(echo "$n" | ./bn2sub 1);
	    if [ "$x" = "1" -o "$x" = "$m1" ];then
		paso=1
		pasan=1
		echo " n=$n"
		echo " x=$x"
		echo "xn=$divisor"
		echo "0"
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
			echo -n "." #c=${#c} cociente=${#cociente} resto1=${#resto1} aa=${#aa}"
		    done
		    x=$r
		    #		    echo "       $i -----------------    $x --------------------------------"
		    #      if ( x == 1 ) return false;
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
	echo "Q                 $n "
	echo "pasan=$pasan i $i "
	Q=$n
    done
    if [  ! -f primeB ];then echo "$n" > primeB;fi
    Q=$(cat primeB)
done
pasan=0

H=$(echo $P | ./bn2mul $Q )
P=$(echo $P | ./bn2sub 1)
Q=$(echo $Q | ./bn2sub 1)
G=$(./bn2gcd $P $Q)
L=$(echo $H | ./bn2div $G)
	echo "P=$P"
	echo "Q=$Q"
	echo "H=$H"
	echo "G=$G"
	echo "L=$L"
sleep 5
Y=$e
X=$L
g=1

#/*
#Y^-1 mod X X->M Y->A
# * Modular inverse: X = A^-1 mod M  (HAC 14.61 / 14.64)
# */
# int mul_inv(int a, int b)
# {
#     int b0 = b, t, q;
#     int x0 = 0, x1 = 1;
#     if (b == 1) return 1;
#        while (a > 1) {
# 		 q = a / b;
# 		 t = b, b = a % b, a = t;
# 		 t = x0, x0 = x1 - q * x0, x1 = t;
# 	     }
# 	     if (x1 < 0) x1 += b0;
# 		return x1;
# }
r=$X
t=0
newt=1
newr=$Y
pasab=0
while [ 1 ];do
    quotient=$(echo $r | ./bn2div $newr)
    if [ $(echo $r | ./bn2cmp $newr) -lt 0 ];then quotient=$r;fi
    temporal=$newt
    newt1=$(echo $quotient | ./bn2mul $newt)
    newt=$(echo $t | ./bn2sub $newt1)
    if [ 0$signot -eq 0 -a $(echo $t | ./bn2cmp $newt1) -lt 0 ];then
	signot=1
	newt=$(echo $newt1 | ./bn2sub $t)
    fi
    if [ 0$signot -eq 1 ];then
	newt=$(echo $newt1 | ./bn2add $t)
    fi
    t=$temporal
    temporal=$newr
    newr1=$(echo $quotient | ./bn2mul $newr)
    newr=$(echo $r | ./bn2sub $newr1)
    if [ $(echo $r | ./bn2cmp $newr1) -lt 0 ];then
	signor=1
	newr=$(echo $newr1 | ./bn2sub $r)
    fi
    r=$temporal
    if [ -z "$newr" ];then break;fi
done
if [ $(echo $r | ./bn2cmp 1) -gt 0 ];then echo "NO INV";pasab=1;pasan=1;continue;fi
if [ 0$signot -eq 1 ];then
    while [ $(echo $t | ./bn2cmp $X) -ge 0 ];do
	t=$(echo $t | ./bn2sub $X)
    done
    t=$(echo $X | ./bn2sub $t); 
fi
D=$t

echo "H=$H ${#H}"
echo "E=$e"
echo "D=$D ${#D}"
da=$(date +%Y%m%d%H%M%S%s%N)
echo "$H" > H$da.hkey
echo "$e" > E$da.ekey
echo "$D" > D$da.dkey

echo "$L" > U$da.ukey
pasab=0
read
