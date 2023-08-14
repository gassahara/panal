#!/bin/bash
e=$(cat primeE)
P=$(cat primeA)
Q=$(cat primeB)
H=$(echo "$P" | ./bn2sub "$Q")
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
    
    G=$(./bn2gcd "$P1" "$Q1")
    
    L=$(echo "$H" | ./bn2div "$G")

    echo "L=$L G=$G"
    #/*
    #Y^-1 mod X X->M Y->A
    # * Modular inverse: X = A^-1 mod M  (HAC 14.61 / 14.64)
    # */
    Y=$e
    X=$L
    g=1
    C=$(echo "$X" | ./bn2cdr )
    C=$(echo "$X" | ./bn2and)
    C1=$(echo "$Y" | ./bn2cdr )
    C1=$(echo "$Y" | ./bn2and)
    #    if [ "$C1" = "0" -o -z "$C1" -o "$C" = "0" -o -z "$C" ];then
    #	pasab=1
    #	continue
    #    fi
    while [ "$C1" = "0" -o -z "$C1" -o "$C" = "0" -o -z "$C" ];do
	X=$(echo $X | ./bn2div 2 )
	Y=$(echo $Y | ./bn2div 2 )
	g=$(echo "$g*2" | bc -l)

	C=$(echo "$X" | ./bn2cdr )
	C=$(echo "$X" | ./bn2and)
	C1=$(echo "$Y" | ./bn2cdr )
	C1=$(echo "$Y" | ./bn2and)
	echo "X $X Y $Y C $C C1 $C1"
    done
    u=$X
    v=$Y
    A=1
    B=0
    C=0
    D=1
    prevc=0
    Cnegativo=0
    l1=1
    l3=1
    while [ -n "$u" -a  "$u" != "0" ];do
	Ce=$(echo  -n "$u" | ./bn2cdr )
	Ce=$(echo  -n "$u" | ./bn2and)
	while [ "$Ce" = "0" -o -z "$Ce" -a -n "$u" -a "$u" != "0" ];do
	    u=$(echo  -n $u | ./bn2shiftr 1 )
	    C1=$(echo  "0$A" | ./bn2cdr )
	    C1=$(echo  "0$A" | ./bn2and)
	    if [ -n "$C1" -a "$C1" != "0" ];then 
		A=$(echo  0$A | ./bn2add $Y)
		B=$(echo  0$B | ./bn2sub $X)
	    else
		C2=$(echo  "0$B" | ./bn2cdr )
		C2=$(echo  "0$B" | ./bn2and)
		if [ -n "$C2" -a "$C2" != "0" ];then 
		    A=$(echo  0$A | ./bn2add $Y)
		    B=$(echo  0$B | ./bn2sub $X)
		fi
	    fi
	    A=$(echo $A | ./bn2shiftr 1 )
	    B=$(echo $B | ./bn2shiftr 1 )
	    Ce=$(echo "$u" | ./bn2cdr )
	    Ce=$(echo "$u" | ./bn2and)
	    echo u $u
	done

	Ce=$(echo  "$v" | ./bn2cdr )
	Ce=$(echo  "$v" | ./bn2and)
	while [ "$Ce" = "0" -o -z "$Ce" -a -n "$v" ];do
	    v=$(echo $v | ./bn2shiftr 1 )
	    C1=$(echo  "0$C" | ./bn2cdr )
	    C1=$(echo  "0$C" | ./bn2and)
	    C2=$(echo  "0$D" | ./bn2cdr )
	    C2=$(echo  "0$D" | ./bn2and)
	    if [ -n "$C1" -a "$C1" != "0" ];then 
		C=$(echo  0$C | ./bn2add $Y)
		D=$(echo  0$D | ./bn2sub $X)
	    else
		C2=$(echo  "0$B" | ./bn2cdr )
		C2=$(echo  "0$B" | ./bn2and)
		if [ -n "$C2" -a "$C2" != "0" ];then 
		    C=$(echo  0$C | ./bn2add $Y)
		    D=$(echo  0$D | ./bn2sub $X)
		fi
	    fi
	    C=$(echo $C | ./bn2shiftr 1 )
	    D=$(echo $D | ./bn2shiftr 1 )
	    Ce=$(echo  "$v" | ./bn2cdr )
	    Ce=$(echo  "$v" | ./bn2and)
	    echo v $v
	done

#	echo -n $u | ./bn2cmp $v
#	echo -e "\n"
#	echo -n $u | wc -c
#	echo -n $v | wc -c
#	echo "A $A B $B C $C D $D"
	if [ $(echo -n $u | ./bn2cmp $v) -ge 0 ];then
	    echo "-----++++++++++++-------------------"
	    echo $u.
	    echo $v.
	    u=$(echo 0$u | ./bn2sub 0$v)
	    A=$(echo 0$A | ./bn2sub 0$C)
	    B=$(echo 0$B | ./bn2sub 0$D)
	else
	    echo "-----///////////////-------------------"
	    echo $v.
	    echo $u.
	    v=$(echo 0$v | ./bn2sub 0$u)
	    echo "=$v"
	    prevc=$(echo -n $C | wc -c )
	    C=$(echo 0$C | ./bn2sub 0$A)
	    if [ $(echo -n $C | wc -c ) -gt $prevc  ];then
		Cnegativo=1
	    fi
	    D=$(echo 0$D | ./bn2sub 0$B)
	fi
	echo "-------------------------------------"
	echo "u $u v $v X $X Y $Y Ce $Ce A $A B $B C $C D $D"
	l2=$l1
	l1=$(echo $u | wc -c )
	if [ $l1 -gt $l2 ];then
	    echo "$l1 ********************************** $l2."
	    read
	fi
	l4=$l3
	l3=$(echo $v | wc -c )
	if [ $l3 -gt $l4 ];then
	    echo "$l3 _________________________________ $l4."
	    read
	fi
    done
    #    v=$(echo $v | ./bn2mul $g)
    echo "a=$C b=$D v=$v"
    if [ "$v" = "1" -a $(echo "$D" | ./bn2cmp 0) -lt 0 ];then
	D=$(echo $m | ./bn2add 0$D )
	pasab=0
    fi
    if [ "0$v" != "01" ];then
	echo "$m no es invertible"
	pasab=1
    else
	#// (FIPS 186-4 §B.3.1 criterion 3(a))
	#    if [ $(echo "$D" | ./bn2bitlen ) -le $(echo "( ( $nbits + 1 ) / 2 )" | bc ) ];then
	#	echo "D $D"
	#	pasab=1
	#    fi
	echo $A > A.key
	echo $B > B.key
	echo $C > C.key
	echo $D > D.key
	echo $X > X.key
	echo -e "A=$A\nB=$B\nC=$C\nD=$D\n-=$Cnegativo"
	read
	if [ 0$Cneg -gt 0 ];then
	    while [ $(echo -n $C | wc -c ) -gt $(echo -n $Cneg | wc -c ) ];do
		Cneg=$(echo "f$Cneg")
	    done
	    X3=$(echo $Cneg | ./bn2sub $C)
	    echo "0X=$X"
	    echo "0C=$C"
	    echo "--=$Cneg"
	    echo "X3(-- - C )=$X3"
	    read
	    X3=$(echo $X3 | ./bn2div $X )
	    X2=$(echo $X | ./bn2mul $X3 )
	    echo "X2(XX * X4)=$X2"
	    echo "--         =$Cneg"
	    echo " C(       )=$C"
	    C=$(echo -n $C | ./bn2add $X2 )
	    echo "CX(0C + X2)=$C"
	    while [ $(echo -n $C | ./bn2cmp $Cneg ) -lt 0 ];do
		C=$(echo -n $C | ./bn2add $X )
		echo "XC(0C + 0X)=$C"
	    done
	    Cng="f"
	    while [ $(echo -n $C | ./bn2cmp $Cneg ) -gt 0 ];do
		Cng=$(echo "f$Cng")
		Cneg="100000000$Cng"
	    done
	    C=$(echo $Cneg | ./bn2sub $C )
	    echo "0X         =$Cneg"
	    echo "CC         =$C"
	    echo -e "0C         =$C\n0X         =$X"
	    read
	fi

	H=$(echo "$P" | ./bn2mul "$Q" )
	echo "H=$H"
	echo "E=$e"
	echo "D=$C"
	da=$(date +%Y%m%d%H%M%S%s%N)
	echo "$H" > H$da.hkey
	echo "$e" > E$da.ekey
	echo "$A" > A$da.akey
	echo "$B" > B$da.bkey
	echo "$C" > C$da.ckey
	echo "$D" > D$da.dkey
	read
	T=$(echo "MESSAGE" |  hexdump -v -e '/1 "%02X"' )
	echo $T

	r=1
	aa=$T
	x=$e
	c=$H;
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
	echo "NNNNNNNNNN                 $x "
    fi
    read
