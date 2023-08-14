e="10001"
d="3b1fd6f882b841423b5e7e5753819422b456040478e7d272d194d14586d08ee7e6a4555f25e2dfe7be2f8efa8b0a6a7ee59f28e64aff864e0011483877f3cc30dfe169897c342af4c523427024cd846fa6379c8ef550bc8b5e3ea897abcec0de45915081365f566dca71c9794c5c6f5856c046ad2556d6be85d5daafd9fdd67afc107869ef33ec750b9b1c629d014be9ec795b5f97052732137f9e44fc6df9a559c08c669d00aa723834297b703c9933493c8ebf2b796ab8fd22abd6fc64e55178502e511a768af4ac187ea24569b164650d5a943cde4f5eccd55cfced507be10d1b929244908738e0fad76cc4427c732d16e697563abe08f672aa55bddfc93fc76db5a1315d5ad05e4d97d92f9a6a8404e652342fc39d27708759cbe3dbba47b8360769fd8c4ab4aaa8ab42b2157317b4d79af57f29050994ff0ace47b144690a517118aac7d3d2789932b43fdbcdb04d20a0f8c7a5c1a26b951a581ad260cb070617b00968550beeb2f572aa081260ecfa9cb6f4b49ded389f3257af358b01"
c="c01bd903a6c23d691fc3cf700b4836ae654acfd3b0db0ec82132ad816f7017ddf43985563887ee0fa9c9494f9aeea19cd9c5a5f486683e83ed34e1072f994c15c7d40d708ce74a5cc153a2bb1279b52e9d1e788e94e669318f5ed89b9c454ebac1e128b9166bd7a7448eb589539cbe713d8388a9502348ff386f168997563c79c66bf098cee7b3f60cd8ae01636dcc68ca819c26834bf3ce47f5de6621307c1ecf0ed38aa420142414496ebf1045922fb3d8667f820007235bc27b22730a336a1c11c57009301f961db0a830ce04447d0193776304f759b348f66392cc972a9972c2bb397c853fd79e733c4f9d9526ec80248b8263b544996221f2a69e176bbd11fd4f9b32ab4b040dcf901f431befaca8c4b3ce55e592052117262d2d20bae7c543d88f38d86508de4067081b81dce2cec6e7632bcf361874fc3c4ed3284189e42e5070ca943eb83d7b2649c99560de341d6a4ce08afeee81774e4827bcaf840cc8e2798a55f43e51feacca16ff15b2571e997749964bf9e0e1e3f7b929e30b"

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

