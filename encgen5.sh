e="10001"
d="10e7b6bac662c26120e0812dd245bf311b57f4b7382f9de74aa64c995e464cc281b8413e746ab7737662f3e7474bba87dd1ae86b73155eb31e150f31caf087087814626eaa943cbfac977beb48d4405a5d7d05db7e9d9ebfe99f4d1cb6b8ebd5f1c7fd1f8e23dfb5695d58af72df512e27238aa8fbec1957d705ae7f130da8dcd22f22c497c374151e6da322818ee2d48bc6d9e047fbc572660343c1c1f5361a933413502ad95043a32fc7535948fa790b04096ff1a5ffcabac70bb4febf330c08d49a92e94893e5fe3ad881ae29383e2bc0cb58c6bd5d72ddc7a5dec4f09d1eb3d2be7f825b7458ba4d4a34b3ffe7fe44097babdf8a301e22248220a0b05881"
c="b6899c9b58c94e621df92098a95e7a39d9487c4e67aab83ae769fba441de424bbadc2b0d356234c5b95e832437e2e3c967fb00c0d13ceac8ac99aaa012519d0cce497423b9af5e89da3710605dc8d6b669e227095cc68c38f4c4bfe93783178d019efc8046543929d29b2ce3d3d463dafb286086929d55e4a44e432322eeef78d34a4acf98f9f71ce6e93b2482fb5d060930cd2687e3e6c45d1e6264418c45b5c72a7aad7160b047505bc05c459d75672e8d07e85b2eb64dd6a28919128bde899912cca09f7090557244dcdbc4c374cdebc128c2bdf4baac9ce3bf560a4b8819950573b3cb355825434ec451cbce4ee7b6314801e19590fdd7e95e4cf09b3669"

aa=$(./stdcarsin "*")
r=1
x="$d"
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
    echo -n "." 2>&1 #c=${#c} cociente=${#cociente} resto1=${#resto1} aa=${#aa}"
done
echo "$r"
