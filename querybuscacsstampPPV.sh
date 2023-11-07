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
 ps1=1
while [ -f "$nomprograma.lock-$ps1" ];do
    if [ 0$ps1 -lt 4 ];then
	echo "W W W W W W W W W W W W W   $ps1"
	ps1=$(expr 0$ps1 + 1)
    else
	ps1=1
	sleep 1
    fi
done
listados="";
listado="";
touch "$nomprograma.memoria"
eyedirectory="$PrPWD/users/input"
mouthdirectory="$PrPWD/users/processed"
if [ ! -d "$mouthdirectory" ];then
    mkdir $mouthdirectory 2>/dev/null
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
		exit
	    fi
	    listf=$($PaPWD/$forfiles|head -n1)
	    if [ "$listf" = "END/" ];then
		listf=""
	    fi
	    len=$($PaPWD/$forfiles|head -n2|wc -l |$PrPWD/stdcarsin ' ')
	    if [ "0$len" -gt 2 ];then
		listg=$($PaPWD/$forfiles|head -n2|head -n1)
		if [ -n "$listg" -a ! -f "$listg.lock" ];then
		    touch "$listg.lock"
		    $0&
		    break;
		fi
	    fi
	fi
	rm  $PaPWD/$forfiles $PaPWD/$forfiles.c $PaPWD/$utcc $PaPWD/$utcc.c 2>/dev/null
	listado=$(echo -n "$listado" | $PrPWD/stdcdr ";")
    done
fi
dirTokens="$PrPWD/users/tokens"
dirNewTokens="$PrPWD/users/tokensNew"
dirTokensDeleted="$PrPWD/users/tokensDeleted"
serverPublic=$PrPWD/users/serverPublic.txt
mkdir "$dirTokens" 2>/dev/null
mkdir "$dirNewTokens" 2>/dev/null
mkdir "$dirTokensDeleted" 2>/dev/null

$0&
if [ -n "$listf" -a -f "$listf" ];then
    fn=$listf
    len=$(wc -c "$listf" |$PrPWD/stdcarsin ' ')
    if [ 0$len -gt 1 ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	fn2="$fn"
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
#	    echo "$len $opens-$closs"
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		echo "0 $busca ($fn2) $dirfn"
		errores=$(gcc "$fn" 2>&1 )
		if [ -z "$errores" ];then
		    echo "$fn2;" >> $nomprograma.memoria
		    variables=$(cat "$fn"|$PrPWD/stddeclaracionesdevariable|tr '
' ';')
		    varos="";
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_nameofDestinatary")
		    echo "nameofDestinatary"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_nameofSignatary")
		    echo "nameofSignatary"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_command")
		    echo "command"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_content")
		    echo "content"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "long prefix_ammount")
		    echo "ammount"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    if [ "$varos" = "*****" ];then
			mv -v $listf $mouthdirectory/$fn2
			echo "varos passed;"
		        command=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_command["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
		        content=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_content["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
			echo "COMMAND $command";
		        ammount=$(echo -n ";$variables"|$PrPWD/stdcdr "long prefix_ammount="|$PrPWD/stdcarsin ";")
			echo "AMMOUNT $ammount";
		        nameDestinatary=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_nameofDestinatary["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' | sed 's/%\([0-9A-Fa-f][0-9A-Fa-f]\)/\\x\1/g' | xargs -0 echo -e)
			nameDestinataryRemote=$(echo "$nameDestinatary" | tr -d '
' | sha512sum | $PrPWD/stdcarsin ' ')
			nameDestinataryRemote=$(echo "$nameDestinataryRemote .js"|tr -d ' ')
			namepublicDestinataryRemote=$(echo "$name public"| tr -d ' ' | sha512sum | $PrPWD/stdcarsin ' ')
			echo "NAMEDestinatary    $nameDestinataryRemote"
			echo "PUBLICDestinatary  $namepublicDestinataryRemote"
			publicKeyofDestinatary=$(curl -L "$remotepath/fretfile.php?fname=$namepublicDestinataryRemote.js" 2>/dev/null | $PrPWD/stdcdr "content=" | $PrPWD/stdcdr '"'  | $PrPWD/stdcarsin '"' | base64 -d )
			publicKeyofDestinataryResult=$(echo "$publicKeyofDestinatary" | wc -c)
		        nameSignatary=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_nameofSignatary["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' | sed 's/%\([0-9A-Fa-f][0-9A-Fa-f]\)/\\x\1/g' | xargs -0 echo -e)
			nameSignataryRemote=$(echo "$nameSignataryRemote" | tr -d '
' | sha512sum | $PrPWD/stdcarsin ' ')
			nameSignataryRemote=$(echo "$nameSignataryRemote .js"|tr -d ' ')
			namepublicSignataryRemote=$(echo "$nameSignataryRemote public"| tr -d ' ' | sha512sum | $PrPWD/stdcarsin ' ')
			echo "NAMESignatary    $nameSignataryRemote"
			echo "PUBLICSignatary  $namepublicSignataryRemote"
			publicKeyofSignatary=$(curl -L "$remotepath/fretfile.php?fname=$namepublicSignataryRemote.js" 2>/dev/null | $PrPWD/stdcdr "content=" | $PrPWD/stdcdr '"'  | $PrPWD/stdcarsin '"' | base64 -d )
			publicKeyofSignataryResult=$(echo "$publicKeyofSignatary" | wc -c)
			encuentrac=$(echo "$command" |$PrPWD/stdbuscaarg 'REGISTER')
			echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   $respuesta   ($encuentrac) ($publicKeyofSignataryResult $publicKeyofDestinataryResult )"
			textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			while [ -f "$PaPWD/$textcc" ];do
			    textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			done
			if [ -n "$encuentrac" ] ; then
			    dirDestinatary="$PrPWD/users/input/$nameDestinatary"
			    dirDestinataryTokens="$PrPWD/users/input/$nameDestinatary/tokens"
			    mkdir $dirDestinatary
			    mkdir $dirDestinataryTokens
			    echo $dirDestinatary $dirDestinataryTokens
			    listaTokens=$(echo "$dirDestinataryTokens" | $PrPWD/listadodirectorio_files_from_std_extension_c|tr '
' ' ')
			    tokensAmmount=0
			    ammountRes=0
			    listaTokens=$(echo $listaTokens|tr '
' ' ')
			    donde=$(echo $listaTokens|$PrPWD/stdbuscaarg ' ')
			    while [ -n "$donde" ];do
				tokenNew=$(echo $listaTokens|tr -d '
'|$PrPWD/stdcarsin " ")
				listaTokens=$(echo $listaTokens|tr -d '
'|$PrPWD/stdcdr " ")
				if [ -n "$tokenNew" ];then
				    if [ -f "$tokenNew" ];then
					ammountToken=$(cat "$tokenNew" | $PrPWD/stdcdr "long ammount=" | $PrPWD/stdcarsin ";")
					echo "T: $ammountToken $tokensAmmount $dirDestinataryTokens"
					if [ -n "$ammountToken" ];then
					    tokensAmmount2=$(expr 0$tokensAmmount + $ammountToken)
					    tokensAmmount=$tokensAmmount2
					fi
				    fi
				fi
				donde=$(echo $listaTokens|tr -d '
'|$PrPWD/stdbuscaarg " ")
				#				echo "$donde :$listaTokens:"
			    done
			    echo "A $tokensAmmount ::"
			    
			    if [ "0$tokensAmmount" -ge "0$ammount" ];then
				listaTokens=$(echo "$dirDestinataryTokens" | $PrPWD/listadodirectorio_files_from_std_extension_c|tr '
' ' ')
				tokensAmmount=0
				ammountRes=0
				listaTokens=$(echo $listaTokens|tr '
' ' ')
				donde=$(echo $listaTokens|$PrPWD/stdbuscaarg ' ')
				while [ -n "$donde" ];do
				    tokenNew=$(echo $listaTokens|tr -d '
'|$PrPWD/stdcarsin " ")
				    listaTokens=$(echo $listaTokens|tr -d '
'|$PrPWD/stdcdr " ")
				    if [ -n "$tokenNew" ];then
					if [ -f "$tokenNew" ];then
					    ammountToken=$(cat "$tokenNew" | $PrPWD/stdcdr "long ammount=" | $PrPWD/stdcarsin ";")
					    echo "T: $ammountToken $tokensAmmount $dirDestinataryTokens"
					    if [ -n "$ammountToken" ];then
						tokensAmmount2=$(expr 0$tokensAmmount + $ammountToken)
						tokensAmmount=$tokensAmmount2
						echo "$tokenNew"
						ffn=$(echo "$tokenNew"|$PrPWD/stdcdr "$dirDestinatary/tokens/")
						mv "$dirTokens/$ffn" $dirTokensDeleted
						mv "$tokenNew" $dirTokensDeleted
					    fi
					fi
				    fi
				    donde=$(echo $listaTokens|tr -d '
'|$PrPWD/stdbuscaarg " ")
				done


				resto=$(expr 0$tokensAmmount - 0$ammount)
				echo ".:V $resto V:."
				variables=$(curl -L $remotepath/formalmFiles.php|tr -d '"')
				iv_OTP=$(echo "$variables" | $PrPWD/stdcdr "iv_OTP=" | $PrPWD/stdcarsin ";")
				OTP_resource=$(echo "$variables" | $PrPWD/stdcdr "OTP_resource=" | $PrPWD/stdcarsin ";")
				OTP=$(echo "$variables" | $PrPWD/stdcdr " OTP=" | $PrPWD/stdcarsin ";")
				contentd=$(echo "$content"|base64 -d)
				echo "..:: $contentd  ::.."
			        contentfile=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				while [ -f "$PaPWD/$contentfile" ];do
				    contentfile=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				done
				echo "$contentd" 1>"$PaPWD/$contentfile"
				curl -vvvv -X POST -L $remotepath/formalmFiles.php -F "OTP=$OTP" -F "iv_OTP=$iv_OTP" -F "OTP_resource=$OTP_resource" -F "texto2=@$PaPWD/$contentfile"
				rm -v "$PaPWD/$contentfile"
			    else
				if [ -n "$tokensAmmount" -a "0$tokensAmmount" -gt 0 ];then
				    


				    billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$PaPWD/$billscc.c" ];do
					billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    cat $PrPWD/billstostd.c | $PrPWD/stdcar " long num_pellets = " > "$PaPWD/$billscc.c"
				    echo "$ammount;" | tr -d '
'  >> "$PaPWD/$billscc.c"
				    cat $PrPWD/billstostd.c | $PrPWD/stdcdr " long num_pellets = " | $PrPWD/stdcdr ';' >> "$PaPWD/$billscc.c"

				    ldestokens=$(echo "$dirDestinataryTokens/" | tr -d '
' | wc -c)
				    ldestokens=$(expr $ldestokens + 21)
				    cat $PaPWD/$billscc.c | $PrPWD/stdcar "char tokensDirplusFilename[" > "$PaPWD/$billscc-ii.c"
				    echo "$ldestokens]="'"'"$dirDestinataryTokens/"'"'";" | tr -d '
'  >> "$PaPWD/$billscc-ii.c" 
				    cat $PaPWD/$billscc.c | $PrPWD/stdcdr "char tokensDirplusFilename[" | $PrPWD/stdcdr ';' >> "$PaPWD/$billscc-ii.c"
				    mv -v "$PaPWD/$billscc-ii.c" "$PaPWD/$billscc.c"
				    echo "_ _ _ _ _ _ _"
				    echo $PaPWD/$billscc.c
				    cat $PaPWD/$billscc.c
				    sleep 20
				    errors=$(gcc -o "$PaPWD/$billscc" "$PaPWD/$billscc.c" 2>&1)
				    temptextcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$PaPWD/$textcc" ];do
					temptextcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    $PaPWD/$billscc > $temptextcc
				    rm -v "$PaPWD/$billscc" "$PaPWD/$billscc.c"
				    if [ -z "$errores" ];then
					cp $dirDestinataryTokens/* $dirTokens
					textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$PaPWD/$textcc" ];do
					    textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done
					datefield="Date: $(date +%s)"
					echo "Subject: #sendcoin" > "$PaPWD/$textcc"
					echo "$datefield" >> "$PaPWD/$textcc"
					echo '

'  >> "$PaPWD/$textcc"
					cat  "$PaPWD/$temptextcc" >> "$PaPWD/$textcc"
					utcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$PaPWD/$utcc" ];do
					    utcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done
					variables=$(curl -L $remotepath/formalmFiles.php|tr -d '"')
					iv_OTP=$(echo "$variables" | $PrPWD/stdcdr "iv_OTP=" | $PrPWD/stdcarsin ";")
					OTP_resource=$(echo "$variables" | $PrPWD/stdcdr "OTP_resource=" | $PrPWD/stdcarsin ";")
					OTP=$(echo "$variables" | $PrPWD/stdcdr " OTP=" | $PrPWD/stdcarsin ";")
					respuestab=$(curl -L "$remotepath/fretfile.php?fname=$namepublic.js" 2>/dev/null )
					encuentra=$(echo "$respuestab" |$PrPWD/stdbuscaarg 'Success')
					if [ -n "$encuentra" ] ; then
					    echo "SUBIR"
					    boundaryR=$(dd if=/dev/urandom bs=1 skip=20 count=20 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    boundary="------- $boundaryR";
					    output=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    while [ -f "$PaPWD/$output" ];do
						output=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    done

					    echo "Content-Type: multipart/mixed; boundary=$boundary" > "$PaPWD/$output"
					    curl -L "$remotepath/fretfile.php?fname=$namepublic.js" 2>/dev/null | $PrPWD/stdcdr "content=" | $PrPWD/stdcarsin ";" | tr -d '"' | base64 -d | $PrPWD/stdcdr '`' | $PrPWD/stdcarsin '`' > $utcc.public
					    signedoutput=$(cat $PaPWD/$textcc| gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f  $utcc.public - | gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --clearsign )				    
					    echo "$datefield" >> "$PaPWD/$output"
					    echo "Subject: #sendcoin" >> "$PaPWD/$output"
					    echo '

'  >> "$PaPWD/$output"
					    echo "$boundary"  >> "$PaPWD/$output"
					    echo "Content-Type: text/plain; charset=us-ascii; field=signature;"  >> "$PaPWD/$output"
					    echo '

'  >> "$PaPWD/$output"
					    echo "$signedoutput" >> "$PaPWD/$output"
					    encryptedoutput=$(cat "$PaPWD/$output" | gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f $utcc.public|base64|tr -d '
')
					    rm -v "$textcc" "$textcc.c" "$temptextcc" "$temptextcc.c" "$utcc.public"
					    namel=$(echo "$nameDestinataryRemote"|tr -d '
'|wc -c)
					    encryptedoutputl=$(echo "$encryptedoutput"| tr -d '
'|wc -c)
					    texto=$(echo " $($PrPWD/aleatorio|$PrPWD/stdcdrn 2) int main() {  $($PrPWD/aleatorio) char nameofindex[$namel]=\"$nameRemote\"; $($PrPWD/aleatorio)  char command[6]=\"APPEND\"; $($PrPWD/aleatorio)  char content[$encryptedoutputl]=\"$encryptedoutput\"; $($PrPWD/aleatorio)  }")
					    encriptedOutputFiles=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    while [ -f "$PaPWD/$encriptedOutputFiles" ];do
						encriptedOutputFiles=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    done
					    echo "$texto"| gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f $serverPublic > $encriptedOutputFiles
					    if [ -n "$encuentra" ] ; then
						curl -vvvv -X POST -L $remotepath/formalmFiles.php -F "OTP=$OTP" -F "iv_OTP=$iv_OTP" -F "OTP_resource=$OTP_resource" -F "texto2=@$encriptedOutputFiles"
					    fi
					fi
				    fi



				    


				    billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$PaPWD/$billscc.c" ];do
					billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    cat $PrPWD/billstostd.c | $PrPWD/stdcar " long num_pellets = " > "$PaPWD/$billscc.c"
				    echo "$ammount;" | tr -d '
'  >> "$PaPWD/$billscc.c"
				    cat $PrPWD/billstostd.c | $PrPWD/stdcdr " long num_pellets = " | $PrPWD/stdcdr ';' >> "$PaPWD/$billscc.c"

				    ldestokens=$(echo "$dirDestinataryTokens/" | tr -d '
' | wc -c)
				    ldestokens=$(expr $ldestokens + 21)
				    cat $PaPWD/$billscc.c | $PrPWD/stdcar "char tokensDirplusFilename[" > "$PaPWD/$billscc-ii.c"
				    echo "$ldestokens]="'"'"$dirDestinataryTokens/"'"'";" | tr -d '
'  >> "$PaPWD/$billscc-ii.c" 
				    cat $PaPWD/$billscc.c | $PrPWD/stdcdr "char tokensDirplusFilename[" | $PrPWD/stdcdr ';' >> "$PaPWD/$billscc-ii.c"
				    mv -v "$PaPWD/$billscc-ii.c" "$PaPWD/$billscc.c"
				    echo "_ _ _ _ _ _ _"
				    echo $PaPWD/$billscc.c
				    cat $PaPWD/$billscc.c
				    sleep 20
				    errors=$(gcc -o "$PaPWD/$billscc" "$PaPWD/$billscc.c" 2>&1)
				    temptextcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$PaPWD/$textcc" ];do
					temptextcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    $PaPWD/$billscc > $temptextcc
				    rm -v "$PaPWD/$billscc" "$PaPWD/$billscc.c"
				    if [ -z "$errores" ];then
					cp $dirDestinataryTokens/* $dirTokens
					textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$PaPWD/$textcc" ];do
					    textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done
					datefield="Date: $(date +%s)"
					echo "Subject: #sendcoin" > "$PaPWD/$textcc"
					echo "$datefield" >> "$PaPWD/$textcc"
					echo '

'  >> "$PaPWD/$textcc"
					cat  "$PaPWD/$temptextcc" >> "$PaPWD/$textcc"
					utcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					while [ -f "$PaPWD/$utcc" ];do
					    utcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					done
					variables=$(curl -L $remotepath/formalmFiles.php|tr -d '"')
					iv_OTP=$(echo "$variables" | $PrPWD/stdcdr "iv_OTP=" | $PrPWD/stdcarsin ";")
					OTP_resource=$(echo "$variables" | $PrPWD/stdcdr "OTP_resource=" | $PrPWD/stdcarsin ";")
					OTP=$(echo "$variables" | $PrPWD/stdcdr " OTP=" | $PrPWD/stdcarsin ";")
					respuestab=$(curl -L "$remotepath/fretfile.php?fname=$namepublic.js" 2>/dev/null )
					encuentra=$(echo "$respuestab" |$PrPWD/stdbuscaarg 'Success')
					if [ -n "$encuentra" ] ; then
					    echo "SUBIR"
					    boundaryR=$(dd if=/dev/urandom bs=1 skip=20 count=20 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    boundary="------- $boundaryR";
					    output=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    while [ -f "$PaPWD/$output" ];do
						output=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    done

					    echo "Content-Type: multipart/mixed; boundary=$boundary" > "$PaPWD/$output"
					    curl -L "$remotepath/fretfile.php?fname=$namepublic.js" 2>/dev/null | $PrPWD/stdcdr "content=" | $PrPWD/stdcarsin ";" | tr -d '"' | base64 -d | $PrPWD/stdcdr '`' | $PrPWD/stdcarsin '`' > $utcc.public
					    signedoutput=$(cat $PaPWD/$textcc| gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f  $utcc.public - | gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --clearsign )				    
					    echo "$datefield" >> "$PaPWD/$output"
					    echo "Subject: #sendcoin" >> "$PaPWD/$output"
					    echo '

'  >> "$PaPWD/$output"
					    echo "$boundary"  >> "$PaPWD/$output"
					    echo "Content-Type: text/plain; charset=us-ascii; field=signature;"  >> "$PaPWD/$output"
					    echo '

'  >> "$PaPWD/$output"
					    echo "$signedoutput" >> "$PaPWD/$output"
					    encryptedoutput=$(cat "$PaPWD/$output" | gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f $utcc.public|base64|tr -d '
')
					    rm -v "$textcc" "$textcc.c" "$temptextcc" "$temptextcc.c" "$utcc.public"
					    namel=$(echo "$nameDestinataryRemote"|tr -d '
'|wc -c)
					    encryptedoutputl=$(echo "$encryptedoutput"| tr -d '
'|wc -c)
					    texto=$(echo " $($PrPWD/aleatorio|$PrPWD/stdcdrn 2) int main() {  $($PrPWD/aleatorio) char nameofindex[$namel]=\"$nameRemote\"; $($PrPWD/aleatorio)  char command[6]=\"APPEND\"; $($PrPWD/aleatorio)  char content[$encryptedoutputl]=\"$encryptedoutput\"; $($PrPWD/aleatorio)  }")
					    encryptedoutput=$(echo "$texto"| gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f $serverPublic)
					    encriptedOutputFiles=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    while [ -f "$PaPWD/$encriptedOutputFiles" ];do
						encriptedOutputFiles=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
					    done
					    echo "$encryptedoutput" > $encriptedOutputFiles
					    if [ -n "$encuentra" ] ; then
						curl -vvvv -X POST -L $remotepath/formalmFiles.php -F "OTP=$OTP" -F "iv_OTP=$iv_OTP" -F "OTP_resource=$OTP_resource" -F "texto2=@$encriptedOutputFiles"
					    fi
					fi
				    fi

				fi
				
			    fi
			fi
		    fi
		fi
	    fi
	fi
    fi
fi
rm -v "$listf.lock" 2>/dev/null
