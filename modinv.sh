#/*
#Y^-1 mod X X->M Y->A
# * Modular inverse: X = A^-1 mod M  (HAC 14.61 / 14.64)
# */
Y="11"
X=$(echo "obase=16;780" | bc)
echo $X
#g=1
#CC=$(echo "$X" | ./bn2cdr)
#C=$(echo $CC | ./bn2and)
#CC=$(echo "$Y" | ./bn2cdr)
#C1=$(echo $CC | ./bn2and)
#while [ "$C1" = "0" -o -z "$C1" -o "$C" = "0" -o -z "$C" ];do
#    X=$(echo $X | ./bn2shiftr)
#    Y=$(echo $Y | ./bn2shiftr)
#    g=$(echo "$g*2" | bc -l)
#
#    CC=$(echo $X | ./bn2cdr)
#    C=$(echo $CC | ./bn2and)
#    CC=$(echo $Y | ./bn2cdr)
#    C1=$(echo $CC | ./bn2and)
#    echo "X $X Y $Y C $C C1 $C1"
#done
u=$X
v=$Y
A=1
B=0
C=0
D=1
l1=1
l3=1
Xmp=$(echo "ibase=16;obase=10;$Y%$X" | bc)
Xmo=$(echo $Y | ./bn2div $X)
echo "$Y / $X = $Xmo"
Xmo1=$(echo $Xmo | ./bn2mul $Y)
if [ $(echo $Xmo1 | ./bn2cmp 0$Y) -ge 0 ];then
    Xmo=$(echo $Xmo1 | ./bn2sub 0$Y )
else
    Xmo=$(echo 0$Y | ./bn2sub 0$Xmo1 )
fi
echo "..."
echo "$Xmo1 - $Xmo vs $Xmp $Y % $X"
echo "ibase=16;$Y % $X" | bc
while [ -n "$u" -a  "$u" != "0" ];do
    Ce1=$(echo  -n "$u" | ./bn2cdr )
    Ce=$(echo  $Ce1 | ./bn2and)
    while [ -z "$Ce" -a -n "$u" -a "$u" != "0" ];do
	u=$(echo  $u | ./bn2shiftr 1 )
	C11=$(echo  "0$A" | ./bn2cdr)
	C1=$(echo $C11 | ./bn2and)
	C11=$(echo  "0$B" | ./bn2cdr )
	C2=$(echo $C11 | ./bn2and)
	if [ -n "$C1" -o -n "$C2" ];then 
	    A=$(echo  0$A | ./bn2add $Y)
	    pasab=1
	    if [ 0$Bnegativ -eq 0 -a $(echo $Xmo | ./bn2cmp $B) -ge 0 ];then
		B=$(echo  0$X | ./bn2sub $B)
		Bnegativ=1
		pasab=0
	    fi
	    if [ 0$Bnegativ -eq 1 -a 0$pasab -eq 1 ];then
		B=$(echo  0$Xmo | ./bn2add $B)
		pasab=0
	    fi
	    if [ 0$Bnegativ -eq 0 -a $(echo $B | ./bn2cmp $Xmo) -gt 0 -a 0$pasab -eq 1 ];then
		B=$(echo  0$B | ./bn2sub $Xmo)
		pasab=0
	    fi
	fi
	A=$(echo $A | ./bn2shiftr 1 )
	B=$(echo $B | ./bn2shiftr 1 )

	C11=$(echo $u | ./bn2cdr)
	Ce=$(echo  $C11 | ./bn2and)
	echo "u $u A=$A($Anegativ) B=$B($Bnegativ) .."
    done

    Ce1=$(echo  "$v" | ./bn2cdr)
    Ce=$(echo $Ce1 | ./bn2and)
    while [  -z "$Ce" -a -n "$v" ];do
	v=$(echo  $v | ./bn2shiftr 1 )
	C11=$(echo  "0$C" | ./bn2cdr)
	C1=$(echo $C11 | ./bn2and)
	C11=$(echo  "0$D" | ./bn2cdr )
	C2=$(echo $C11 | ./bn2and)
	if [ -n "$C1" -o -n "$C2" ];then 
	    C=$(echo  0$C | ./bn2add $Y)
	    pasab=1
	    if [ 0$Dnegativ -eq 0 -a $(echo $Xmo | ./bn2cmp $D) -ge 0 ];then
		D=$(echo  0$Xmo | ./bn2sub $D)
		Dnegativ=1
		pasab=0
	    fi
	    if [ 0$Dnegativ -eq 1 -a $pasab -eq 1 ];then
		D=$(echo  0$Xmo | ./bn2add $D)
		pasab=0
	    fi
	    if [ 0$Dnegativ -eq 0 -a $(echo $D | ./bn2cmp $Xmo) -gt 0 -a $pasab -eq 1 ];then
		D=$(echo  0$D | ./bn2sub $Xmo)
		pasab=0
	    fi
	fi
	C=$(echo $C | ./bn2shiftr 1 )
	D=$(echo $D | ./bn2shiftr 1 )
	C11=$(echo $v | ./bn2cdr)
	Ce=$(echo  $C11 | ./bn2and)
	echo "v $v C=$C($Cnegativ) D=$D($Dnegativ) .."
    done

    echo "u $u $l1 v $v $l3 <><><><><><><><>"
    if [ $(echo $u | ./bn2cmp $v) -ge 0 ];then
	echo -n "u>"
	u=$(echo 0$u | ./bn2sub 0$v)
	echo -e "\nantes A $A ($Anegativ) B $B ($Bnegativ) C $C ($Cnegativ) D $D ($Anegativ) "
	pasab=1
	if [ 0$Cnegativ -eq 0 -a 0$Anegativ -eq 1  ];then
	    A=$(echo 0$A | ./bn2add 0$C)
	    pasab=0
	fi
	if [ 0$Cnegativ -eq 1 -a 0$Anegativ -eq 0 ];then
	    A=$(echo 0$A | ./bn2add 0$C)
	    pasab=0
	fi
	if [ 0$Cnegativ -eq 0 -a 0$Anegativ -eq 0 -a 0$pasab -eq 1 -a $(echo $C | ./bn2cmp $A) -gt 0  ];then
	    A=$(echo 0$C | ./bn2sub 0$A)
	    Anegativ=1
	    pasab=0
	fi
	if [ 0$Cnegativ -eq 0 -a 0$Anegativ -eq 0 -a 0$pasab -eq 1 -a $(echo $A | ./bn2cmp $C) -ge 0 ];then
	    A=$(echo 0$A | ./bn2sub 0$C)
	    pasab=0
	fi
	if [ 0$Cnegativ -eq 1 -a 0$Anegativ -eq 1 -a 0$pasab -eq 1 -a $(echo $A | ./bn2cmp $C) -ge 0 ];then
	    A=$(echo 0$A | ./bn2sub 0$C)
	    pasab=0
	fi	
	if [ 0$Cnegativ -eq 1 -a 0$Anegativ -eq 1 -a 0$pasab -eq 1 -a $(echo $C | ./bn2cmp $A) -ge 0 ];then
	    A=$(echo 0$C | ./bn2sub 0$A)
	    Anegativ=0
	    pasab=0
	fi
	
	pasab=1
	if [ 0$Dnegativ -eq 0 -a 0$Bnegativ -eq 1  ];then
	    B=$(echo 0$D | ./bn2add 0$B)
	    pasab=0
	fi
	if [ 0$Dnegativ -eq 1 -a 0$Bnegativ -eq 0 ];then
	    B=$(echo 0$B | ./bn2add 0$D)
	    pasab=0
	fi
	if [ 0$Dnegativ -eq 0 -a 0$Bnegativ -eq 0 -a 0$pasab -eq 1 -a $(echo $D | ./bn2cmp $B) -gt 0  ];then
	    B=$(echo 0$D | ./bn2sub 0$B)
	    Bnegativ=1
	    pasab=0
	fi
	if [ 0$Dnegativ -eq 0 -a 0$Bnegativ -eq 0 -a 0$pasab -eq 1 -a $(echo $B | ./bn2cmp $D) -gt 0 ];then
	    B=$(echo 0$B | ./bn2sub 0$D)
	    pasab=0
	fi
	if [ 0$Dnegativ -eq 1 -a 0$Bnegativ -eq 1 -a 0$pasab -eq 1 -a $(echo $B | ./bn2cmp $D) -ge 0 ];then
	    B=$(echo 0$B | ./bn2sub 0$D)
	    pasab=0
	fi	
	if [ 0$Dnegativ -eq 1 -a 0$Bnegativ -eq 1 -a 0$pasab -eq 1 -a $(echo $D | ./bn2cmp $B) -ge 0 ];then
	    B=$(echo 0$D | ./bn2sub 0$B)
	    Bnegativ=0
	    pasab=0
	fi
	echo -e "\ndespues A $A ($Anegativ) B $B ($Bnegativ) C $C ($Cnegativ) D $D ($Anegativ) "
    else
	echo -n "v>"
	v=$(echo 0$v | ./bn2sub 0$u)
	echo -e "\nantes A $A ($Anegativ) B $B ($Bnegativ) C $C ($Cnegativ) D $D ($Anegativ) "
	pasab=1
	if [ 0$Cnegativ -eq 0 -a 0$Anegativ -eq 1  ];then
	    C=$(echo 0$A | ./bn2add 0$C)
	    pasab=0
	fi
	if [ 0$Cnegativ -eq 1 -a 0$Anegativ -eq 0 ];then
	    C=$(echo 0$A | ./bn2add 0$C)
	    pasab=0
	fi
	if [ 0$Cnegativ -eq 0 -a 0$Anegativ -eq 0 -a 0$pasab -eq 1 -a $(echo $C | ./bn2cmp $A) -gt 0  ];then
	    C=$(echo 0$C | ./bn2sub 0$A)
	    pasab=0
	fi
	if [ 0$Cnegativ -eq 0 -a 0$Anegativ -eq 0 -a 0$pasab -eq 1 -a $(echo $A | ./bn2cmp $C) -ge 0 ];then
	    C=$(echo 0$A | ./bn2sub 0$C)
	    Cnegativ=1
	    pasab=0
	fi
	if [ 0$Cnegativ -eq 1 -a 0$Anegativ -eq 1 -a 0$pasab -eq 1 -a $(echo $A | ./bn2cmp $C) -ge 0 ];then
	    C=$(echo 0$A | ./bn2sub 0$C)
	    pasab=0
	    Cnegativ=0
	fi	
	if [ 0$Cnegativ -eq 1 -a 0$Anegativ -eq 1 -a 0$pasab -eq 1 -a $(echo $C | ./bn2cmp $A) -ge 0 ];then
	    C=$(echo 0$C | ./bn2sub 0$A)
	    pasab=0
	fi
	
	pasab=1
	if [ 0$Dnegativ -eq 0 -a 0$Bnegativ -eq 1  ];then
	    D=$(echo 0$D | ./bn2add 0$B)
	    pasab=0
	fi
	if [ 0$Dnegativ -eq 1 -a 0$Bnegativ -eq 0 ];then
	    D=$(echo 0$B | ./bn2add 0$D)
	    pasab=0
	fi
	if [ 0$Dnegativ -eq 0 -a 0$Bnegativ -eq 0 -a 0$pasab -eq 1 -a $(echo $D | ./bn2cmp $B) -ge 0  ];then
	    D=$(echo 0$D | ./bn2sub 0$B)
	    pasab=0
	fi
	if [ 0$Dnegativ -eq 0 -a 0$Bnegativ -eq 0 -a 0$pasab -eq 1 -a $(echo $B | ./bn2cmp $D) -gt 0 ];then
	    D=$(echo 0$B | ./bn2sub 0$D)
	    Dnegativ=1
	    pasab=0
	fi
	if [ 0$Dnegativ -eq 1 -a 0$Bnegativ -eq 1 -a 0$pasab -eq 1 -a $(echo $B | ./bn2cmp $D) -ge 0 ];then
	    D=$(echo 0$B | ./bn2sub 0$D)
	    pasab=0
	    Dnegativ=0
	fi	
	if [ 0$Dnegativ -eq 1 -a 0$Bnegativ -eq 1 -a 0$pasab -eq 1 -a $(echo $D | ./bn2cmp $B) -ge 0 ];then
	    D=$(echo 0$D | ./bn2sub 0$B)
	    pasab=0
	fi
	echo -e "\ndespues A $A ($Anegativ) B $B ($Bnegativ) C $C ($Cnegativ) D $D ($Anegativ) "
    fi
    l2=$l1
    l1=$(echo $u | wc -c )
    if [ $l1 -gt $l2 ];then
	echo "u $l1 ********************************** $l2."
	read
    fi
    l4=$l3
    l3=$(echo $v | wc -c )
    if [ $l3 -gt $l4 ];then
	echo "v $l3 _________________________________ $l4."
	read
    fi
    echo "u $u $l1 v $v $l3 C $C($Cnegativ) D $D($Dnegativ) .."
done
#    v=$(echo $v | ./bn2mul $g)
echo "a=$C b=$D v=$v"
C=$(echo $C | tr '[a-z]' '[A-Z]' )
D=$(echo $D | tr '[a-z]' '[A-Z]' )
read
if [ "0$v" != "01" ];then
    echo "$m no es invertible"
    pasab=1
else
    while [ 0$Dnegativ -eq 1 ];do
	echo "X=$X D=$D"
	if [ $(echo $X | ./bn2cmp $D) -ge 0 ];then
	    D=$(echo $X | ./bn2sub 0$D )
	    Dnegativ=0
	else
	    D=$(echo $D | ./bn2sub 0$X )
	fi
    done
    D=$(echo $D | tr '[a-z]' '[A-Z]')
    echo -e "ibase=16\n$C\n" | bc
    echo D $D vs $X
    read
    while [ 0$Cnegativ -eq 1 ];do
	if [ $(echo $X | ./bn2cmp $C) -ge 0 ];then
	    C=$(echo $X | ./bn2sub 0$C )
	    Cnegativ=0
	else
	    C=$(echo $C | ./bn2sub 0$X )
	fi
    done
    C=$(echo $C | tr '[a-z]' '[A-Z]')
    echo -e "ibase=16\n$D\n" | bc
    echo C $C vs $X
    read
    while [ $(echo $C | ./bn2cmp $X) -gt 0 ];do
	C=$(echo $C | ./bn2sub 0$X )
	echo C $C vs $X
    done
    pasan=0
    echo $A > A.key
    echo $B > B.key
    echo $C > C.key
    echo $D > D.key
    echo $X > X.key
    echo -e "A=$A\nB=$B\nC=$C\nD=$D\n-=$Dnegativo"
    echo -e "ibase=16\n$C\n" | bc
    echo -e "ibase=16\n$D\n" | bc
    echo "************"
    a1=$(echo $Y | ./bn2mul "$C")
    a2=$(echo $a1 | ./bn2div "$X")
    am=$(echo $a2 | ./bn2mul "$X")
    a2=$(echo $a1 | ./bn2sub $am)
    X2=$(echo -e "ibase=16\n$X\n" | bc)
    C2=$(echo -e "ibase=16\n$C\n" | bc)
    echo "e($Y) * C($C2) % L($X2) = $a2"

    a1=$(echo $Y | ./bn2mul "$D")
    a2=$(echo $a1 | ./bn2div "$X")
    am=$(echo $a2 | ./bn2mul "$X")
    a2=$(echo $a1 | ./bn2sub $am)
    D2=$(echo -e "ibase=16\n$D\n" | bc)
    echo "e($Y) * D($D2) % L($X2) = $a2" 

    H=$(echo "$P" | ./bn2mul "$Q" )
    echo "H=$H"
    echo "E=$e"
    echo "D=$D"
    da=$(date +%Y%m%d%H%M%S%s%N)
    echo "$H" > H$da.hkey
    echo "$e" > E$da.ekey
    echo "$A" > A$da.akey
    echo "$B" > B$da.bkey
    echo "$C" > C$da.ckey
    echo "$D" > D$da.dkey
    pasab=0
    read
fi
read
