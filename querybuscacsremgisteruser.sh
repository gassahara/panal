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
#echo "$nomprograma.."
sleep 2
listados="";
listado="";
remotepath="http://127.0.0.1/" #"185.27.134.11/htdocs"
if [ -d "$PrPWD/users/input" ];then
    listados=$(echo $PrPWD/users/input|$PrPWD/listadodirectorio_dirs_from_std|$PrPWD/stdbuscaarg_donde '
')
    listado=$(echo $PrPWD/users/input|$PrPWD/listadodirectorio_dirs_from_std)
    salta=0;
    while [ -n "$listados" ];do
	presalta=$(echo -n "$listados" | $PrPWD/stdcar " ")
	dirn=$(echo -n "$listado"|$PrPWD/stdcdrn 0$salta | $PrPWD/stdcarn $presalta)
	lista1=$(echo "$dirn" | $PrPWD/listadodirectorio_files_from_std_extension_c )
	lista2=$(echo -n "$lista1
$lista0" )
	lista0=$lista2
	salta=$(expr $presalta + 1)
	listados=$(echo -n "$listados" | $PrPWD/stdcdr " ")
    done
fi
busca=".."
posicion=0;
dondes=$( echo "$lista0" |$PrPWD/stdbuscaarg_donde "
")
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=""
    if [ -n "$listf" ];then
	chacha=$(cat "$listf"|sha512sum|$PrPWD/stdcarsin ' ')
    fi
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -z "$encuentra" ];then
    echo ";$listf;$chacha;" >> $nomprograma.memoria
fi
ps1=1
while [ -f "$nomprograma.lock-$ps1" ];do
    if [ 0$ps1 -lt 3 ];then
	echo "W W W W W W W W W W W W W   $ps1"
	ps1=$(expr 0$ps1 + 1)
    else
	ps1=1
	sleep 1
    fi
done
    $0 &
if [ -z "$encuentra" -a -n "$listf" ];then
    fn=$listf
#    echo "<< fn $fn >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	fn2="$fn"
	while [ -n "$slash" ];do
	    fn2=$(echo -n "$fn2" | $PrPWD/stdcdr "/" )
	    slash=$(echo -n "$fn2" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
	dirfn=$(echo -n "$fn"|$PrPWD/stdcarsin "/$fn2")
	mkdir "$dirfn/data"
	dirfn=$(echo -n "$dirfn/data" )
    	echo "0 $busca ($fn2) $dirfn"
	len=$(cat "$fn"|wc -c|tr -d ' '|tr -d '
')
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - $closs)
	    echo "$len $opens-$closs"
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		ejec="$fn.$nomprograma.bin"
		echo "E: $ejec"
		errores=$(gcc -o "$ejec" "$fn" 2>&1 )
		if [ -z "$errores" ];then
		    utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
		    while [ -f "$dirfn/$utcc.c" ];do
			utcc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
		    done
		    variables=$(cat "$fn" |$PrPWD/stddeclaracionesdevariable|tr '
' ';')
#		    echo ">>>>>>>>>    $variables <<<<<<<<<<<<<<<<<" 
		    varos="";
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_nameofindex")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_command")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi		    
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_content")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables passed"
		    if [ "$varos" = "***" ];then
#			echo "varos passed; $variables"
		        command=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_command["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
			echo "COMMAND $command";			
		        name=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_nameofindex["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' | sed 's/%\([0-9A-Fa-f][0-9A-Fa-f]\)/\\x\1/g' | xargs -0 echo -e)
			namepublic=$(echo "$name public"| tr -d ' ' | sha512sum | $PrPWD/stdcarsin ' ')
			echo "NAME    $name"
			echo "PUBLIC  $namepublic"
			respuestaa=$(curl -L "$remotepath/fretfile.php?fname=$name" 2>/dev/null | $PrPWD/stdcdr '"'  | $PrPWD/stdcarsin '"' )
			respuestab=$(curl -L "$remotepath/fretfile.php?fname=$namepublic.js" 2>/dev/null | $PrPWD/stdcdr '"'  | $PrPWD/stdcarsin '"' )
			respuesta=$(echo "$respuestaa $respuestab")
			encuentrac=$(echo "$command" |$PrPWD/stdbuscaarg 'REGISTER')
			encuentra=$(echo "$respuesta" |$PrPWD/stdbuscaarg 'Not Found Not Found')
			echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   $respuesta   ($encuentra $encuentrac) ($namepublic)"
			if [ -n "$encuentra" -a -n "$encuentrac" ] ; then
			    echo -n ";$variables"     |$PrPWD/stdcdr "char prefix_content["     |$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"'
			    echo "......................................................."
		            content2=$(echo -n ";$variables"     |$PrPWD/stdcdr "char prefix_content["     |$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' | base64 -d )
			    echo "CONTENT $content2 <<<"
			    encuentra=$(echo "$content2"|$PrPWD/stdbuscaarg '*/')
			    if [ -n "$encuentra" ];then
				content=$(echo "/*$content2" | $PrPWD/stddeclaracionesdevariable_tojs | tr -d '
' | base64 | tr -d '
' )
			    else
				content=$(echo -n ";$variables"     |$PrPWD/stdcdr "char prefix_content["     |$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
			    fi
			    echo "CONTENT $content";
		            contentExtra=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_contentExtra["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' )
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
			echo "$command"
			encuentrac=$(echo "$command" |$PrPWD/stdbuscaarg 'APPEND')
#			encuentra=$(echo "$respuesta" |$PrPWD/stdbuscaarg 'Success Success')
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
			    count=$(curl -L "$remotepath/flastfile.php?sha=$sha.js&count=1" 2>/dev/null | $PrPWD/stdcdr 'count=' | $PrPWD/stdcarsin '&')
			    echo "COUNT $count"
			    sleep 10
			    while [ -z "$encuentra" ];do
				sha=$(echo "$name $count"| tr -d " " | tr -d '
' | sha512sum | $PrPWD/stdcarsin " ")
#				echo ">>>> $sha $count <<::"
				respuesta=$(curl -L "$remotepath/fretfile.php?fname=$sha.js&nocontent=true" 2>/dev/null)
				encuentra=$(echo "$respuesta" |$PrPWD/stdbuscaarg 'Not Found')
				count=$(expr "$count" + 1)
				echo "count $count name $sha from $name"
			    done			    
			    echo " ...................... "
#			    echo ">>>> $name ($count)"
			    name="$sha.js"
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
			    curl -vvvv -X POST -L "$remotepath/uppFile.php" -F "namo=\"$name\"" -F "signature=@$PaPWD/$msg" -F "content=@$PaPWD/$content"  -F "datesigned=\"$datesigned\"" -F "submit=submit"
			    exit
			fi
		    fi
		fi
	    fi
	fi
    fi
fi
