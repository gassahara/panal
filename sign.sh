#echo "H=$H" > H$da.hkey
#echo "E=$e" > E$da.ekey
#echo "D=$D" > D$da.dkey

r=1
aa="41"
x="11"
c="ca1"
	    while [ -n "$x" -a "$x" != "0" ];do
		#    if ( (x & 1) == 1 )
		xand=$(echo "$x" | ./bn2and )
		if [ "$xand" = "1" ];then
		    r=$(echo $r | ./bn2mul $aa)
		    r2=$(echo $r | ./bn2div $c )
                    r1=$(echo $r2 | ./bn2mul $c )
		    r2=$(echo "$r" | ./bn2sub "0$r1" )
		    r=$r2
		fi
		aa=$(echo $aa | ./bn2mul $aa )
		r2=$(echo "$aa" | ./bn2div "$c")
		r1=$(echo $r2 | ./bn2mul "$c" )
		a1=$(echo $aa | ./bn2sub 0$r1 )
		aa=$a1
		x=$(echo "$x" | ./bn2shiftr ) #./bn2div 2)
		echo -n "."
	    done
	    x=$(echo $r | tr '[a-z]' '[A-Z]')
	    echo $x
echo "ibase=16;obase=A;$x" | bc -l
read

r=1
aa="$x"
x="19D"
c="ca1"
	    while [ -n "$x" -a "$x" != "0" ];do
		#    if ( (x & 1) == 1 )
		xand=$(echo "$x" | ./bn2and )
		if [ "$xand" = "1" ];then
		    r=$(echo $r | ./bn2mul $aa)
		    r2=$(echo $r | ./bn2div $c )
                    r1=$(echo $r2 | ./bn2mul $c )
		    r2=$(echo "$r" | ./bn2sub "0$r1" )
		    r=$r2
		fi
		aa=$(echo $aa | ./bn2mul $aa )
		r2=$(echo "$aa" | ./bn2div "$c")
		r1=$(echo $r2 | ./bn2mul "$c" )
		a1=$(echo $aa | ./bn2sub 0$r1 )
		aa=$a1
		x=$(echo "$x" | ./bn2shiftr ) #./bn2div 2)
		echo -n "."
	    done
	    x=$r #$(echo $r | tr '[a-z]' '[A-Z]')
	    echo $x
echo "ibase=16;obase=A;$x" | bc -l
read

ls -1 *.hkey | tail -n1 > key
echo $key
H=$(cat key)
H=$(cat $H )
ls -1 *.ekey | tail -n1 > key
e=$(cat key)
e=$(cat $e )
ls -1 *.ckey | tail -n1 > key
C=$(cat key)
C=$(cat $C )
ls -1 *.dkey | tail -n1 > key
D=$(cat key)
D=$(cat $D )
echo -e "H=$H\ne=$e\nC=$C\nD=$D"
read

T=$(echo "MESSAGE" | sha256sum -tz --tag | ./stdcdr "= ")
echo ">$T>"
r=1
aa=$T
x=$D
c=$H;
	    while [ -n "$x" -a "$x" != "0" ];do
		#    if ( (x & 1) == 1 )
		xand=$(echo "$x" | ./bn2and )
		if [ "$xand" = "1" ];then
		    r=$(echo $r | ./bn2mul $aa)
		    r2=$(echo $r | ./bn2div $c )
                    r1=$(echo $r2 | ./bn2mul $c )
		    r2=$(echo "$r" | ./bn2sub "0$r1" )
		    r=$r2
		fi
		aa=$(echo $aa | ./bn2mul $aa )
		r2=$(echo "$aa" | ./bn2div "$c")
		r1=$(echo $r2 | ./bn2mul "$c" )
		a1=$(echo $aa | ./bn2sub 0$r1 )
		aa=$a1
		x=$(echo "$x" | ./bn2shiftr ) #./bn2div 2)
		echo -n "."
	    done
	    x=$r
echo "NNNNNNNNNN                 $x"
echo -n $x > message

r=1
aa=$(cat message)
x=$e
c=$H;
	    while [ -n "$x" -a "$x" != "0" ];do
		#    if ( (x & 1) == 1 )
		xand=$(echo "$x" | ./bn2and )
		if [ "$xand" = "1" ];then
		    r=$(echo $r | ./bn2mul $aa)
		    r2=$(echo $r | ./bn2div $c )
                    r1=$(echo $r2 | ./bn2mul $c )
		    r2=$(echo "$r" | ./bn2sub "0$r1" )
		    r=$r2
		fi
		aa=$(echo $aa | ./bn2mul $aa )
		r2=$(echo "$aa" | ./bn2div "$c")
		r1=$(echo $r2 | ./bn2mul "$c" )
		a1=$(echo $aa | ./bn2sub 0$r1 )
		aa=$a1
		x=$(echo "$x" | ./bn2shiftr ) #./bn2div 2)
		echo -n "."
	    done
	    x=$r
x=$r
echo "NNNNNNNNNN                 $x"
echo $x > message.dec
read


r=1
aa=$T
x=$C
c=$H;
	    while [ -n "$x" -a "$x" != "0" ];do
		#    if ( (x & 1) == 1 )
		xand=$(echo "$x" | ./bn2and )
		if [ "$xand" = "1" ];then
		    r=$(echo $r | ./bn2mul $aa)
		    r2=$(echo $r | ./bn2div $c )
                    r1=$(echo $r2 | ./bn2mul $c )
		    r2=$(echo "$r" | ./bn2sub "0$r1" )
		    r=$r2
		fi
		aa=$(echo $aa | ./bn2mul $aa )
		r2=$(echo "$aa" | ./bn2div "$c")
		r1=$(echo $r2 | ./bn2mul "$c" )
		a1=$(echo $aa | ./bn2sub 0$r1 )
		aa=$a1
		x=$(echo "$x" | ./bn2shiftr ) #./bn2div 2)
		echo -n "."
	    done
x=$r
echo "NNNNNNNNNN                 $x"
echo -n $x > message

r=1
aa=$(cat message)
x=$e
c=$H;
	    while [ -n "$x" -a "$x" != "0" ];do
		#    if ( (x & 1) == 1 )
		xand=$(echo "$x" | ./bn2and )
		if [ "$xand" = "1" ];then
		    r=$(echo $r | ./bn2mul $aa)
		    r2=$(echo $r | ./bn2div $c )
                    r1=$(echo $r2 | ./bn2mul $c )
		    r2=$(echo "$r" | ./bn2sub "0$r1" )
		    r=$r2
		fi
		aa=$(echo $aa | ./bn2mul $aa )
		r2=$(echo "$aa" | ./bn2div "$c")
		r1=$(echo $r2 | ./bn2mul "$c" )
		a1=$(echo $aa | ./bn2sub 0$r1 )
		aa=$a1
		x=$(echo "$x" | ./bn2shiftr ) #./bn2div 2)
		echo -n "."
	    done
x=$r
echo "NNNNNNNNNN                 $x"
echo $x > message.dec
read
