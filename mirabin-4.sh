A=$(cat A.key)
B=$(cat B.key)
C=$(cat C.key)
D=$(cat D.key)
X=$(cat X.key)
	echo -e "A=$A\nB=$B\n$C\nD=$D\n-=$Cnegativo"
	Cneg=1
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
	echo "D=$D"
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
