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
nomprograma=$0
slash=$(echo "$nomprograma"| $PrPWD/stdbuscaarg_donde_hasta "/" )
while [ -n "$slash" ];do
    nomprograma=$(echo "$nomprograma"| $PrPWD/stdcdr "/" )
    slash=$(echo "$nomprograma" | $PrPWD/stdbuscaarg_donde_hasta "/" )
done
cd $PrPWD
PrPWD2=$PWD
PrPWD=$PrPWD2
cd $PaPWD
sleep 1
touch "$nomprograma.memoria"
listados="";
listado="";
eyedirectory="$PrPWD/users/input"
mouthdirectory="$PrPWD/users/processed"
if [ ! -d "$mouthdirectory" ];then
    mkdir $mouthdirectory
fi
remotepath=$(cat $PrPWD/host.c|$PrPWD/stddeclaracionesdevariable | $PrPWD/stdcdr host|$PrPWD/stdcdr = |$PrPWD/stdcdr '"'|$PrPWD/stdcarsin '"')
if [ -d "$eyedirectory" ];then
    listado=$(echo "$eyedirectory"|$PrPWD/listadodirectorio_dirs_from_std|tr '
' ';')
    salta=0;
    utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    while [ -f "$PaPWD/$utcc.c" ];do
	utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    done
    forfiles=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    while [ -f "$PaPWD/$forfiles.c" ];do
	forfiles=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
    done	
    while [ -n "$listado" ];do
	dirn=$(echo -n "$listado"|$PrPWD/stdcarsin ';')
	cat $PrPWD/listadodirectorio_files_from_mem_extension_c.c | $PrPWD/stdcar " buffer[" > "$PaPWD/$utcc.c"
	len=$(echo "$dirn"|wc -c|$PrPWD/stdcarsin ' ')
	echo "$len ]=\"$dirn\";" >> "$PaPWD/$utcc.c"
	cat $PrPWD/listadodirectorio_files_from_mem_extension_c.c | $PrPWD/stdcdr " buffer[" | $PrPWD/stdcdr ";" |  $PrPWD/stdcar " compare["  >> "$PaPWD/$utcc.c"
	len=$(echo "$mouthdirectory"|wc -c | $PrPWD/stdcarsin ' ' )
	echo "$len]=\"$mouthdirectory\";" >> "$PaPWD/$utcc.c"
	cat $PrPWD/listadodirectorio_files_from_mem_extension_c.c | $PrPWD/stdcdr " compare[" | $PrPWD/stdcdr ";" >> "$PaPWD/$utcc.c"
	errores=$(gcc -o "$PaPWD/$utcc" "$PaPWD/$utcc.c" 2>&1)
	if [ -n "$errores" ];then
	    echo "$errores"
	    $0&
	    exit
	fi
	len=$($PaPWD/$utcc| $PrPWD/stdcdr "files[" |$PrPWD/stdcarsin ']')
	if [ "0$len" -gt 1 ];then
	    cat $PrPWD/getregisteranlock.c | $PrPWD/stdcar " buffer[" > "$PaPWD/$forfiles.c"
	    register="$nomprograma.memoria"
	    len=$(echo "$register"|wc -c|$PrPWD/stdcarsin ' ')
	    echo "$len ]=\"$register\";" >> "$PaPWD/$forfiles.c"
	    cat $PrPWD/getregisteranlock.c | $PrPWD/stdcdr " buffer[" | $PrPWD/stdcdr ";" |  $PrPWD/stdcar " files["  >> "$PaPWD/$forfiles.c"
	    $PaPWD/$utcc | $PrPWD/stdcdr " files[" | $PrPWD/stdcar ";" >> "$PaPWD/$forfiles.c"
	    cat $PrPWD/getregisteranlock.c | $PrPWD/stdcdr " buffer[" | $PrPWD/stdcdr ";" |  $PrPWD/stdcdr " files[" |  $PrPWD/stdcdr ";" >> "$PaPWD/$forfiles.c"
	    errores=$(gcc -o "$PaPWD/$forfiles" "$PaPWD/$forfiles.c" 2>&1)
	    if [ -n "$errores" ];then
		echo "$errores"
		$0&
		exit
	    fi
	    listf=$($PaPWD/$forfiles 2>&1|head -n1)
	    #echo ">>>>>>>>>> $litsf"
	    len=$($PaPWD/$forfiles|head -n2|wc -l |$PrPWD/stdcarsin ' ')
	    if [ "0$len" -gt 2 ];then
		listg=$($PaPWD/$forfiles|head -n2|head -n1)
		if [ -n "$listg" -a ! -f "$listg.lock" ];then
		    touch "$listg.lock"
		    $0 &
		    break;
		fi
	    fi
	fi
	rm $PaPWD/$forfiles $PaPWD/$forfiles.c $PaPWD/$utcc $PaPWD/$utcc.c 2>/dev/null
	listado=$(echo -n "$listado" | $PrPWD/stdcdr ";")
    done
fi
$0 &
if [ -n "$listf" -a -f "$listf" ];then
    fn=$listf
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	fn2="$fn"
        echo "............  fn2 = $fn2"
	while [ -n "$slash" ];do
	    fn2=$(echo -n "$fn2" | $PrPWD/stdcdr "/" )
	    slash=$(echo -n "$fn2" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
	dirfn=$(echo -n "$fn"|$PrPWD/stdcarsin "/$fn2")
	mkdir "$dirfn/data"
	dirfn=$(echo -n "$dirfn/data" )
	len=$(cat "$fn"|wc -c|tr -d ' '|tr -d '
')
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - $closs)
	    echo "$len $balan $opens-$closs $mains"
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
		errores=$(gcc "$fn" 2>&1 )
		if [ -z "$errores" ];then
		    variables=$(cat "$fn" |$PrPWD/stddeclaracionesdevariable|tr '
' ';')
		    varos="";
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_nameofindex")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			#echo "$varos"
		    else
			echo ";$fn2;" >> $nomprograma.memoria
			exit 0
		    fi
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_command")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			echo ";$fn2;" >> $nomprograma.memoria
			exit 0
		    fi		    
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_content")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			echo ";$fn2;" >> $nomprograma.memoria
			exit 0
		    fi
		    echo "variables passed"
		    if [ "$varos" = "***" ];then
			rm -v "$tempf"
			echo ";$fn2;" >> $nomprograma.memoria
		        command=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_command["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
			echo "COMMAND $command";			
		        name=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_nameofindex["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' | sed 's/%\([0-9A-Fa-f][0-9A-Fa-f]\)/\\x\1/g' | xargs -0 echo -e)
			echo ";$fn2;" >> $nomprograma.memoria
			namepublic=$(echo "$name public"| tr -d ' ' | sha512sum | $PrPWD/stdcarsin ' ')
			echo "NAME    $name"
			echo "PUBLIC  $namepublic"
			echo $remotepath
			respuestaa=$(curl -L "$remotepath/fretfile.php?fname=$name&nocontent=true" 2>/dev/null | $PrPWD/stdcdr '"'  | $PrPWD/stdcarsin '"' )
			respuestab=$(curl -L "$remotepath/fretfile.php?fname=$namepublic.js&nocontent=true" 2>/dev/null | $PrPWD/stdcdr '"'  | $PrPWD/stdcarsin '"' )
			respuesta=$(echo "$respuestaa $respuestab")
			encuentrac=$(echo "$command" |$PrPWD/stdbuscaarg 'REGISTER')
			encuentra=$(echo "$respuesta" |$PrPWD/stdbuscaarg 'Not Found Not Found')
			echo "R $respuesta C $encuentrac E $encuentra"
			if [ -n "$encuentra" -a -n "$encuentrac" ] ; then
			    echo -n ";$variables"     |$PrPWD/stdcdr "char prefix_content["     |$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"'
			    echo "......................................................."
		            content2=$(echo -n ";$variables"     |$PrPWD/stdcdr "char prefix_content["     |$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' | base64 -d )
			    encuentra=$(echo "$content2"|$PrPWD/stdbuscaarg '*/')
			    if [ -n "$encuentra" ];then
				content=$(echo "/*$content2" | $PrPWD/stddeclaracionesdevariable_tojs | tr -d '
' | base64 | tr -d '
' )
			    else
				content=$(echo -n ";$variables"     |$PrPWD/stdcdr "char prefix_content["     |$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
			    fi
			    contentExtra=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_contentExtra["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' )
			    if [ "$contentExtra" ];then
				echo "::>> . . . $(echo $contentExtra|wc)  <<<<<<<<<<<<<<<<<::"
				echo "::>> . . . ($name $namepublic) "
				name=$(echo "$name" | sed -e 's/ /%20/g' -e 's/:/%3A/g' -e 's/,/%2C/g' -e 's/;/%3B/g' -e 's/\[/%5B/g' -e 's/\]/%5D/g' -e 's/{/%7B/g' -e 's/}/%7D/g' -e 's/(/%28/g' -e 's/)/%29/g' -e 's/\*/%2A/g' -e 's/&/%26/g' -e 's/\^/%5E/g' -e 's/%/%25/g' -e 's/\$/%24/g' -e 's/@/%40/g' -e 's/!/%21/g' -e 's/~/-%7E/g' -e 's/-/%2D/g' -e 's/_/%5F/g' -e 's/>/%3E/g' -e 's/</%3C/g' -e 's/\?/%3F/g' -e 's/\//%2F/g' )
				echo " ... $name <<::"
				msg=$(echo -n "$content" | openssl dgst -sha256  -keyform PEM -sign $PrPWD/user/private.pem | base64 | tr -d '
')
				msgExtra=$(echo -n "$contentExtra" | openssl dgst -sha256  -keyform PEM -sign $PrPWD/user/private.pem | base64 | tr -d '
')
				datee=$(date -u '+%Y-%m-%d %H:%M')
				echo "$datee"
				datesigned=$(echo -n "$datee" |  openssl dgst -sha256  -keyform PEM  -sign $PrPWD/user/private.pem | base64 | tr -d '
')
				curl -X POST -L "$remotepath/upp.php" -F "namo=\"$name\""       -F "signature=\"$msg\""      -F "content=\"$content\""      -F "datesigned=\"$datesigned\"" -F "submit=submit"
				echo "><><><><"
				curl -X POST -L "$remotepath/upp.php" -F "namo=\"$namepublic.js\"" -F "signature=\"$msgExtra\"" -F "content=\"$contentExtra\"" -F "datesigned=\"$datesigned\"" -F "submit=submit"
				exit
			    fi
			fi
			echo "$command"
			encuentrac=$(echo "$command" |$PrPWD/stdbuscaarg 'APPEND')
			if [ -n "$encuentrac" ] ; then
			    content=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$PaPWD/$content" ];do
				content=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done
		            echo -n ";$variables"     |$PrPWD/stdcdr "char prefix_content["     |$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' > "$PaPWD/$content"
			    echo "CONTENT $content";
			    count=1
			    encuentra=""
			    echo ">>> A P P E N D <<<"
			    sha=""
			    curl -L "$remotepath/flastfile.php?sha=$name&count=1"
			    count=$(curl -L "$remotepath/flastfile.php?sha=$name&count=1" 2>/dev/null | $PrPWD/stdcdr 'count=' | $PrPWD/stdcarsin '&'|$PrPWD/stdcarsin ";")
			    sha=$(echo "$name $count"| tr -d " " | tr -d '
' | sha512sum | $PrPWD/stdcarsin " ")
			    echo "COUNT $count"
			    name="$sha.js"
			    echo ">>>> $name ($count)"
			    msg=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$PaPWD/$msg" ];do
				msg=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done
			    cat "$PaPWD/$content" | openssl dgst -sha256  -keyform PEM -sign $PrPWD/user/private.pem | base64 | tr -d '
' > "$PaPWD/$msg"
			    datee=$(date -u '+%Y-%m-%d %H:%M')
			    echo "$datee"
			    datesigned=$(echo -n "$datee" |  openssl dgst -sha256  -keyform PEM  -sign $PrPWD/user/private.pem | base64 | tr -d '
')
			    curl -X POST -L "$remotepath/uppFile.php" -F "namo=\"$name\"" -F "signature=@$PaPWD/$msg" -F "content=@$PaPWD/$content"  -F "datesigned=\"$datesigned\"" -F "submit=submit" >> "$PaPWD/$content.out"
			    rm  "$PaPWD/$content" "$PaPWD/$msg"
			    exit
			fi
		    else
			echo ";$fn2;" >> $nomprograma.memoria
			echo "I R"
		    fi
		fi		
	    fi
	fi
    fi
fi
rm -v "$listf.lock" 2>/dev/null
