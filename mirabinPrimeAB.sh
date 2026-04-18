#!/bin/bash
read uno
echo $uno
if [ -z "$uno"  ];then exit 1;fi
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
e="10001"
bitl=$(echo -n "$uno"|$PrPWD/bignum_bitlen)
nbits=$(echo "($bitl/8)" | bc)
nbitsentredos=$(echo "($nbits/2)" | bc)
pasan=1
echo $bitl
vueltas=5
while [ 1 ];do
    n="0";
    echo generating
    nbitsdetestigo=2
    nlendetestigo=$nbits
    while [ 1  ];do
	bbitl=0;
	echo generating
	while [ 0$bbitl -ne $bitl ];do
	    ne=$(dd if=/dev/urandom  bs=1 count=1 2>/dev/null  |  $PrPWD/stdtohex|$PrPWD/stdcarn 1)
	    n=$(echo -n "$n$ne")
	    bbitl=$(echo -n $n|$PrPWD/bignum_bitlen)
	    if [ 0$bbitl -gt $bitl ];then
		n=0
	    fi
	done	
	nand=$(echo -n "$n" | $PrPWD/bignum_cdr | $PrPWD/bignum_and 1)
	if [ -z "$nand" ];then
	    n=$(echo -n "0001+$n" | $PrPWD/bignum_add_m)
	fi
	nq=$(echo $n | $PrPWD/bignum_div $e)
	np=$(echo $nq | $PrPWD/bignum_mul $e)
	nr=$(echo "$n-$np" | $PrPWD/bignum_sub )

	echo testing
	if [ "$nr" = "00000001" ];then continue;fi
	#        MBEDTLS_MPI_CHK( mbedtls_mpi_subpi( &H, &ctx->P, &ctx->Q ) );
	#        if( mbedtls_mpi_bitlen( &H ) <= ( ( nbits >= 200 ) ? ( ( nbits >> 1 ) - 99 ) : 0 ) )
	if [ $(echo -n "$n=$uno" | $PrPWD/bignum_cmp_m ) = ">" ];then
	    H=$(echo -n "$uno-$n" | $PrPWD/bignum_sub )
	else
	    H=$(echo -n "$n-$uno" | $PrPWD/bignum_sub )
	fi
	G=$(echo -n $uno | $PrPWD/bignum_bitlen)
	G=$((G-99))
	if [ $(echo -n $H | $PrPWD/bn2bitlen ) -lt $G ];then continue;else break;fi
    done

    echo generated $n
    primo=$n
    # G C D
    a=$uno
    b=$primo
    cmp3=$(echo "$a=$b"|$PrPWD/bignum_cmp_m)
    if [ "$cmp3" = "<" ];then
	m=$a
	n=$b
    else
	m=$b
	n=$a
    fi
    echo "GCD A B"
    while [ -n "$n" ];do
	coc=$(echo "$m/$n"|$PrPWD/bignum_div)
	temp1=$(echo "$coc*$n"|$PrPWD/bignum_mul)
	r=$(echo "$m-$temp1"|$PrPWD/bignum_sub)
	m=$n
	n=$r
	temp1=$(echo "0$n=0000"|$PrPWD/bignum_cmp_m)
	if [ "$temp1" = "=" ];then break;fi
    done
    gcd=$m
    echo gcd $gcd
    cmp3=$(echo "$gcd=01"|$PrPWD/bignum_cmp_m)
    if [ "$cmp3" = "<" ];then
	paso=1
	pasan=1
	i=64
	pasab=1
	continue
    fi
    ###################################

    #  for ( uint64_t m = n-1; !(m & 1); ++s, m >>= 1 )
    m1=$(echo "$primo-001" | $PrPWD/bignum_sub);
    a=0;
    mm=$(echo "$m1" | $PrPWD/bignum_cdr| $PrPWD/bignum_and 1)
    while [ "$mm" = "0" -o -z "$mm"  ];do
	m1=$(echo "$m1" | $PrPWD/bignum_shiftr ); 
	mm=$(echo "$m1" | $PrPWD/bignum_and 1)
	echo "a:$a"
	v=$((0$a+0001))
	a=$v
    done
    echo s $a mm $mm m1 $m1
    atestigo=$a
    echo -n $n| $PrPWD/bignum_bitlen
    echo "- - - - "
    #  for ( int i = 0; i < k; ++i ) {
    pasan=0
    i=$vueltas
    echo "n=$n"
    nmenosuno=$(echo "$primo-0002"|$PrPWD/bignum_sub)
    while [ $i -gt 0 ];do
	if [ 0$i -eq 1 -a 0$nlendetestigo -gt 2 ];then
	    i=$vueltas
	    nlendetestigo=$((nlendetestigo-1))
	fi
	pasab=0
	a=1
	#    uint$vueltas_t a = rand_between(2, n-2);
	#echo "$a=2" | $PrPWD/bignum_cmp_m
	ac="."
	while [ $ac = "." ];do
	    b=$(dd if=/dev/random bs=1 skip=128 count=$nbits 2>/dev/null | $PrPWD/stdtohex|$PrPWD/stddelcar " " )
	    b=$(echo "$b" | $PrPWD/stdcarn $nlendetestigo)
	    ac=$(echo "0$b=02" | $PrPWD/bignum_cmp_m )
	    if [ $ac != "<" ];then
		ac="."
		continue
	    fi
	    ac=$(echo "0$b=$nmenosuno" | $PrPWD/bignum_cmp_m )
	    if [ $ac != ">" ];then
		ac="."
		continue
	    fi
	done

	# G C D
	testigo=$b
	echo "<< ($nlendetestigo) testigo [$b] >>"
	a=$b
	b=$primo
	cmp3=$(echo "$a=$b"|$PrPWD/bignum_cmp_m)
	if [ "$cmp3" = "<" ];then
	    m=$a
	    n=$b
	else
	    m=$b
	    n=$a
	fi
	echo "GCD n b"
	while [ -n "$n" ];do
	    coc=$(echo "$m/$n"|$PrPWD/bignum_div)
	    temp1=$(echo "$coc*$n"|$PrPWD/bignum_mul)
	    r=$(echo "$m-$temp1"|$PrPWD/bignum_sub)
	    m=$n
	    n=$r
	    cmp3=$(echo "0$n=000"|$PrPWD/bignum_cmp_m)
	    if [ "$cmp3" = "=" ];then break;fi
	done
	gcd=$m
	echo gcd $gcd
	cmp3=$(echo "$gcd=01"|$PrPWD/bignum_cmp_m)

	if [ "$cmp3" = "<" ];then
	    paso=1
	    pasan=1
	    i=$vueltas
	    pasab=1
	    break
	fi
	###################################

	
        r=1
	exponen=$m1
	base=$testigo
	n=$primo

	echo "$base ^$exponen mod $n"
	while [ -n "$exponen" ];do
	    exponenand=$(echo "$exponen" | $PrPWD/bignum_cdr | $PrPWD/bignum_and 1 )
	    if [ "$exponenand" = "00000001" ];then
		#     r=r*a
		r=$(echo "00$r*$base"|$PrPWD/bignum_mul)
		cmp3=$(echo "$r=$n"| $PrPWD/bignum_cmp_m )
		if [ "$cmp3" = "<" ];then
		    coc=$(echo "$r/$n"|$PrPWD/bignum_div)
		    temp1=$(echo "$coc*$n"|$PrPWD/bignum_mul)
		    r=$(echo "$r-$temp1"|$PrPWD/bignum_sub)
		fi
	    fi
	    exponen=$(echo "$exponen" | $PrPWD/bignum_shiftr )
	    base=$(echo -n "$base*$base"|$PrPWD/bignum_mul)
	    cmp3=$(echo "$base=$n"| $PrPWD/bignum_cmp_m )
	    if [ "$cmp3" = "<" ];then
		coc=$(echo -n "$base/$n"|$PrPWD/bignum_div)
		temp1=$(echo -n "$coc*$n"|$PrPWD/bignum_mul)
		base=$(echo -n "$base-$temp1"|$PrPWD/bignum_sub)
	    fi
	done
	base=$r

	echo
	echo "______________________________"
	echo $base
	echo "______________________________"
	
	nmenosuno=$(echo "$primo-0001"|$PrPWD/bignum_sub)

	#If ((z = 1) or (z = w – 1)), then go to step 4.15. (continua)
	cmp3=$(echo "$base=$nmenosuno"|$PrPWD/bignum_cmp_m)
	cmp4=$(echo "$base=001"|$PrPWD/bignum_cmp_m)
	if [ "$cmp3" != "=" -a "$cmp4" != "=" ];then
	    #    for ( int r = 1; r <= s-1; ++r ) {
	    #      x = powod(x, 2, n);
	    rr=1
	    a=$atestigo
	    echo rr $rr s $a
	    while [ $rr -le $((atestigo-1)) ];do
		r=1
		exponen=2
		n=$primo
		while [ -n "$exponen" ];do
		    exponenand=$(echo "$exponen" | $PrPWD/bignum_cdr | $PrPWD/bignum_and 1 )
		    echo  "$exponenand =  00000001" >&2
		    if [ "$exponenand" = "00000001" ];then
			#     r=r*a
			r=$(echo "00$r*$base"|$PrPWD/bignum_mul)
			cmp3=$(echo "$r=$n"| $PrPWD/bignum_cmp_m )
			if [ "$cmp3" = "<" ];then
			    coc=$(echo "$r/$n"|$PrPWD/bignum_div)
			    temp1=$(echo "$coc*$n"|$PrPWD/bignum_mul)
			    r=$(echo "$r-$temp1"|$PrPWD/bignum_sub)
			fi
		    fi
		    exponen=$(echo "$exponen" | $PrPWD/bignum_shiftr )
		    base=$(echo -n "$base*$base"|$PrPWD/bignum_mul)
		    cmp3=$(echo "$base=$n"| $PrPWD/bignum_cmp_m )
		    if [ "$cmp3" = "<" ];then
			coc=$(echo -n "$base/$n"|$PrPWD/bignum_div)
			temp1=$(echo -n "$coc*$n"|$PrPWD/bignum_mul)
			base=$(echo -n "$base-$temp1"|$PrPWD/bignum_sub)
		    fi
		    echo -n .
		done
		base=$r


		#If (z = 1), then go to step 4.12. (rompe)
		cmp3=$(echo "$base=001"| $PrPWD/bignum_cmp_m )
		if [ "$cmp3" = "=" ];then
		    rr=$((atestigo+3))
		    i=$vueltas
		    break;
		fi
		
		#If (z = w–1), then go to step 4.15. (continua)
		#de lo contrario rompe
		cmp4=$(echo "$base=$nmenosuno"| $PrPWD/bignum_cmp_m )
		if [ "$cmp4" = "=" ];then
		    rr=0
		    break;
		fi
		xn=$n
		rr=$((rr+1))
	    done
	    if [ 0$rr -gt 0 ];then
		pasan=1
		rr=$((atestigo+3))
		i=$vueltas
		break
	    fi

	    if [ $rr -lt $((atestigo+2)) ];then
		#Comment: x = b (w–1)/2 mod w and x ≠ w–1.
		xx=$base

		#z = x^2 mod w
		r=1
		exponen=2
		n=$primo
		while [ -n "$exponen" ];do
		    exponenand=$(echo "$exponen" | $PrPWD/bignum_cdr | $PrPWD/bignum_and 1 )
		    echo  "$exponenand =  00000001" >&2
		    if [ "$exponenand" = "00000001" ];then
			#     r=r*a
			r=$(echo "00$r*$base"|$PrPWD/bignum_mul)
			cmp3=$(echo "$r=$n"| $PrPWD/bignum_cmp_m )
			if [ "$cmp3" = "<" ];then
			    coc=$(echo "$r/$n"|$PrPWD/bignum_div)
			    temp1=$(echo "$coc*$n"|$PrPWD/bignum_mul)
			    r=$(echo "$r-$temp1"|$PrPWD/bignum_sub)
			fi
		    fi
		    exponen=$(echo "$exponen" | $PrPWD/bignum_shiftr )
		    base=$(echo -n "$base*$base"|$PrPWD/bignum_mul)
		    cmp3=$(echo "$base=$n"| $PrPWD/bignum_cmp_m )
		    if [ "$cmp3" = "<" ];then
			coc=$(echo -n "$base/$n"|$PrPWD/bignum_div)
			temp1=$(echo -n "$coc*$n"|$PrPWD/bignum_mul)
			base=$(echo -n "$base-$temp1"|$PrPWD/bignum_sub)
		    fi
		done
		base=$r

		cmp2=$(echo "$base=001"|$PrPWD/bignum_cmp_m)
		#If (z = 1), then go to step 4.12. (rompe)
		if [ "$cmp2" = "=" ];then
		    rr=$((atestigo+3))
		    break
		fi
		xx=$base
	    fi

	    if [ 0$rr -lt $((atestigo+2)) ];then
	    # G C D
	    a=$(echo -n "$xx-001"| $PrPWD/bignum_sub )
	    b=$primo
	    cmp3=$(echo "$a=$b"|$PrPWD/bignum_cmp_m)
	    if [ "$cmp3" = "<" ];then
		m=$a
		n=$b
	    else
		m=$b
		n=$a
	    fi
	    m2=$m
	    n2=$n
	    echo "GCD x-1 n"
	    while [ -n "$n" ];do
		coc=$(echo "$m/$n"|$PrPWD/bignum_div)
		temp1=$(echo "$coc*$n"|$PrPWD/bignum_mul)
		r=$(echo "$m-$temp1"|$PrPWD/bignum_sub)
		m=$n
		n=$r
		cmp3=$(echo "0$n=000"|$PrPWD/bignum_cmp_m)
		if [ "$cmp3" = "=" ];then break;fi
	    done
	    gcd=$m
	    echo gcd $gcd
	    cmp3=$(echo "$gcd=01"|$PrPWD/bignum_cmp_m)

	    if [ "$cmp3" = "<" ];then
		paso=1
		pasan=1
		i=$vueltas
		pasab=1
		break
	    fi
	    ###################################
	    fi
	    
	    if [ $rr -ge $((atestigo+1)) ];then
		i=$vueltas
		pasan=1
		pasab=1
		paso=1
		break
	    fi
	fi
	if [ 0$pasan -eq 1 ];then
	    i=$vueltas
	    break
	fi
	i=$((i-1))
	echo "rr es $rr de $atestigo"
	echo segun py cn este testigo es
	pythontestigo=$(echo "ibase=16;$testigo"|bc|tr -d '\\'|tr -d '\n' 2>&1)
	pythonn=$(echo "ibase=16;$primo"|bc|tr -d '\\'|tr -d '\n' 2>&1)
	echo "n=$pythonn t=$pythontestigo"
	python $PrPWD/millerrabin.py $pythonn $pythontestigo
	echo segun py es
	python $PrPWD/millerrabin.py $n
	echo iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
	echo $i $nlendetestigo pasan $pasan 
	echo iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
	echo pasan $paso pasab $pasab
	echo $x = $m1
    done
    if [ 0$pasan -eq 0 ];then
	echo "A=$uno"
	echo "B=$primo"
	break
    fi
done
