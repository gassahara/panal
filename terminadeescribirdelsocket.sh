#!/bin/bash
listasocket=""
echo ">>$0<<<"
nf=$(echo $0 | wc -c)
nd=$((nf-1))
while [ "$nd" -gt "1" ];do
    fn=$0
    if [ "$(echo $0 | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
	ng=$nd;
	fn=$(echo $0 | dd bs=1 count=$ng  2>/dev/null)
    fi
    nd=$((nd-1))
done
patho=$fn
while read listso;do
    listasocket="$listasocket $listso\n"
done < <(bash $patho/escribearchivodesocket.sh)
p=1
puerto=""
while read r;do
    while read rr;do
	if [ -n "$r" ];then
	    if [ -n "$rr" ];then
		if [ "$rr" != "$r" ];then
		    $patho/escribearchivodesocket $rr $r
		    echo . $rr . $r .
		fi
	    fi
	fi	
    done < <(echo -e "$listasocket")
done < <(echo -e "$listasocket")

while read c;do
    g=$(cat $c)
    f=$(cat $c | grep -o --color "void [^(]*([^)]*)[ ]{\|char [^(]*([^)]*)[ ]{\|int [^(]*([^)]*)[ ]{"  | grep -v main)
    tipo=$(echo $f | cut -d " " -f1)
    caracter=""
    case "$tipo" in
	double|float)
	    caracter="%06f"
	    ;;
	int|longint|long)
	    caracter="%04d"
	    ;;
	char|string)
	    caracter="%0s"
	    ;;
	*)
	    caracter="tiponodefinido"
    esac
		
    f=$(echo $f | sed "s/{\|void\|double\|int\|char//g; s/\[\|\]\|\*//g ");
    echo "$f <> $tipo ..."
    h=$(echo "$f" | cut -d "(" -f1)
    echo "grep \"$tipo $h\""
#    if [ -n "$(echo $g | grep \"$tipo $h\" )" ];then
#	g="$g printf(\"\n$h=$caracter;\", $f);return 0; }"
#    else
#	g="$g printf(\"\n$tipo $h=$caracter;\", $f);return 0; }"
    #    fi
    j=$(echo $f | cut -d "(" -f1)
    jj=$j
    main=$(echo $g | grep "main[^{]*{*" | grep "$j")
    while [ -n "$main" ];do
	j=$(echo -n "$j" && echo "W")
	echo "$j"
	main=$(echo $g | grep "main[^{]*{*" | grep "$j")
    done
    g=$(echo "$g" | sed -e "s/$jj(/$j\(/g")
    f=$(echo "$f" | sed -e "s/$jj(/$j\(/g")
    
    g="$g printf(\"<tr><td colspan=20>\");printf(\"\n</td></tr><tr><td>$h</td><td>$caracter</td></tr>\n\", $f);return 0; }"
    c=$(echo "$c" | sed "s/\.txt//g")
    echo "$g" > "$c.c"
    echo -e "------\n $c.c --\n"
    rm -v $c
    gcc -o $c $c.c
    echo $0
done< <(ls -1 *$1-*.txt)
resultado=""
rm resultado.html
touch resultado.html
while read e;do
    if [ -z "$resultado" ];then
	resultado="<HTML><BODY><TABLE>"
    fi
    if [ -f "$e" ];then
    if [ -x "$e" ];then
	resultado="$resultado<tr><th>$e</th></tr>$($e)" >> resultado.html
	echo "<hr>$resultado<br>" >> resultado.html
	resultado=" "
    fi
    fi
done< <(find -executable)
