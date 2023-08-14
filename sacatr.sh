campof="<tr "
skips=0
cadena="./stdcdr \"$campof\" "
estaenboundary=$(cat $1 | eval $cadena  | ./stdbuscaarg "$campof" )
i=1
n=0
nombre=$(echo $1 | ./stdcdr "$PWD/" | ./stdcarsin ".post" )
cadeneval=""
if [ ! -f $0.pso ];then
    echo 1 > $0.pso
    el=0;
    skips=$(dd if=$1 bs=1  | ./stdbuscaarg_donde_hasta "$campof" )
    skips=$(dd if=$1 bs=1  | ./stdbuscaarg_donde_hasta "$campof" )
    while [ -n "$estaenboundary" ];do
	skipo=$skips
	skips=$(dd if=$1 bs=1 skip=$skips | ./stdbuscaarg_donde_hasta "$campof" )
	skips=$(echo "$skips+$skipo" | bc)
	echo "------------------------------------------"
	echo "$campof"
	echo "------------------------------------------"
	campo=$(dd if=$1 bs=1 skip=$skips | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcar $'\r\n\r\n' | ./stdcdr "name=\"" | ./stdcarsin $'"' )
	echo -e "\n\n:: $campo $skips :::::::::::::::::::::::::::::::::"
	con=$( dd if=$1 bs=1 skip=$skips  | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcar $'\r\n\r\n'  | ./stdcdr "Content-Disposition: " | ./stdcarsin ";")
	sleep 10
	if [ "$campo" = "elemento" ];then
	    elemento=$(dd if=$1 bs=1 skip=$skips  | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcdr $'\r\n\r\n' | ./stdcarsin $'\r'  | ./stdcarsin $'\n' )
	    pasa=$(cat elementos.txt | ./stdbuscaarg "$elemento" )
	    if [ -n "$pasa" ];then
		n=$((n+1))
	    fi
	    echo -n "E: $elemento" 
	fi
	if [ "$campo" = "cantidad" ];then
	    cantidad=$(dd if=$1 bs=1 skip=$skips  | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcdr $'\r\n\r\n' | ./stdcarsin $'\r'  | ./stdcarsin $'\n' )
	    echo "$cantidad" | ./stdbuscaarg " "
	    pasa=$(echo "$cantidad" | ./stdbuscaarg " " )
	    if [ -n "$pasa"  ];then
		unit=$(echo "$cantidad" | ./stdcdr " " )
		if [ -n "$unit" ];then
		    if [ -f "$unit.sh" ];then
			ejec="./$unit.sh "
			echo ":: $ejec "
		    fi
		fi
	    fi	    
	    n=$((n+1))
	fi
	if [ "$campo" = "unidad" ];then
	    if [ -z "$ejec" ];then
		unit=$(dd if=$1 bs=1 skip=$skips  | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcdr $'\r\n\r\n' | ./stdcarsin $'\r'  | ./stdcarsin $'\n' )
		if [ -n "$unit" ];then
		    if [ -f "$unit.sh" ];then
			ejec="./$unit.sh "
		    fi
		fi
		n=$((n+1))
	    fi
	fi
	if [ "$campo" = "operator" ];then
	    operator=$(dd if=$1 bs=1 skip=$skips  | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcdr $'\r\n\r\n' | ./stdcarsin $'\r'  | ./stdcarsin $'\n' )
	    operador=""
	    if [ "$operator" = "add" ];then
		operador="+"
	    fi
	    if [ "$operator" = "+" ];then
		operador="+"
	    fi
	    if [ "$operator" = "remove" ];then
		operador="-"
	    fi
	    if [ "$operator" = "-" ];then
		operador="-"
	    fi
	    if [ -n "$operador" ];then
		n=$((n+1))
	    fi
	fi
	if [ "$campo" = "fname" ];then
	    fname=$(dd if=$1 bs=1 skip=$skips  | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcdr $'\r\n\r\n' | ./stdcarsin $'\r'  | ./stdcarsin $'\n' )
	    n=$((n+1))
	fi
	if [ "$campo" = "check" ];then
	    check=$(dd if=$1 bs=1 skip=$skips  | ./stdcarsin "$campof" | ./stdcarsin "---" | ./stdcdr $'\r\n\r\n' | ./stdcarsin $'\r'  | ./stdcarsin $'\n' )
	    elementos="$elementos,h$el,$check,"
	    n=$((n+1))
	fi
	estaenboundary=$(dd if=$1 bs=1 skip=$skips   | ./stdbuscaarg "$campof" )
	echo ">->->- $i $campo"
	i=$((i+1))
    done

    if [ -n "$elemento" -a -n "$cantidad" ];then	
	fecha=$(date)
	ejec="$ejec $cantidad"
	echo "$ejec"
	cantidad=$(eval $ejec)
	cadeneval="a=a $operador $cantidad; a;/*$elemento*/ /* $fecha $fname */"
	echo "===="
	aa=0
	./listadodirectorio_files > $nombre.lis
	na1=$(cat $nombre.lis | ./stdbuscaarg ".bc")
	saldom=0
	if [ -n "$na1" ];then
	    cat $nombre.lis | ./stdbuscaarg_donde ".bc" > $nombre.lnn
	    cat $nombre.lis | ./stdbuscaarg_donde $'\n' > $nombre.ln2
	    nn=1
	    p=0
	    ss=0
	    sss=0
	    ss2=$(cat $nombre.lnn  | ./stdbuscaarg_donde_hasta " ")
	    sa=0
	    nn=$(dd if=$nombre.lnn bs=1 skip=$ss count=$ss2 2>/dev/null )
	    pp=0
	    while [ 0$nn -gt 0 ];do
		nnp=$nn2
		while [ 0$nn2 -lt $nn ];do
		    nnp=$nn2
		    sss2=$(dd if=$nombre.ln2 bs=1 skip=0$sss  2>/dev/null | ./stdbuscaarg_donde_hasta " ")
		    nn2=$(dd if=$nombre.ln2 bs=1 skip=0$sss count=0$sss2 2>/dev/null )
#		    echo ". $nn2 . (sss=$sss;sss2=$sss2) nn=$nn"
		    sss=$((sss+sss2))
		    if [ -z "$nn2" ];then
			nn2=$((nn+1))
		    fi
		done
		scc=$(echo "0$nn-0$nnp" | bc )
		fnnn=$(dd if=$nombre.lis bs=1 skip=$nnp count=$scc 2>/dev/null )
		echo " .. $sa nnp=$nnp nn=$nn scc=$scc : $fnnn "
		cadf=$(cat $fnnn | ./stdbuscaarg "/*$elemento*/" )
		if [ -n "$cadf" ];then
		    saldof=$(cat $fnnn | bc -l )
		    saldom=$(echo "$saldom+$saldof" | bc -l)
		fi
		ss=$((ss+ss2))
		ss2=$(dd if=$nombre.lnn bs=1 skip=$ss 2>/dev/null | ./stdbuscaarg_donde_hasta " " )
		sa=$((sa+1))
		nn=$(dd if=$nombre.lnn bs=1 skip=$ss count=$ss2 2>/dev/null )
	    done
	fi

	cadena=""
	cadena="$cadena | ./stdcarsin ' ' "
	cc="cat $nombre.lis $cadena | ./stdcarsin .in | ./stdbuscaarg_count \$'\n'"
	cuan=$(eval $cc)
	quita0a=" "
	while [ 0$cuan -gt 0 ];do
	    quita0a="$quita0a | ./stdcdr \$'\n' "
	    cuan=$((cuan-1))
	done
	cc="cat $lll $cadena $quita0a  | ./stdcarsin .in "
	fn=$(eval $cc)

	
	saldof=$(echo "$cadeneval" | bc -l )
	saldom=$(echo "saldom+$saldof" | bc -l )
	echo "$cadeneval"
	echo "$cadeneval" > $nombre.bc

	echo "$nombre : $user : $pass "
	echo "<HTML><HEAD><SCRIPT src=$nombre.js></SCRIPT></HEAD><BODY onload=\"setTimeout(function(){ a$nombre() ; }, 3000);\"> <div> " > $nombre.html
	echo "function a$nombre() { if(document.getElementsByTagName('div')) {if(document.getElementsByTagName('div').length>0) {if(document.getElementsByTagName('div')[0].innerHTML.indexOf('$elemento')>=0) {if(document.getElementsByTagName('div')[0].innerHTML.indexOf('$fecha')>0) { cadena=document.getElementsByTagName('div')[0].innerHTML; document.write(cadena); cadena=null; } else window.location.href='$nombre.html'; } else window.location.href='$nombre.html'; } else window.location.href='$nombre.html'; } else window.location.href='$nombre.html'; } " > $nombre.js
	echo "AHORA HAY $saldom de $elemento </div></BODY></HTML>" >> $nombre.html
	echo "function a$nombre() { return true; } " > $nombre.js
	echo "DONE!"

	file="$1"
	while [ -n $(echo "$file" | ./stdbuscaarg ".post" ) ];do
	    file2=$(echo "$file" | ./stdcdr ".post" )
	    file=$(echo "$file" | ./stdcarsin ".post" )
	    file="$file-post$file2"
	done
	mv $1 $file
    fi
    sleep 1
    rm $0.pso
fi

