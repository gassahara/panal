#!/bin/bash
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
pasa=0
if [ -z "$1" -o 0$1 -eq 0 ];then
    sleep 0.05
    ps1=3
    nomprograma=$0
    nc=$(echo $nomprograma|$PrPWD/stdbuscaarg_donde_hasta "/")
    while [ $nc -gt 0 ];do
    	nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
	nc=$(echo $nomprograma|$PrPWD/stdbuscaarg_donde_hasta "/")
	nc=$(echo "0$nc")
    done

    # while [ 0$ps1 -gt 4 ];do
    # 	ps1=$(ps -A -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
    # 	sleep 0.02
    # done
    
    lista=$($PrPWD/listadodirectorio_files_extension ".req"  |$PrPWD/stdtohex |sha256sum|$PrPWD/stdcarsin " " )
    pins=$(cat puntoreqs|sha256sum|$PrPWD/stdcarsin " " )
    if [ "$pins" = "$lista" ];then
	pasa=1
	$0 &
	disown
    else
	echo ...
	$PrPWD/listadodirectorio_files_extension ".req" |$PrPWD/stdtohex > puntoreqs
	pasa=0
    fi
fi
if [ 0$pasa -eq 0 ];then
    cuant=$($PrPWD/datapuntoreqcdrn 0$1 | $PrPWD/stdbuscaarg_donde_hasta 0A)
    if [ 0$cuant -gt 0 ];then
	cuant=$(echo $cuant+0$1|bc)
    else
	cuant=0;
    fi
    $0 "0$cuant" &
    disown
    sleep 0.05
    fn=$($PrPWD/datapuntoreqcdrn 0$1 | $PrPWD/stdcarn 0$cuant |$PrPWD/stdfromhex | $PrPWD/stdcarsin ".req" )
    pn=$(echo $fn | $PrPWD/stdcdr "$PaPWD/")
    if [ -n "$fn" ];then
	sha=$(cat "$fn.in" | sha256sum|$PrPWD/stdcarsin " " )
	shaf=$(cat procesados/*|$PrPWD/stdbuscaarg "$sha;$0;$fn;" )
	if [ -z "$shaf" ];then
    	    nomprograma=$fn
    	    while [ $(echo $nomprograma | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    		nomprograma=$(echo $nomprograma | $PrPWD/stdcdr "/" )
    	    done
    	    nn=$fn
    	    while [ $(echo $nn | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    		nn=$(echo $nn | $PrPWD/stdcdr "/" )
    	    done
    	    mkdir procesados
    	    echo "$sha;$0;$fn;" >> "procesados/$nomprograma"

	    cd $PrPWD
	    cad1=$(cat "$fn.req" | ./stdhttpgetfilehtml )
	    cd $PaPWD
	    cad2=$(cat "$fn.in" | $PrPWD/stdhttpcontent)
	    if [ -n "$cad1" -a -n "$cad2" ];then
		cd $PrPWD
		cat "$fn.req" | ./stdhttpgetfilehtml
		cd $PaPWD
		echo "TEXTO 1 >$fn<"
		rr=""
		cd $PrPWD
		cad1=$(cat $fn.in | ./stdhttpcontentsize)
		cd $PaPWD
		echo "ESPERANDO..."
		while [ -z "$cad1" ];do
		    cd $PrPWD
		    cad1=$(cat $fn.in | ./stdhttpcontentsize )
		    cd $PaPWD
		    sleep 0.01
		done
		echo "COMPLETO"
		echo "function a$nn() { if(document.getElementsByTagName('a')) { if(document.getElementsByTagName('a').length<1) window.location.href='$nn.html'; } } " > $nn.js
		echo "<HTML><HEAD><SCRIPT src=\"$nn.js\"></SCRIPT></HEAD><BODY onload=\"setTimeout(function(){ a$nn() ; }, 3000);\"> <p> pId=$nn Espere un momento ... </p> </body></html>" > $nn.html
		# html1="<HTML><HEAD><SCRIPT src=$nn2.js></SCRIPT></HEAD><BODY onload=\"setTimeout(function(){ a$noo() ; }, 3000);\"> <p> $nn2 . Espere un momento ... </p> </body></html>"

		# dato=$(date +%M%S%N%d%m%Y)
		# dato=$(echo "but$dato")
		# html0=$(cat $PrPWD/n2qt2.html | $PrPWD/stdcarsin "b1")
		# html1=$(cat $PrPWD/n2qt2.html | $PrPWD/stdcdr "b1")
		# html0=$(echo "$html0$dato$html1")
		# html1=$(echo "$html0" | $PrPWD/stdcarsin "b1")
		# html2=$(echo "$html0" | $PrPWD/stdcdr "b1")
		# html0=$(echo "$html1$dato$html2")
		# html1=$(echo "$html0" | $PrPWD/stdcarsin "b1")
		# html2=$(echo "$html0" | $PrPWD/stdcdr "b1")
		# html0=$(echo "$html1$dato$html2")
		# dato=$(echo "fra$dato")
		# html1=$(echo "$html0" | $PrPWD/stdcarsin "framer")
		# html2=$(echo "$html0" | $PrPWD/stdcdr "framer")
		# html0=$(echo "$html1$dato$html2")
		# html1=$(echo "$html0" | $PrPWD/stdcarsin "framer")
		# html2=$(echo "$html0" | $PrPWD/stdcdr "framer")
		# html0=$(echo "$html1$dato$html2")
		# html1=$(echo "$html0" | $PrPWD/stdcarsin "data/nn.html")
		# html2="data/$nomprograma.html"
		# html3=$(echo "$html0" | $PrPWD/stdcdr "data/nn.html")
		# cuantos=$(echo "$html1$html2$html3" | wc -c )
		# echo -e "HTTP/1.1 200 OK\r\nContent-Length: $cuantos\r\nContent-Type: text/html;\r\n\r\n$html1$html2$html3"  > $fn.out

		cuantos=$(echo "data/$nn.html" | wc -c )
		echo -e "HTTP/1.1 200 OK\r\nContent-Length: $cuantos\r\nContent-Type: text/html;\r\n\r\ndata/$nn.html"  > $fn.out
		pss="A"
			while [ -f "$pn.out" -a "$pss" != "Z" -a -n "$pss" ];do
			    sleep 0.03
			    echo -n "[$pss]"
			    pss=$(ps -A --no-headers -o "pid,state,command" | $PrPWD/stdcdr "$pn "|$PrPWD/stdcarsin " ")
			done
		echo "/////"
		campof=$(cat $fn.in | $PrPWD/stdhttpcontent | $PrPWD/stdcdr "boundary=" | $PrPWD/stdtohex | $PrPWD/stdcarsin 0A | $PrPWD/stdfromhex )
		echo "<$campof>"
		mkdir posts
		mkdir posts/$fn
		estaenboundary=$(cat $fn.in | $PrPWD/stdcdr "$campof"  | $PrPWD/stdbuscaarg "$campof" )
		if [ -n $estanebounmdary ];then
		    echo "$fn.in" | $PrPWD/stdtohex >> puntoposts
		fi
		echo "((____ $estaenboundary ))"
		kill $pn
		exit
	    fi
	fi
    fi
fi
