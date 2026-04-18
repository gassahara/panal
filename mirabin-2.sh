#!/bin/bash
e=1
nbits=1
while [ $(echo $e | ./bn2bitlen ) -lt 512 ];do
    e=$(dd if=/dev/urandom bs=1 count=$nbits 2>/dev/null |  hexdump -v -e '/1 "%02X"')
    nbits=$(($nbits+1))
done
echo $nbits
while [ $(echo 2 | ./bn2pow 256 | ./bn2cmp "$e") -le 0 -o $(echo 2 | ./bn2pow 16 | ./bn2cmp "$e") -ge 0 -o -n "$(echo $e | ./bn2and )" ];do
    e=$(dd if=/dev/urandom bs=$nbits count=1 2>/dev/null |  hexdump -v -e '/1 "%02X"')
    echo 2 | ./bn2pow 256 | ./bn2cmp "$e"
    echo "2^256>E"
    echo 2 | ./bn2pow 16 | ./bn2cmp "$e"
    echo "2^16<E"
    echo $e | ./bn2and 
    echo "E IMPAR"
    echo "e = $e"
    if [  -n "$(echo $e | ./bn2and )" ];then
	e=$(echo "$e" | ./bn2add)
    fi
done
echo "$e" > primeE
nbits2=$(echo $nbits | ./bn2shiftr )
nbits2=$(echo $nbits2 | ./bn2cdrd )
echo $nbits2
pasab=1
while [ $pasab -gt 0 ];do
    pasan=1
    while [ $pasan -eq 1 ];do
	pasan=0
	n=$(dd if=/dev/urandom  bs=$nbits2 count=1 2>/dev/null  |  hexdump -v -e '/1 "%02X"')
	echo "n=$n"
	if [ -z "$(echo "$n" | ./bn2and )" ];then
	    n=$(echo "$n" | ./bn2add )
	fi

	#  for ( uint64_t m = n-1; !(m & 1); ++s, m >>= 1 )
	d=$(echo "$n" | ./bn2sub );
	s=0;
	mm=$(echo "$d" | ./bn2and )
	while [ "$mm" = "0" -o -z "$mm"  ];do
	    d=$(echo "$d" | ./bn2div 2 );
	    mm=$(echo "$d" | ./bn2and )
	    s=$((s+1));
	    echo -e "\n$d $s:" ;
	done
	
	#  for ( int i = 0; i < k; ++i ) {
	i=8
	while [ $i -gt 0 ];do
	    a=1
	    nm2=$(echo "$n" | ./bn2sub 2 );
	    #    uint64_t a = rand_between(2, n-2);
	    ccount=4 #$(echo " ${#1}/4" | bc )
	    while [ $(echo $a | ./bn2cmp "2" ) -lt 1 -o $(echo $nm2 | ./bn2cmp "$a" ) -lt 0  ];do
		a=$(dd if=/dev/urandom bs=2 count=$ccount 2>/dev/null |  hexdump -v -e '/1 "%02X"' )
	    done
	    #    uint64_t x = pow_mod(a,d,n);
	    #  uint64_t r=1;

	    r=1
	    aa=$a
	    x=$d
	    c=$(echo "$n" | ./bn2sub );
	    while [ -n "$x" -a "$x" != "0" ];do
		#    if ( (x & 1) == 1 )
		xand=$(echo "$x" | ./bn2cdr | ./bn2and )
		if [ "$xand" = "1" ];then
		    r=$(echo "$r" | ./bn2mul "$aa")
		    r2=$(echo "$r" | ./bn2div "$c" | ./bn2mul "$r" )
		    r=$(echo "$c" | ./bn2sub "$r2" )
		fi
		aa=$(echo "$aa" | ./bn2mul "$aa" )
		r2=$(echo "$aa" | ./bn2div "$c" | ./bn2mul "$aa" )
		aa=$(echo "$c" | ./bn2sub "$aa" )
		x=$(echo "$x" | ./bn2div 2)
		echo -n "."
	    done
	    x=$r
	    echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx                         $x"

	    #    echo "$a ^ $d" 
	    #    x=$(echo "$a" | ./bn2pow "$d" | ./bn2div "$1")
	    #    echo "= $x"     
	    #    r2=$(echo "$x" | ./bn2div "$1" | ./bn2mul "$x" )
	    #    x=$(echo "$1" | ./bn2sub "$x")
	    #    echo " ...         ..               >>>    $x "

	    paso=0
	    if [ "$x" = "1" -o "$x" = "$(echo "$n" | ./bn2sub)" ];then
		paso=1
		pasan=1
		echo "0"
		i=9
		break
	    fi
	    if [ $paso -eq 0 ];then
		#    for ( int r = 1; r <= s-1; ++r ) {
		#      x = pow_mod(x, 2, n);
		rr=1
		while [ $rr -le $((s-1)) ];do

		    r=1
		    aa=$x
		    x=$2
		    c=$1;
		    while [ -n "$x" -a "$x" != "0" ];do
			#    if ( (x & 1) == 1 )
			xand=$(echo "$x" | ./bn2and )
			if [ "$xand" = "1" ];then
			    r=$(echo "$r" | ./bn2mul "$aa")
			    r2=$(echo "$r" | ./bn2div "$c" | ./bn2mul "$r" )
#			    echo "r2=$r2"
			    r=$(echo "$c" | ./bn2sub "$r2" )
#			    echo "r*a%n=$r"
			fi
			aa=$(echo "$aa" | ./bn2mul "$aa" )
			r2=$(echo "$aa" | ./bn2div "$c" | ./bn2mul "$aa" )
			aa=$(echo "$c" | ./bn2sub "$aa" )
			x=$(echo "$x" | ./bn2div 2)
#			echo "x=$x"
		    done
		    x=$r
		    echo "        -----------------    $x --------------------------------"
		    #      if ( x == 1 ) return false;
		    if [ "$x" = "1" ];then
			echo "0"
			rr=$((s+1))
			pasan=1
			i=9
			break
		    fi
		    #      if ( x == n - 1 ) goto LOOP;	    
		    if [ "$(echo "$n" | ./bn2sub )" = "$x" ];then
			rr=$((s+1))
		    fi
		    rr=$((rr+1))
		done
		if [ $rr -ge $((s+1)) ];then
		    i=9
		    break
		fi
	    fi
	    i=$((i-1))
	done
	echo "NNNNNNNNNN                 $n "
	P=$n
    done

    echo "$n" > primeA
    pasan=1
    while [ $pasan -eq 1 ];do
	pasan=0
	n=$(dd if=/dev/urandom  bs=$nbits2 count=1 2>/dev/null  |  hexdump -v -e '/1 "%02X"')
	if [ -z "$(echo "$n" | ./bn2and )" ];then
	    n=$(echo "$n" | ./bn2add )
	fi
	echo "n=$n"

	#  for ( uint64_t m = n-1; !(m & 1); ++s, m >>= 1 )
	d=$(echo "$n" | ./bn2sub );
	s=0;
	mm=$(echo "$d" | ./bn2and )
	while [ "$mm" = "0" -o -z "$mm"  ];do
	    d=$(echo "$d" | ./bn2div 2 );
	    mm=$(echo "$d" | ./bn2and )
	    s=$((s+1));
	    echo -e "\n$d $s:" ;
	done
	
	#  for ( int i = 0; i < k; ++i ) {
	i=8
	while [ $i -gt 0 ];do
	    a=1
	    nm2=$(echo "$n" | ./bn2sub 2 );
	    #    uint64_t a = rand_between(2, n-2);
	    ccount=4 #$(echo " ${#1}/4" | bc )
	    while [ $(echo $a | ./bn2cmp "2" ) -lt 1 -o $(echo $nm2 | ./bn2cmp "$a" ) -lt 0  ];do
		#	echo ${#1}
		a=$(dd if=/dev/urandom bs=1 count=$ccount 2>/dev/null |  hexdump -v -e '/1 "%02X"' )
	    done
	    echo ">>$a<<"
	    #    uint64_t x = pow_mod(a,d,n);
	    #  uint64_t r=1;

	    r=1
	    aa=$a
	    x=$d
	    c=$(echo "$n" | ./bn2sub );
	    while [ -n "$x" -a "$x" != "0" ];do
		#    if ( (x & 1) == 1 )
		xand=$(echo "$x" | ./bn2and )
		if [ "$xand" = "1" ];then
		    r=$(echo "$r" | ./bn2mul "$aa")
		    r2=$(echo "$r" | ./bn2div "$c" | ./bn2mul "$r" )
		    #echo "r2=$r2"
		    r=$(echo "$c" | ./bn2sub "$r2" )
		    #echo "r*a%n=$r"
		fi
		aa=$(echo "$aa" | ./bn2mul "$aa" )
		r2=$(echo "$aa" | ./bn2div "$c" | ./bn2mul "$aa" )
		aa=$(echo "$c" | ./bn2sub "$aa" )
		x=$(echo "$x" | ./bn2div 2)
		#echo "x=$x"
#		echo $i
#		echo "x=$x" | wc -c
	    done
	    x=$r
#	    echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx                         $x"

	    #    echo "$a ^ $d" 
	    #    x=$(echo "$a" | ./bn2pow "$d" | ./bn2div "$1")
	    #    echo "= $x"     
	    #    r2=$(echo "$x" | ./bn2div "$1" | ./bn2mul "$x" )
	    #    x=$(echo "$1" | ./bn2sub "$x")
	    #    echo " ...         ..               >>>    $x "

	    pasa=0
	    if [ "$x" = "1" -o "$x" = "$(echo "$n" | ./bn2sub)" ];then
		pasa=1
		pasan=1
		echo "0"
		i=9
		break
	    fi
	    if [ $pasa -eq 0 ];then
		#    for ( int r = 1; r <= s-1; ++r ) {
		#      x = pow_mod(x, 2, n);
		rr=1
		while [ $rr -le $((s-1)) ];do

		    r=1
		    aa=$x
		    x=$2
		    c=$1;
		    while [ -n "$x" -a "$x" != "0" ];do
			#    if ( (x & 1) == 1 )
			xand=$(echo "$x" | ./bn2and )
			if [ "$xand" = "1" ];then
			    r=$(echo "$r" | ./bn2mul "$aa")
			    r2=$(echo "$r" | ./bn2div "$c" | ./bn2mul "$r" )
#			    echo "r2=$r2"
			    r=$(echo "$c" | ./bn2sub "$r2" )
			    #echo "r*a%n=$r"
			fi
			aa=$(echo "$aa" | ./bn2mul "$aa" )
			r2=$(echo "$aa" | ./bn2div "$c" | ./bn2mul "$aa" )
			aa=$(echo "$c" | ./bn2sub "$aa" )
			x=$(echo "$x" | ./bn2div 2)
#			echo "x=$x"
		    done
		    x=$r
#		    echo "        -----------------    $x --------------------------------"
		    #      if ( x == 1 ) return false;
		    if [ "$x" = "1" ];then
			echo "0"
			pasan=1
			rr=$((s+1))
			break
		    fi
		    #      if ( x == n - 1 ) goto LOOP;	    
		    if [ "$(echo "$n" | ./bn2sub )" = "$x" ];then
			rr=$((s+1))
		    fi
		    rr=$((rr+1))
		done
		if [ $rr -ge $((s+1)) ];then
		    i=9
		    pasan=1
		    break
		fi
	    fi
	    i=$((i-1))
	done
	echo "NNNNNNNNNN                 $n "
	Q=$n
    done
    echo "$n" > primeB
    #        MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &H, &ctx->P, &ctx->Q ) );
    #        if( mbedtls_mpi_bitlen( &H ) <= ( ( nbits >= 200 ) ? ( ( nbits >> 1 ) - 99 ) : 0 ) )
    H=$(echo "$P" | ./bn2sub "$Q")
    bitlen=$(echo "$H" | ./bn2bitlen )
    nbl=$(echo -n "$nbits " ./bn2shiftr 1 | ./bn2sub 99 )
#    if [ "$H" -le $nbl ];then
#	continue
#    else
	pasab=0
#    fi

    if [ $(echo "$Q" | ./bn2cmp "$P") -gt 0 ];then
	P1=$Q
	Q=$P
	P=$P1
    fi
    P1=$(echo "$P" | ./bn2sub 1 )
    Q1=$(echo "$Q" | ./bn2sub 1 )
    H=$(echo "$P1" | ./bn2mul "$Q1" )
    G=$(./bn2gcd "$e" "$H")

    echo "P1 = $P1 Q1=$Q1 H=$H e=$e "
    if [ "$G" != "1" ];then
	iii=0
	while [ $(echo 2 | ./bn2pow 256 | ./bn2cmp "$e") -le 0 -o $(echo 2 | ./bn2pow 16 | ./bn2cmp "$e") -ge 0 -o -n "$(echo $e | ./bn2and )" -a "$G" != "1" -a $iii -gt 15 ];do
	    echo -e "\n\n\ne $e\n H $H\n G=$G: \n\n"
	    e=$(dd if=/dev/urandom bs=$nbits count=1 2>/dev/null |  hexdump -v -e '/1 "%02X"')
	    if [  -n "$(echo $e | ./bn2and )" ];then
		e=$(echo "$e" | ./bn2add )
	    fi
	    G=$(./bn2gcd "$e" "$H" )
	    iii=$((iii+1))
	done
	if [ "$G" != "1" ];then
	    pasab=1
	    continue
	fi
    fi
    G=$(./bn2gcd "$P1" "$Q1")
    L=$(echo "$H" | ./bn2div "$G")
    #/*
    #Y^-1 mod M X->M Y->A
    # * Modular inverse: X = A^-1 mod M  (HAC 14.61 / 14.64)
    # */
    Y=$e
    M=$L
    g=1
    C=$(echo "$X" | ./bn2cdr )
    C=$(echo "$X" | ./bn2and)
    C1=$(echo "$Y" | ./bn2cdr )
    C1=$(echo "$Y" | ./bn2and)
    while [ "$C1" = "0" -o -z "$C1" -o "$C" = "0" -o -z "$C" ];do
	X=$(echo $X | ./bn2div 2 )
	Y=$(echo $Y | ./bn2div 2 )
	g=$(echo "$g*2" | bc -l)

	C=$(echo "$X" | ./bn2cdr )
	C=$(echo "$X" | ./bn2and)
	C1=$(echo "$Y" | ./bn2cdr )
	C1=$(echo "$Y" | ./bn2and)
    done
    u=$X
    v=$Y
    A=1
    B=0
    C=0
    D=1
    while [ -n "$u" -a ! "$u" = "0" ];do
	C=$(echo "$u" | ./bn2cdr )
	C=$(echo "$u" | ./bn2and)
	while [ "$C" = "0" -o -z "$C" ];do
	    u=$(echo $u | ./bn2div 2 )
	    C1=$(echo "$A" | ./bn2cdr )
	    C1=$(echo "$A" | ./bn2and)
	    C2=$(echo "$B" | ./bn2cdr )
	    C2=$(echo "$B" | ./bn2and)
	    if [ -z $C1 -o "$C1" = "0" -o -z $C2 -o "$C2" = "0" ];then
		A=$(echo $A | ./bn2div 2 )
		B=$(echo $B | ./bn2div 2 )
	    else
		A=$(echo $A | ./bn2add $Y)
		A=$(echo $A | ./bn2div 2 )
		B=$(echo $B | ./bn2add $X)
		B=$(echo $B | ./bn2div 2 )
	    fi
	done

	C=$(echo "$v" | ./bn2cdr )
	C=$(echo "$v" | ./bn2and)
	while [ "$C" = "0" -o -z "$C" ];do
	    v=$(echo $v | ./bn2div 2 )
	    C1=$(echo "$C" | ./bn2cdr )
	    C1=$(echo "$C" | ./bn2and)
	    C2=$(echo "$D" | ./bn2cdr )
	    C2=$(echo "$D" | ./bn2and)
	    if [ -z $C1 -o "$C1" = "0" -o -z $C2 -o "$C2" = "0" ];then
		C=$(echo $C | ./bn2div 2 )
		D=$(echo $D | ./bn2div 2 )
	    else
		C=$(echo $C | ./bn2add $Y)
		C=$(echo $C | ./bn2div 2 )
		D=$(echo $D | ./bn2add $X)
		D=$(echo $D | ./bn2div 2 )
	    fi
	done

	if [ $(echo $u | ./bn2cmp $v) -ge 0 ];then
	    u=$(echo $u | ./bn2sub $v)
	    A=$(echo $A | ./bn2sub $C)
	    B=$(echo $B | ./bn2sub $D)
	else
	    v=$(echo $v | ./bn2sub $u)
	    C=$(echo $C | ./bn2sub $A)
	    D=$(echo $D | ./bn2sub $B)
	fi
    done

    D=$C
    #// (FIPS 186-4 §B.3.1 criterion 3(a))
    if [ $(echo "$D" | ./bn2bitlen ) -le $(echo "( ( $nbits + 1 ) / 2 )" | bc ) ];then
	echo "D $D"
	read
	pasab=1
    fi
done

echo "H=$H"
echo "E=$e"
echo "D=$D"
da=$(date +%Y%m%d%H%M%S%s%N)
echo "H=$H" > H$da.hkey
echo "E=$e" > E$da.ekey
echo "D=$D" > D$da.dkey
