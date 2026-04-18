e="10001"
d="5089a6409c0bea346acaec309bbf278327e6869526703029449a00dcdc668ab2c52c2dcc4216875c4e94e2246766c4150af8ded0df8614575087959e151ef31f67cc9319d3155c0f4df01f9f4a0b5775f1345bc1e2b9d20b0916e3295447cf22c69677e76ab54141071b1ea0946f8e0c4f24a3bd8cfe1404507caeaea19a15b946bcca755fefb3c6aed8801127b8ab990d1ad3cb2317422857d32e7835c5ca3253173d90ad32d34f1699fbbed3f52441c9d2ae26d7521dcd99b5c8b37a79114b7449a167f95488dcc3b2f0fcf3757a4761b6e97ad561129789839f561ec5511fbadfb862e8f345093befea7052566ea43d52224ac46cb03690e048fb87e22724eb77b9beea67e21d8ece75e83908cab8643548cb455b398f6e2cf67f73c9a387b90f571c120acd943586ce421da8e42cfedae2691d501180d44ab0bfa642f5d4c6d7034960816cb63fab6a3d526a94ad7b8846179a77338ac408f47b81039c15dd02c8b3a0d82ae739cc2c2d8db9e8ce90ad2974010e1e14d1dced733520022c12941a7757e0e9aed93dc8965ca9b3700b6d94bfea7d0267d6b456c8060e1662d1638aa17a262bb00ae15eb0a00db630416f3cbbfc829a608abef0737364e56b63ba6e4021ab5fe76b7408218cbfff5eb78e4d8b4b50d47b9be509c7c12e0bbdbe14a7caf08ecdbce6fe453d67541e6d221803808973dcf2280ee2541bfeda01"
c="c33b6e2deb0cccbe173d7f17f862788d9cff8e071541a65524ae4d0512ba9427c9a3476a32e74b78ab05a070f612c5aee387d129eafa71f43cfd340b1acd69fc4992fdd7112eecd6136a62987053df3af98573912dd50227209641c88db492d9ed592b776cab113196869e62b9872b96e2d6f227418e29d413f3830f2124c6ac54ce26f29c1b704385241bfcb8c212216c40e8c473f14c04b24c1fd4415fcb0cddcc68d246cb945af09225f81254ee05bac1e5a97ed2b4c06ccff19e787acacd9db65666b2d8ae81f2e6cb92dd3aa26e30e90b4eefef55902e63ea7230250ab6f37dae20939fb80093cdb43d9332d0bb72d6d6d51b7a8caca17956edbf46b368669e022579e91e8f4ffc9e91ce5a862dd25a04bc4333f35f1e2f8a52c6cf3fa4991b373f73547d99a0526b95aea4cda09864715d3e6912d8b01c73a0733cce20d35f7383ead1119f8ec060d82670fff7c62399a1657afb0090d7930ff355db2b6d07bc992934c27496637d8e8992ebe496d55321c9cec883f5a72e73968b87cfd2770ff606a87b9cceb99b5ec28af4c2aa789bec804dcb6e0f57e4f8c686389a0f17c70504a2061bf8e64c8bfcf5c55bd30451d1420ab5f3a0b5f35d783fdf72caae53296bb137fa5516bd2a9f76f66a26f4f09c08423be21a4b48db682e44d84ce16c30968d3dacf742467b668eac69b7039033ff8a6bb4d12ec56359c84f37"

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

