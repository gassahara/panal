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
	    exit
	fi
	echo $utcc
	len=$($PaPWD/$utcc| $PrPWD/stdcdr "files[" |$PrPWD/stdcarsin ']')
	if [ "0$len" -gt 1 ];then
	    echo "LLLLLLLLLLL   $len"
	    cat $PrPWD/getregisteranlock.c | $PrPWD/stdcar " buffer[" > "$PaPWD/$forfiles.c"
	    register="$nomprograma.memoria"
	    len=$(echo "$register"|wc -c|$PrPWD/stdcarsin ' ')
	    echo "$len ]=\"$register\";" >> "$PaPWD/$forfiles.c"
	    cat $PrPWD/getregisteranlock.c | $PrPWD/stdcdr " buffer[" | $PrPWD/stdcdr ";" |  $PrPWD/stdcar " files["  >> "$PaPWD/$forfiles.c"
	    $PaPWD/$utcc | $PrPWD/stdcdr " files[" | $PrPWD/stdcar ";" >> "$PaPWD/$forfiles.c"
	    cat $PrPWD/getregisteranlock.c | $PrPWD/stdcdr " buffer[" | $PrPWD/stdcdr ";" |  $PrPWD/stdcdr " files[" |  $PrPWD/stdcdr ";" >> "$PaPWD/$forfiles.c"
	    errores=$(gcc -o "$PaPWD/$forfiles" "$PaPWD/$forfiles.c" 2>&1)
	    echo $PaPWD/$forfiles
	    if [ -n "$errores" ];then
		echo "$errores"
		exit
	    fi
	    listf=$($PaPWD/$forfiles|head -n1)
	    len=$($PaPWD/$forfiles|head -n2|wc -l |$PrPWD/stdcarsin ' ')
	    if [ "0$len" -gt 2 ];then
		echo $len
		listg=$($PaPWD/$forfiles|head -n2|head -n1)
		if [ -n "$listg" -a ! -f "$listg.lock" ];then
		    touch "$listg.lock"
		    $0 &
		    break;
		fi
	    fi
	    echo "$PaPWD/$forfiles $PaPWD/$forfiles.c $PaPWD/$utcc $PaPWD/$utcc.c"
	fi
	echo ">>>>>>>>>> $litsf"
	rm  -v $PaPWD/$forfiles $PaPWD/$forfiles.c $PaPWD/$utcc $PaPWD/$utcc.c
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

$0 &
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
		errores=$(gcc "$fn" 2>&1 )
		if [ -z "$errores" ];then
		    variables=$(cat "$fn")
		    variables=$(echo "$variables"|$PrPWD/stddeclaracionesdevariable|tr '
' ';')
		    varos="";
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_nameofDestinatary")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_stamps_command")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi		    
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "long prefix_stamps_dates")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "long prefix_stamps_uid1")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "long prefix_stamps_uid2")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "long prefix_stamps_uid3")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "long prefix_stamps_uid4")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_stamps_fname")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "long prefix_stamps_ammount")
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    if [ "$varos" = "*********" ];then
			rm -v "$tempf"
			echo "varos passed;"
		        command=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_stamps_command["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
		        tokens_dates=$(echo -n ";$variables"|$PrPWD/stdcdr "long prefix_stamps_dates["|$PrPWD/stdcdr "="|$PrPWD/stdcdr "{"|$PrPWD/stdcarsin ";"|tr '}' ',')
		        tokens_uid1=$(echo -n ";$variables"|$PrPWD/stdcdr "long prefix_stamps_uid1["|$PrPWD/stdcdr "="|$PrPWD/stdcdr "{"|$PrPWD/stdcarsin ";"|tr '}' ',')
		        tokens_uid2=$(echo -n ";$variables"|$PrPWD/stdcdr "long prefix_stamps_uid2["|$PrPWD/stdcdr "="|$PrPWD/stdcdr "{"|$PrPWD/stdcarsin ";"|tr '}' ',')
		        tokens_uid3=$(echo -n ";$variables"|$PrPWD/stdcdr "long prefix_stamps_uid3["|$PrPWD/stdcdr "="|$PrPWD/stdcdr "{"|$PrPWD/stdcarsin ";"|tr '}' ',')
		        tokens_uid4=$(echo -n ";$variables"|$PrPWD/stdcdr "long prefix_stamps_uid4["|$PrPWD/stdcdr "="|$PrPWD/stdcdr "{"|$PrPWD/stdcarsin ";"|tr '}' ',')
		        tokens_ammounts=$(echo -n ";$variables"|$PrPWD/stdcdr "long prefix_stamps_ammount["|$PrPWD/stdcdr "="|$PrPWD/stdcdr "{"|$PrPWD/stdcarsin ";"|tr '}' ',')
		        tokens_fnames=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_stamps_fname["|$PrPWD/stdcdr "="|$PrPWD/stdcdr "{"|$PrPWD/stdcarsin ";"|tr -d '"'|tr '}' ',')
			echo "COMMAND $command";
		        name=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_nameofDestinatary["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"' | sed 's/%\([0-9A-Fa-f][0-9A-Fa-f]\)/\\x\1/g' | xargs -0 echo -e)
			nameRemote=$(echo "$name" | tr -d '
' | sha512sum | $PrPWD/stdcarsin ' ')
			nameRemote=$(echo "$nameRemote .js"|tr -d ' ')
			namepublic=$(echo "$nameRemote public"| tr -d ' ' | sha512sum | $PrPWD/stdcarsin ' ')
			echo "NAME    $nameRemote ($name)"
			echo "PUBLIC  $namepublic"
			respuestab=$(curl -L "$remotepath/fretfile.php?fname=$namepublic.js" 2>/dev/null | $PrPWD/stdcdr 'error' | $PrPWD/stdcdr '"' | $PrPWD/stdcarsin '"'  | $PrPWD/stdbuscaarg "Success")			
			if [ -z "$respuestab" ];then
			    echo "$name not found"
			    exit
			fi
			respuesta=$(echo "$respuestaa $respuestab")
			echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   $respuesta   ($encuentrac) ($namepublic)"
			textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			while [ -f "$PaPWD/$textcc" ];do
			    textcc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			done
			encuentrac=$(echo "$command" |$PrPWD/stdbuscaarg 'SEND')
			echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   $respuesta   ($encuentrac) ($namepublic)"
			if [ -n "$encuentrac" ] ; then
			    dirDestinatary="$PrPWD/users/input/$name"
			    dirDestinataryTokens="$PrPWD/users/input/$name/tokens"
			    mkdir $dirDestinatary
			    mkdir $dirDestinataryTokens
			    busca=$(echo "$tokens_dates" | $PrPWD/stdbuscaarg ",")
			    ammountTotal=0
			    while [ -n "$busca" ];do
				tokenDate=$(echo "$tokens_dates" | $PrPWD/stdcarsin ",")
				tokens_dates=$(echo "$tokens_dates" | $PrPWD/stdcdr ",")
				tokenAmmount=$(echo "$tokens_ammounts" | $PrPWD/stdcarsin ",")
				tokens_ammounts=$(echo "$tokens_ammounts" | $PrPWD/stdcdr ",")
				tokenUid1=$(echo "$tokens_uid1" | $PrPWD/stdcarsin ",")
				tokens_uid1=$(echo "$tokens_uid1" | $PrPWD/stdcdr ",")
				tokenUid2=$(echo "$tokens_uid2" | $PrPWD/stdcarsin ",")
				tokens_uid2=$(echo "$tokens_uid2" | $PrPWD/stdcdr ",")
				tokenUid3=$(echo "$tokens_uid3" | $PrPWD/stdcarsin ",")
				tokens_uid3=$(echo "$tokens_uid3" | $PrPWD/stdcdr ",")
				tokenUid4=$(echo "$tokens_uid4" | $PrPWD/stdcarsin ",")
				tokens_uid4=$(echo "$tokens_uid4" | $PrPWD/stdcdr ",")
				tokenFname=$(echo "$tokens_fnames" | $PrPWD/stdcarsin ",")
				tokens_fnames=$(echo "$tokens_fnames" | $PrPWD/stdcdr ",")
				fname=$(echo "$tokenFname .c"|tr -d ' ')
				buscaDate=$(cat "$dirTokens/$fname" | $PrPWD/stdbuscaarg "long date=$tokenDate;")
				buscaFname=$(cat "$dirTokens/$fname" | $PrPWD/stdbuscaarg "char fname[21]=\"$tokenFname\";")
				buscaAmmount=$(cat "$dirTokens/$fname" | $PrPWD/stdbuscaarg "long ammount=$tokenAmmount;")
				buscaUid1=$(cat "$dirTokens/$fname" | $PrPWD/stdbuscaarg "long uid1=$tokenUid1;")
				buscaUid2=$(cat "$dirTokens/$fname" | $PrPWD/stdbuscaarg "long uid2=$tokenUid2;")
				buscaUid3=$(cat "$dirTokens/$fname" | $PrPWD/stdbuscaarg "long uid3=$tokenUid3;")
				buscaUid4=$(cat "$dirTokens/$fname" | $PrPWD/stdbuscaarg "long uid4=$tokenUid4;")
				busca=$(echo "$tokens_dates" | $PrPWD/stdbuscaarg ",")
				echo "$buscaUid1 $buscaUid2 $buscaUid3 $buscaUid4 $buscaDate $buscaFname  $buscaAmmount"
				if [ -n "$buscaUid1" -a -n "$buscaUid2" -a -n "$buscaUid3" -a -n "$buscaUid4" -a -n "$buscaDate" -a -n "$buscaFname"  -a -n "$buscaAmmount" ];then
				    ammountTotal=$(expr 0$ammountTotal + 0$tokenAmmount)
				    mv "$dirTokens/$fname" $dirTokensDeleted
				fi
			    done
			    billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$PaPWD/$billscc.c" ];do
				billscc=$(dd if=/dev/urandom bs=1 skip=20 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done
			    cat $PrPWD/billstostd.c | $PrPWD/stdcar " long num_pellets = " > "$PaPWD/$billscc.c"
			    echo "$ammountTotal;" | tr -d '
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
				echo '-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=5EZI
-----END PGP PUBLIC KEY BLOCK-----' > $PaPWD/$serverPublic

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
				    rm -v "$textcc" "$textcc.c" "$temptextcc" "$temptextcc.c" 
				    namel=$(echo "$nameRemote"|tr -d '
'|wc -c)
				    encryptedoutputl=$(echo "$encryptedoutput"| tr -d '
'|wc -c)
				    texto=$(echo " $($PrPWD/aleatorio|$PrPWD/stdcdrn 2) int main() {  $($PrPWD/aleatorio) char nameofindex[$namel]=\"$nameRemote\"; $($PrPWD/aleatorio)  char command[6]=\"APPEND\"; $($PrPWD/aleatorio)  char content[$encryptedoutputl]=\"$encryptedoutput\"; $($PrPWD/aleatorio)  }")
				    encryptedoutput=$(echo "$texto"| gpg  --homedir $PrPWD/user/ --no-default-keyring --keyring $PrPWD/user/key.key --trustdb-name $PrPWD/user/trustdb.gpg --armor  --encrypt -f $PaPWD/$serverPublic)
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
rm -v "$PaPWD/$serverPublic"
