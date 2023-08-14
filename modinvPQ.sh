P=$1
Q=$2
e="10001"
if [ $(echo "$Q" | ./bn2cmp "$P") -gt 0 ];then
    P1=$Q
    Q=$P
    P=$P1
fi
H=$(echo $P | ./bn2mul $Q )
P=$(echo $P | ./bn2sub 1)
Q=$(echo $Q | ./bn2sub 1)
L=$(echo $P | ./bn2mul $Q)
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
if [ $(echo $r | ./bn2cmp 1) -gt 0 ];then echo "NO INV";exit 1;fi
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
g2=$(echo $g1 | ./bn2sub $gr)
#echo $gr != $g1
if [ "$g2" != "00000001" ];then exit 1;else echo $D;fi
