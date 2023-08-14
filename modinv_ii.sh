#/*
#Y^-1 mod X X->M Y->A
# * Modular inverse: X = A^-1 mod M  (HAC 14.61 / 14.64)
# */
Y="11"
echo "ibase=16;$Y" | bc
X=$(echo "obase=16;780" | bc)
echo $X
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
while [ 1 ];do
    quotient=$(echo $r | ./bn2div $newr)
    if [ $(echo $r | ./bn2cmp $newr) -lt 0 ];then quotient=$r;fi
    temporal=$newt
    newt1=$(echo $quotient | ./bn2mul $newt)
    echo "q*newt $quotient*$newt"
    echo bc
    echo "ibase=16;obase=10;$quotient*$newt" | bc
    echo mio
    echo $newt1
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
echo "r $r"
if [ $(echo $r | ./bn2cmp 1) -gt 0 ];then echo "NO INV";fi
echo $signot 
echo "ibase=16;$t" | bc
    if [ 0$signot -eq 1 ];then
	while [ $(echo $t | ./bn2cmp $X) -ge 0 ];do
	    t=$(echo $t | ./bn2sub $X)
	    echo "."
	done
	t=$(echo $X | ./bn2sub $t); 
    fi
echo "ibase=16;$t" | bc
