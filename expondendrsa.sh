p="0000F53CD269D025E37611B0387F19528428A5A22EE1E313BBD8D7C61C5BA57E1D2CEA414296482867E5FA24CD4B7400AFCB4860BCEA88D54B445DBC86A794FCAE203C44A790900446C6D4496723241B62D1DDF3B5718FF4841B6EB9AAA75785BF1D67B03F61EF121A950F8D17BD19BF5CFE7BF83FBFA783EA523AE3B2DBBC30D0125C41780D7D57C34F60093255E006658292AC1D24AB72D0EDB33550251BB5CCAD7C00CFC78EC3E3AB6EA558F33FB5381C9EC6A8DDF1205BDF534CF2BBD1DCAB3C6D6F"
q="93E55937EFC150B1B8D5D581EE6FC542D8523E0B36BF81EB58BF5B4E2990B3279091DEDE52D9002012C51E9541BE761B742A0B29141FFA521925E06CCED53ACC849A9D2704F37EEDDCE7A1CBF4FCC3D28DD5E64FD5412E362B0EAC0F0EC2A3FFA61EDC72290324A1C01AD75B1AB039C10F33A008E48778F5519D1D5DEB6414EB518267723283496317E2719854CBE692FCF92B9F81A7BBAD7A3D2449B028ADC0177770779F6DD81CF7AFA629FBF7379ADD8D0CB5532701623AB6FCA57A10406645E7"
e="10001"

fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd

#d = e –1 mod (LCM(p–1, q–1)).
#--------------------------------------------------
#LCM
N2=$(echo "$p-0001"|$PrPWD/bignum_sub)
N3=$(echo "$q-0001"|$PrPWD/bignum_sub)

echo "p=$p"
echo "q=$q"
echo "p-1=$N2"
echo "q-1=$N3"
n=$(echo -n "$p*$q"|$PrPWD/bignum_mul)
echo "n=$n"

tmp=0;
cmp3=$(echo "$N2=$N3"|$PrPWD/bignum_cmp_m)
if [ "$cmp3" = "<" ];then
    m=$N2
    n=$N3
else
    m=$N3
    n=$N2
fi
m2=$m
n2=$n
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
m=$m2
n=$n2
lcm=$(echo -n "$m*$n"|$PrPWD/bignum_mul)
lcm=$(echo -n "$lcm/$gcd"|$PrPWD/bignum_div)
a=$e
b=$lcm

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
#sleep 5
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
echo "gcd pa x^-1 $gcd"
cmp3=$(echo -n "$gcd=001"|$PrPWD/bignum_cmp_m)
echo $cmp3
if [ "$cmp3" != "=" ];then exit;fi

a=$e
b=$lcm
m0=$b
t=0;
q=0;
nt=1;
r=$b
cmp3=$(echo "$a=$b"|$PrPWD/bignum_cmp_m)
if [ "$cmp3" = ">" ];then
    nr=$a
else
    coc=$(echo "$a/$b"|$PrPWD/bignum_div)
    temp1=$(echo "$coc*$b"|$PrPWD/bignum_mul)
    nr=$(echo "$a-$temp1"|$PrPWD/bignum_sub)
fi

echo "por gcd ..........................."
signonr=0
signont=0
signot=0
signor=0
signotmp=0
signotemp1=0
while [ -n "$nr" ];do
    cmp3=$(echo -n "$r=$nr"|$PrPWD/bignum_cmp_m)
    q=$(echo -n "$r/$nr"|$PrPWD/bignum_div)
    
    tmp=$nt;
    signotmp=$signont
    temp1=$(echo -n "$q*$nt"|$PrPWD/bignum_mul)    
    signotemp1=$signont
    cmp3=$(echo -n "$t=$temp1"|$PrPWD/bignum_cmp_m)
    #t-temp1
    if [ 0$signot -eq 1 -a 0$signotemp1 -eq 0 ];then
	cmp3=">"
    fi
    if [ 0$signot -eq 0 -a 0$signotemp1 -eq 1 ];then
	cmp3="<"
    fi
    if [ 0$signot -eq 1 -a 0$signotemp1 -eq 1 ];then
	if [ "$cmp3" = ">" ];then
	    cmp3="<"
	else
	    cmp3=">"
	fi
    fi
    paso=0
    if [ 0$signot -eq 0 -a $signotemp1 -eq 0 -a 0$paso -eq 0 ];then
	if [ "$cmp3" = ">" ];then
	    signont=1
	    nt=$(echo -n "$temp1-$t"|$PrPWD/bignum_sub)
	else
	    nt=$(echo -n "$t-$temp1"|$PrPWD/bignum_sub)
	fi
	paso=1
    fi

    if [ "$cmp3" = ">" ];then
	if [ 0$signot -eq 1 -a 0$signotemp1 -eq 1 -a 0$paso -eq 0 ];then
	    signont=0
	    nt=$(echo -n "$temp1-$t"|$PrPWD/bignum_sub)
	    paso=1
	fi
	if [ 0$signot -eq 1 -a 0$signotemp1 -eq 0  -a 0$paso -eq 0 ];then
	    signont=1
	    nt=$(echo -n "$t+$temp1"|$PrPWD/bignum_add)
	    paso=1
	fi
	if [ 0$signot -eq 0 -a 0$signotemp1 -eq 1  -a 0$paso -eq 0 ];then
	    signont=1
	    nt=$(echo -n "$temp1-$t"|$PrPWD/bignum_sub)
	    paso=1
	fi
    else
	if [ 0$signot -eq 0 -a 0$signotemp1 -eq 1 ];then
	    signont=0
	    nt=$(echo -n "$t+$temp1"|$PrPWD/bignum_add)
	    paso=1
	fi
	if [ 0$signot -eq 1 -a 0$signotemp1 -eq 0  -a 0$paso -eq 0 ];then
	    signont=1
	    nt=$(echo -n "$t+$temp1"|$PrPWD/bignum_add)
	    paso=1
	fi
	if [ 0$signot -eq 1 -a 0$signotemp1 -eq 1 ];then
	    signont=0
	    nt=$(echo -n "$temp1-$t"|$PrPWD/bignum_sub)
	    paso=1
	fi
    fi    
    t=$tmp
    signot=$signotmp

    tmp=$nr;
    signotmp=$signonr
    temp1=$(echo -n "$q*$nr"|$PrPWD/bignum_mul)    
    signotemp1=$signonr
    cmp3=$(echo -n "$r=$temp1"|$PrPWD/bignum_cmp_m)
    #t-temp1
    if [ 0$signor -eq 1 -a 0$signotemp1 -eq 0 ];then
	cmp3=">"
    fi
    if [ 0$signor -eq 0 -a 0$signotemp1 -eq 1 ];then
	cmp3="<"
    fi
    if [ 0$signor -eq 1 -a 0$signotemp1 -eq 1 ];then
	if [ "$cmp3" = ">" ];then
	    cmp3="<"
	else
	    cmp3=">"
	fi
    fi
    paso=0
    if [ 0$signor -eq 0 -a $signotemp1 -eq 0 ];then
	if [ "$cmp3" = ">" ];then
	    signonr=1
	    echo "temp1 ($temp1) - r ($r)"
	    nr=$(echo -n "$temp1-$r"|$PrPWD/bignum_sub)
	else
	    nr=$(echo -n "$r-$temp1"|$PrPWD/bignum_sub)
	fi
	paso=1
    fi

    if [ 0$paso -eq 0 ];then
	if [ "$cmp3" = ">" ];then
	    if [ 0$signor -eq 1 -a 0$signotemp1 -eq 1 ];then
		signonr=0
		nr=$(echo -n "$temp1-$r"|$PrPWD/bignum_sub)
		paso=1
	    fi
	    if [ 0$signor -eq 1 -a 0$signotemp1 -eq 0  -a 0$paso -eq 0 ];then
		signonr=1
		nr=$(echo -n "$r+$temp1"|$PrPWD/bignum_add)
		paso=1
	    fi
	    if [ 0$signor -eq 0 -a 0$signotemp1 -eq 1  -a 0$paso -eq 0 ];then
		signonr=1
		nr=$(echo -n "$temp1-$r"|$PrPWD/bignum_sub)
		paso=1
	    fi
	else
	    if [ 0$signor -eq 0 -a 0$signotemp1 -eq 1 ];then
		signonr=0
		nr=$(echo -n "$r+$temp1"|$PrPWD/bignum_add)
		paso=1
	    fi
	    if [ 0$signor -eq 1 -a 0$signotemp1 -eq 0  -a 0$paso -eq 0 ];then
		signonr=1
		nr=$(echo -n "$r+$temp1"|$PrPWD/bignum_add)
		paso=1
	    fi
	    if [ 0$signor -eq 1 -a 0$signotemp1 -eq 1 ];then
		signonr=0
		nr=$(echo -n "$r-$temp1"|$PrPWD/bignum_sub)
		paso=1
	    fi
	fi
    fi
    r=$tmp
    signor=$signotmp
    cmp3=$(echo "$nr=00001"|$PrPWD/bignum_cmp_m)
    if [ "$cmp3" = ">" ];then break;fi
done
if [ 0$signot -eq 1 ];then    
    t=$(echo -n "$b-$t"|$PrPWD/bignum_sub)
fi
euler=$t
residuor=$r
cmp3=$(echo "0001=$residuor"|$PrPWD/bignum_cmp_m)
if [ "$cmp3" = ">" ];then exit;fi

echo "lcm=$lcm"
echo "gcd=$euler"
echo "residuo=$residuor"
d=$euler
echo d $d
r1=$(echo -n "$d*$e"|$PrPWD/bignum_mul)
echo "e*d=$r1"
coc=$(echo -n "$r1/$lcm"|$PrPWD/bignum_div)
echo coc $coc
temp1=$(echo -n "$coc*$lcm"|$PrPWD/bignum_mul)
cmp3=$(echo -n "$r1=$temp1"|$PrPWD/bignum_cmp_m)
echo ":$cmp3:"
r1=$(echo -n "$r1-$temp1"|$PrPWD/bignum_sub)
echo r $r1
#cmp3=$(echo "$d=$lcm"|$PrPWD/bignum_cmp_m)
#echo ":$cmp3:"
#echo -n $d|$PrPWD/bignum_bitlen
#echo
#----------------------------------------------


