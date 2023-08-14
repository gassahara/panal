fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
#  uint64_t x = pow_mod(a,d,n);
r=1
c="64B1"
a="509"
x="424B"
aa=$a

while [ -n "$x" -a "$x" != "0" ];do
    #    if ( (x & 1) == 1 )
    xand=$(echo "$x" | $PrPWD/bn2and 1 )
    if [ "$xand" = "00000001" ];then
	r=$(echo $r | $PrPWD/bn2mul $aa)
	cociente=$(echo $r | $PrPWD/bn2div $c )
        resto1=$(echo $cociente | $PrPWD/bn2mul $c )
	r=$(echo 0$r | $PrPWD/bn2sub 0$resto1)
    fi
    aa=$(echo $aa | $PrPWD/bn2mul $aa )
    if [ $(echo $aa | $PrPWD/bn2cmp $c) -gt 0 ];then
	divid=$aa
	divisor=$c
	cociente=0
	#   c              a         /        b
	cociente=$(echo $divid | $PrPWD/bn2div $divisor )
	#  t              b          *        c
	resto1=$(echo $divisor | $PrPWD/bn2mul $cociente )
	#            a         -        t
	aa=$(echo $divid | $PrPWD/bn2sub 0$resto1 )
    fi
    x=$(echo "$x" | $PrPWD/bn2shiftr ) #$PrPWD/bn2div 2)
    echo -n "${#x} " #c=${#c} cociente=${#cociente} resto1=${#resto1} aa=${#aa}"
done
echo "-----------------------"
echo "E $r"
echo ${#r} ${#c}

a=$r #$($PrPWD/stdtohex | $PrPWD/stddelcar " ")
r=1
echo "T $a"
x="3"
aa=$a
while [ -n "$x" -a "$x" != "0" ];do
    #    if ( (x & 1) == 1 )
    xand=$(echo "$x" | $PrPWD/bn2and 1 )
    if [ "$xand" = "00000001" ];then
	r=$(echo $r | $PrPWD/bn2mul $aa)
	cociente=$(echo $r | $PrPWD/bn2div $c )
        resto1=$(echo $cociente | $PrPWD/bn2mul $c )
	r=$(echo 0$r | $PrPWD/bn2sub 0$resto1)
    fi
    aa=$(echo $aa | $PrPWD/bn2mul $aa )
    if [ $(echo $aa | $PrPWD/bn2cmp $c) -gt 0 ];then
	divid=$aa
	divisor=$c
	cociente=0
	#   c              a         /        b
	cociente=$(echo $divid | $PrPWD/bn2div $divisor )
	#  t              b          *        c
	resto1=$(echo $divisor | $PrPWD/bn2mul $cociente )
	#            a         -        t
	aa=$(echo $divid | $PrPWD/bn2sub 0$resto1 )
    fi
    x=$(echo "$x" | $PrPWD/bn2shiftr ) #$PrPWD/bn2div 2)
    echo -n "${#x} " #c=${#c} cociente=${#cociente} resto1=${#resto1} aa=${#aa}"
done
x=$r
echo "-----------------------"
echo "D $x"
