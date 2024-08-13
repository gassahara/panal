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
originalfile="";
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
	    len=$(expr $len + 1)
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
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_fullname")
		    echo "fullname"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_phone")
		    echo "phone"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_payment")
		    echo "payment"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_transport")
		    echo "transport"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_subscription")
		    echo "subscription"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_servicio")
		    echo "servicio"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_uso")
		    echo "uso"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    varis=$(echo -n ";$variables" |$PrPWD/stdbuscaarg "char prefix_promedio")
		    echo "uso"
		    if [ -n "$varis" ];then
			varos="$varos$varis"
			echo "$varos"
		    else
			exit 0
		    fi
		    echo "variables $varos"
		    if [ "$varos" = "********" ];then
			mv -v $listf $mouthdirectory/$fn2
			echo "varos passed;"
		        fullname=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_fullname["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
		        phone=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_phone["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
		        payment=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_payment["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
		        transport=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_transport["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
		        subscription=$(echo -n ";$variables"|$PrPWD/stdcdr "char pryefix_subscription["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
		        servicio=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_servicio["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
		        uso=$(echo -n ";$variables"|$PrPWD/stdcdr "char prefix_uso["|$PrPWD/stdcdr "="|$PrPWD/stdcarsin ";"|tr -d '"')
			mkdir $PrPWD/users/poll
			shapoll=$(echo "$fullname $phone"|sha512sum | $PrPWD/stdcarsin ' ')
			echo "$fullname;$phone;$payment;$transport;$subscription;$servicio;$uso" > $PrPWD/users/poll/$shapoll
		    fi
		    rm -v "$listf.lock" 2>/dev/null
		fi
	    fi
	fi
    fi
fi
