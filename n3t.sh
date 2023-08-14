reit=$(cat "$1.req" | /var/www/html/nube/stdhttpgetfilehtml )
if [ -n "$reit" ];then
    rec=$(cat "$1.in" | /var/www/html/nube/stdhttpcontent)
    if [ -n "$rec" ];then
	echo "TEXTO 1 >$1<"
	rr=""
	while [ -z $(cat $1.in | /var/www/html/nube/stdhttpcontentsize) ];do
	    echo -n "((()"
	    cat $1.in | /var/www/html/nube/stdhttpcontentsize
	    sleep 0.5
	done
	cat $1.in | /var/www/html/nube/stdhttpcontentsize 1>$1.rer
	echo "#####"

     nn2=$(echo $1 | /var/www/html/nube/stdcdr "$PWD/" )
	cuan=$(echo "$1" | /var/www/html/nube/stdbuscaarg_count "/")
	quita0a=" "
	while [ 0$cuan -gt 0 ];do
	    quita0a="$quita0a | /var/www/html/nube/stdcdr / "
	    cuan=$((cuan-1))
	done
	cc=$(echo "echo \"$1\" $quita0a | /var/www/html/nube/stdcarsin \".sh\" ")
	noo=$(eval $cc )

#	html1="<HTML><BODY > <iframe style=\"width:99%;height:99%;\"  src=\"$nn2.html\"></iframe> </BODY></HTML>"
	echo "function a$noo() { if(document.getElementsByTagName('a')) { if(document.getElementsByTagName('a').length<1) window.location.href='$nn2.html'; } } " > $nn2.js
	echo "<HTML><HEAD><SCRIPT src=$nn2.js></SCRIPT></HEAD><BODY onload=\"setTimeout(function(){ a$noo() ; }, 3000);\"> <p> $nn2 Espere un momento ... </p> </body></html>" > $nn2.html
	html1="<HTML><HEAD><SCRIPT src=$nn2.js></SCRIPT></HEAD><BODY onload=\"setTimeout(function(){ a$noo() ; }, 3000);\"> <p> $nn2 . Espere un momento ... </p> </body></html>"
	cuantos=$(echo "$html1" | wc -c )
	echo -e "HTTP/1.1 200 OK\r\nContent-Length: $cuantos\r\nContent-Type: text/html;\r\n\r\n$html1"  > $1.out
	while [ -f "$1.out" ];do
	    sleep 0.1
	    campo=1
	done
	echo "/////"

	campof=$(cat $1.in | /var/www/html/nube/stdhttpcontent | /var/www/html/nube/stdcdr "boundary=" | /var/www/html/nube/stdcarsin $'\r' )
	echo "<$campof>"
	mkdir posts
	mkdir posts/$1
	cadena="/var/www/html/nube/stdcdr \"$campof\" "
	estaenboundary=$(cat $1.in | eval $cadena  | /var/www/html/nube/stdbuscaarg "$campof" )
	if [ -n $estanebounmdary ];then
	    cp -v $1.in $1.post
	fi
	echo "((____ $estaenboundary ))"
	rm -v $1.?n $1.re? 
	kill $noo
    fi
fi
