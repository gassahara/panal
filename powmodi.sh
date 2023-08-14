#  uint64_t x = pow_mod(a,d,n);
d=$(cat D*key | ./stdtohex | ./stdcarsin 0A | ./stdfromhex)
e="10001"
c=$(cat H*key | ./stdtohex | ./stdcarsin 0A | ./stdfromhex)
u=$(cat U*key | ./stdtohex | ./stdcarsin 0A | ./stdfromhex)

echo $d
echo " ------------------"
g1=$(echo $d | ./bn2mul $e)
gq=$(echo $g1 | ./bn2div $u)

gr=$(echo $gq | ./bn2mul $u)
echo $gr
g2=$(echo $g1 | ./bn2sub $gr)
echo "d*e%u" $g2 ${#g2}

aa=$(./stdcarsin "*")
r=1
x="$d"
echo "T $aa"
echo ${#aa}
divisor=$c

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
echo "-----------------------"
echo "E $r"
echo ${#r} ${#c}

aa=$r
r=1
x="$e"
echo "T $aa"
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
echo "-----------------------"
echo "D $r"
echo ${#r} ${#c}
