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
# ps1=1
# while [ -f "$nomprograma.lock-$ps1" ];do
#     if [ 0$ps1 -lt 4 ];then
# 	echo "W W W W W W W W W W W W W   $ps1"
# 	ps1=$(expr 0$ps1 + 1)
#     else
# 	ps1=1
# 	sleep 1
#     fi
# done
touch "$nomprograma.memoria"
listados="";
listado="";
eyedirectory="$PrPWD/users/input"
mouthdirectory="$PrPWD/users/processed"
if [ ! -d "$mouthdirectory" ];then
    mkdir $mouthdirectory
fi
remotepath="https://curare2019.ddns.net/" #"http://127.0.0.1/"
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
	echo "28]=\"/root/panal/users/processed\";" >> "$PaPWD/$utcc.c"
	cat $PrPWD/listadodirectorio_files_from_mem_extension_c.c | $PrPWD/stdcdr " compare[" | $PrPWD/stdcdr ";" >> "$PaPWD/$utcc.c"
	errores=$(gcc -o "$PaPWD/$utcc" "$PaPWD/$utcc.c" 2>&1)
	if [ -n "$errores" ];then
	    echo "$errores"
	    exit
	fi
	cat $PrPWD/getregisteranlock.c | $PrPWD/stdcar " buffer[" > "$PaPWD/$forfiles.c"
	register="$nomprograma.memoria"
	len=$(echo "$register"|wc -c|$PrPWD/stdcarsin ' ')
	echo "$len ]=\"$register\";" >> "$PaPWD/$forfiles.c"
	cat $PrPWD/getregisteranlock.c | $PrPWD/stdcdr " buffer[" | $PrPWD/stdcdr ";" |  $PrPWD/stdcar " files["  >> "$PaPWD/$forfiles.c"
	len=$($PaPWD/$utcc| $PrPWD/stdcdr "files[" |$PrPWD/stdcarsin ']')
	if [ "0$len" -gt 1 ];then
	    $PaPWD/$utcc | $PrPWD/stdcdr " files[" | $PrPWD/stdcar ";" >> "$PaPWD/$forfiles.c"
	    cat $PrPWD/getregisteranlock.c | $PrPWD/stdcdr " buffer[" | $PrPWD/stdcdr ";" |  $PrPWD/stdcdr " files[" |  $PrPWD/stdcdr ";" >> "$PaPWD/$forfiles.c"
	    errores=$(gcc -o "$PaPWD/$forfiles" "$PaPWD/$forfiles.c" 2>&1)
	    if [ -n "$errores" ];then
		echo "$errores"
		exit
	    fi
	    listf=$($PaPWD/$forfiles|head -n1)
	    len=$($PaPWD/$forfiles|head -n2|wc -l |$PrPWD/stdcarsin ' ')
	    rm  $PaPWD/$forfiles $PaPWD/$forfiles.c $PaPWD/$utcc $PaPWD/$utcc.c
	    if [ "0$len" -gt 2 ];then
		echo $len
		if [ -n "$listf" -a ! -f "$listf.lock" ];then
		    touch "$listf.lock"
		    $0 &
		    break;
		fi
	    else
		listf=""
	    fi
	fi
	listado=$(echo -n "$listado" | $PrPWD/stdcdr ";")
    done
fi
dirTokens="$PrPWD/users/tokens"
dirNewTokens="$PrPWD/users/tokensNew"
dirTokensDeleted="$PrPWD/users/tokensDeleted"
serverPublic=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
while [ -f "$PaPWD/$serverPublic" ];do
    serverPublic=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
done

if [ -n "$listf" ];then
    fn=$listf
    echo "<< fn $fn >>"
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
	len=$(cat "$fn"|wc -c|tr -d ' '|tr -d '
')
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - $closs)
	    echo "$len $opens-$closs"
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		echo "0 $busca ($fn2) $dirfn"
		errores=$(gcc "$fn" 2>&1 )
		if [ -z "$errores" ];then
		    variables=$(cat "$fn")
		    variables=$(echo "$variables"|$PrPWD/stddeclaracionesdevariable|tr '
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
			mv -v $listf $mouthdirectory/$fn
			echo "varos passed;"
		        command=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_command["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
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
					    mv -v "$tokenNew" $dirTokensDeleted
					fi
				    fi
				fi
				donde=$(echo $listaTokens|tr -d '
'|$PrPWD/stdbuscaarg " ")
#				echo "$donde :$listaTokens:"
			    done
			    echo "A $tokensAmmount ::"
			    sleep 20
			    if [ "0$tokensAmmount" -ge "0$ammount" ];then
				resto=$(expr 0$tokensAmmount - 0$ammount)
				billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				while [ -f "$PaPWD/$billscc.c" ];do
				    billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				done
				cat $PrPWD/bills.c | $PrPWD/stdcar " long num_pellets = " > "$PaPWD/$billscc.c"
				echo "$ammount;" | tr -d '
'  >> "$PaPWD/$billscc.c"
				cat $PrPWD/bills.c | $PrPWD/stdcdr " long num_pellets = " | $PrPWD/stdcdr ';' >> "$PaPWD/$billscc.c"
				gcc -o "$PaPWD/$billscc" "$PaPWD/$billscc.c"
				cuantos=$($PaPWD/$billscc | ../stdbuscaarg_count ',')
				listaAmmount=$($PaPWD/$billscc)
				addAmmount=$(echo $listaAmmount|tr ',' '+'|bc)
				dondeAmmount="ALGO"
				c=1
				ammountRes=0;
				datefield="Date: $(date +%s)"
				temptextcc=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				while [ -f "$PaPWD/$temptextcc" ];do
				    temptextcc=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				done
				while [ -n "$dondeAmmount" ];do
				    tokenAmmount=$(echo $listaAmmount | $PrPWD/stdcarsin ',')
				    while [ "0$tokenAmmount" -gt 0 ];do
					listaTokens=$(echo "$dirNewTokens/$tokenAmmount/" | $PrPWD/listadodirectorio_files_from_std_extension_c)
					tokenAmmount=$(echo $listaAmmount | $PrPWD/stdcarsin ',')
					echo "A $tokenAmmount $ammountRes/$addAmmount $c $dirNewTokens/$tokenAmmount/"
					donde=$(echo $listaTokens|$PrPWD/stdbuscaarg " ")
					while [ -n "$donde" ];do
					    tokenNew=$(echo $listaTokens|$PrPWD/stdcarsin " ")
					    if [ -n "$tokenNew" ];then
						echo "c=$c A:$tokenAmmount T:$tokenNew X:$PaPWD/$temptextcc"
						if [ -f "$tokenNew" ];then
						    mv $tokenNew $dirTokens
						    newName=$tokenNew
						    donde=$(echo $newName|$PrPWD/stdbuscaarg "/")
						    while [ -n "$donde" ];do
							newName=$(echo $newName|$PrPWD/stdcdr "/")
							donde=$(echo $newName|$PrPWD/stdbuscaarg "/")
						    done
						    cat $dirTokens/$newName >> $PaPWD/$temptextcc
						    ammountRes=$(expr $tokenAmmount + $ammountRes)
						    tokenAmmount=0
						    donde=""
						else
						    listaTokens=$(echo $listaTokens|$PrPWD/stdcdr " ")
						    donde=$(echo $listaTokens|$PrPWD/stdbuscaarg " ")
						    echo "$donde"
						fi
					    fi
					done
				    done
				    listaAmmount=$(echo $listaAmmount|$PrPWD/stdcdr ",")
				    dondeAmmount=$(echo $listaAmmount|$PrPWD/stdbuscaarg ",")
				    c=$(expr 0$c + 1)
				    if [ -z "$dondeAmmount" ];then
					c=13
				    fi
				done

				if [ 0$resto -gt 0 ];then
				    billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$PaPWD/$billscc.c" ];do
					billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    cat $PrPWD/bills.c | $PrPWD/stdcar " long num_pellets = " > "$PaPWD/$billscc.c"
				    echo "$resto;" | tr -d '
'  >> "$PaPWD/$billscc.c"
				    cat $PrPWD/bills.c | $PrPWD/stdcdr " long num_pellets = " | $PrPWD/stdcdr ';' >> "$PaPWD/$billscc.c"
				    gcc -o "$PaPWD/$billscc" "$PaPWD/$billscc.c"
				    cuantos=$($PaPWD/$billscc | ../stdbuscaarg_count ',')
				    listaAmmount=$($PaPWD/$billscc)
				    addAmmount=$(echo $listaAmmount|tr ',' '+'|bc)
				    dondeAmmount="ALGO"
				    c=1
				    ammountRes=0;
				    datefield="Date: $(date +%s)"
				    while [ -n "$dondeAmmount" ];do
					tokenAmmount=$(echo $listaAmmount | $PrPWD/stdcarsin ',')
					while [ "0$tokenAmmount" -gt 0 ];do
					    listaTokens=$(echo "$dirNewTokens/$tokenAmmount/" | $PrPWD/listadodirectorio_files_from_std_extension_c)
					    tokenAmmount=$(echo $listaAmmount | $PrPWD/stdcarsin ',')
					    echo "A $tokenAmmount $ammountRes/$addAmmount $c $dirNewTokens/$tokenAmmount/"
					    donde=$(echo $listaTokens|$PrPWD/stdbuscaarg " ")
					    while [ -n "$donde" ];do
						tokenNew=$(echo $listaTokens|$PrPWD/stdcarsin " ")
						if [ -n "$tokenNew" ];then
						    echo "c=$c A:$tokenAmmount T:$tokenNew"
						    if [ -f "$tokenNew" ];then
							mv $tokenNew $dirTokens
							newName=$tokenNew
							donde=$(echo $newName|$PrPWD/stdbuscaarg "/")
							while [ -n "$donde" ];do
							    newName=$(echo $newName|$PrPWD/stdcdr "/")
							    donde=$(echo $newName|$PrPWD/stdbuscaarg "/")
							done
							cp $dirTokens/$newName $dirDestinataryTokens
							donde=""
						    else
							listaTokens=$(echo $listaTokens|$PrPWD/stdcdr " ")
							donde=$(echo $listaTokens|$PrPWD/stdbuscaarg " ")
							echo "$donde"
						    fi
						fi
					    done
					done
					listaAmmount=$(echo $listaAmmount|$PrPWD/stdcdr ",")
					dondeAmmount=$(echo $listaAmmount|$PrPWD/stdbuscaarg ",")
					c=$(expr 0$c + 1)
					if [ -z "$dondeAmmount" ];then
					    c=13
					fi
				    done
				fi
				textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				while [ -f "$PaPWD/$textcc" ];do
				    textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				done
				echo "Subject: sendcoins" > "$PaPWD/$textcc"
				echo "$datefield" >> "$PaPWD/$textcc"
				echo '

'  >> "$PaPWD/$textcc"
				cat  "$PaPWD/$temptextcc" >> "$PaPWD/$textcc"
				cuantos=$(expr $cuantos - 8)
				utcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				while [ -f "$PaPWD/$utcc" ];do
				    utcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				done
				echo '-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=5EZI
-----END PGP PUBLIC KEY BLOCK-----' > $PaPWD/$serverPublic

				variables=$(curl -L $remotepath/formalm.php|tr -d '"')
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
				    echo "Subject: #sendcoins" >> "$PaPWD/$output"
				    echo '

'  >> "$PaPWD/$output"
				    echo "$boundary"  >> "$PaPWD/$output"
				    echo "Content-Type: text/plain; charset=us-ascii; field=signature;"  >> "$PaPWD/$output"
				    echo '

'  >> "$PaPWD/$output"
				    echo "$signedoutput" >> "$PaPWD/$output"
				    encryptedoutput=$(cat "$PaPWD/$output" | gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f $utcc.public|base64|tr -d '
')
				    #					echo "$encryptedoutput"
				    cat $PaPWD/$textcc
				    namel=$(echo "$name"|tr -d '
'|wc -c)
				    encryptedoutputl=$(echo "$encryptedoutput"| tr -d '
'|wc -c)
				    texto=$(echo " $($PrPWD/aleatorio|$PrPWD/stdcdrn 2) int main() {  $($PrPWD/aleatorio) char nameofindex[$namel]=\"$name\"; $($PrPWD/aleatorio)  char command[6]=\"APPEND\"; $($PrPWD/aleatorio)  char content[$encryptedoutputl]=\"$encryptedoutput\"; $($PrPWD/aleatorio)  }")
				    encryptedoutput=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$PaPWD/$encryptedoutput" ];do
					encryptedoutput=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    echo "$texto"| gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f $PaPWD/$serverPublic > "$PaPWD/$encryptedoutput"
				    if [ -n "$encuentra" ] ; then
					curl -vvvv -X POST -L $remotepath/formalmFiles.php -F "OTP=$OTP" -F "iv_OTP=$iv_OTP" -F "OTP_resource=$OTP_resource" -F "texto2=@$PaPWD/$encryptedoutput"

				    fi
				fi


				
				contentd=$(echo "$content"|base64 -d)
			        contentfile=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				while [ -f "$PaPWD/$contentfile" ];do
				    contentfile=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				done
				echo "$contentd" | gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --secret-keyring $PrPWD/user/key.gpg --trustdb-name $PrPWD/user/trustdb.gpg  -d  2>/dev/null 1>"$PaPWD/$contentfile"
				curl -vvvv -X POST -L $remotepath/formalmFiles.php -F "OTP=$OTP" -F "iv_OTP=$iv_OTP" -F "OTP_resource=$OTP_resource" -F "texto2=@$PaPWD/$contentfile"
			    else
				sleep 20
				if [ -n "$tokensAmmount" -a "0$tokensAmmount" -gt 0 ];then
				    billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$PaPWD/$billscc.c" ];do
					billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    cat $PrPWD/bills.c | $PrPWD/stdcar " long num_pellets = " > "$PaPWD/$billscc.c"
				    echo "$tokensAmmount;" | tr -d '
'  >> "$PaPWD/$billscc.c"
				    cat $PrPWD/bills.c | $PrPWD/stdcdr " long num_pellets = " | $PrPWD/stdcdr ';' >> "$PaPWD/$billscc.c"
				    gcc -o "$PaPWD/$billscc" "$PaPWD/$billscc.c"
				    cuantos=$($PaPWD/$billscc | ../stdbuscaarg_count ',')
				    listaAmmount=$($PaPWD/$billscc)
				    addAmmount=$(echo $listaAmmount|tr ',' '+'|bc)
				    dondeAmmount="ALGO"
				    c=1
				    ammountRes=0;
				    datefield="Date: $(date +%s)"
				    temptextcc=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    while [ -f "$PaPWD/$temptextcc" ];do
					temptextcc=$(dd if=/dev/random bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
				    done
				    while [ -n "$dondeAmmount" ];do
					tokenAmmount=$(echo $listaAmmount | $PrPWD/stdcarsin ',')
					listaTokens=$(echo "$dirNewTokens/$tokenAmmount/" | $PrPWD/listadodirectorio_files_from_std_extension_c)
					echo "A $tokenAmmount $addAmmount $c $dirNewTokens/$tokenAmmount/"
					donde=$(echo $listaTokens|$PrPWD/stdbuscaarg " ")
					while [ -n "$donde" ];do
					    tokenNew=$(echo $listaTokens|$PrPWD/stdcarsin " ")
					    if [ -n "$tokenNew" ];then
						echo "A:$tokenAmmount T:$tokenNew X:$dirDestinataryTokens $chachafile"
						if [ -f "$tokenNew" ];then
						    mv -v $tokenNew "$dirDestinataryTokens"
						    addAmmount=$(echo 0$addAmmount + $tokenAmmount)
						    donde=""
						    break
						else
						    listaTokens=$(echo $listaTokens|$PrPWD/stdcdr " ")
						    donde=$(echo $listaTokens|$PrPWD/stdbuscaarg " ")
						    echo "$donde"
						fi
					    fi
					done
				    done
				    listaAmmount=$(echo $listaAmmount|$PrPWD/stdcdr ",")
				    dondeAmmount=$(echo $listaAmmount|$PrPWD/stdbuscaarg ",")
				fi
				rm -v "$chachafile"
			    fi
			fi
		    fi
		fi
	    fi
	fi
    fi
else
    $0 &
fi
rm -v "$listf.lock" 2>/dev/null
