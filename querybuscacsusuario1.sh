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
lista0=$($PrPWD/listadodirectorio_files_extension .c )
PbPWD=$(echo "$PaPWD"|$PrPWD/stdcdr "$PrPWD")
busca=".."
echo -n "" > $nomprograma.cha
posicion=0;
dondes=$( echo "$lista0" |$PrPWD/stdbuscaarg_donde '
')
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(echo "$lista0" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin '
')
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    posicion=$(expr 0$posicion + 1)
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=$(echo "$listf"|$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -z "$encuentra" ];then
    echo ";$listf;$chacha;" >> $nomprograma.memoria
fi
if [ -n "$dondes" ];then
    $0 &
else
ps1=1
while [ -f "$nomprograma.lock-$ps1" ];do
    if [ 0$ps1 -lt 2 ];then
	echo "W W W W W W W W W W W W W   $ps1"
	ps1=$(expr 0$ps1 + 1)
    else
	ps1=1
	sleep 1
    fi
done
    $0 &
fi
if [ -z "$encuentra" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then
	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	while [ -n "$slash" ];do
	    fn=$(echo "$fn" | $PrPWD/stdcdr "/" )
	    slash=$(echo $fn | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
    	echo "0 $busca ($fn)"
	len=$(cat "$fn"|wc -c|tr -d ' ')
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(expr 0$opens - 0$closs)
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		ejec="$fn.$nomprograma.bin"
		errores=$(gcc -o ./$ejec $fn 2>&1 )
		if [ -z "$errores" ];then
		    variables=$(cat $fn |$PrPWD/stddeclaracionesdevariable|$PrPWD/stddelcar '
')
		    variables=$( echo $(echo "$variables"|$PrPWD/stdcar "{")";"$(echo "$variables"|$PrPWD/stdcdr "{") )
		    echo "$variables"
		    userfromfile=$(echo -n "$variables" |$PrPWD/stdcdr ";char *"|$PrPWD/stdcarsin "=")
		    echo "UU=$userfromfile"
		    ttest=$(echo -n "$variables" |$PrPWD/stdbuscaarg_donde_hasta ";int ")
		    echo "<<< ttest $ttest >>>"
		    dondes=0
		    while [ "0$ttest" -gt 0 ];do
			dondes=$(expr $dondes + $ttest + 1)
			passfromfile=$(echo -n "$variables" |$PrPWD/stdcdrn $dondes|$PrPWD/stdcar ";")
			echo "-> <$passfromfile>"
			len2=$(echo $passfromfile|$PrPWD/stdbuscaarg_count "][")
			if [ 0$len2 -eq 0 ];then
			    passfromfile=$(echo -n "$passfromfile"|$PrPWD/stdcarsin "[")
			    echo "<([$passfromfile])>"
			    break;
			else
			    passfromfile=""
			fi
			ttest=$(echo ";$variables" |$PrPWD/stdcdrn $dondes|$PrPWD/stdbuscaarg_donde_hasta ";int ")
			echo "<<< ttest 0$ttest d $dondes>>>"
		    done
		    filedfromfile=$(echo "$variables" | $PrPWD/stdcdr ";FILE *"|$PrPWD/stdcarsin "=")

		    echo "<$userfromfile> <$passfromfile> <$filedfromfile>"
		    if [ -n "$userfromfile" -a -n "$passfromfile" -a -n "$filedfromfile" ];then
			usuar=$(echo ";$variables" | $PrPWD/stdcdr ";char *$userfromfile=" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ";");
			filed=$(cat $fn | $PrPWD/stdcdr "$filedfromfile=" | $PrPWD/stdcdr "fopen(" |$PrPWD/stddelcar '"' | $PrPWD/stdcarsin ",");
			if [ ! -f "$PrPWD/users/$usuar-aes.c" ];then
			    pwss=$(echo ";$variables" | $PrPWD/stdcdr " $passfromfile" |$PrPWD/stdcdr "=" | $PrPWD/stdcarsin ";");
			    mkdir $PrPWD/users/
			    cat $PrPWD/aes_ctr.c | $PrPWD/stdcar "unsigned char key[16]=" > $PrPWD/users/$usuar-aes.c
			    echo "<<< $pwss >>>"
			    echo -n "$pwss" >> $PrPWD/users/$usuar-aes.c
			    cat $PrPWD/aes_ctr.c | $PrPWD/stdcdr "unsigned char key[16]=" | $PrPWD/stdcdrcon ";" >> $PrPWD/users/$usuar-aes.c
			    c=0
			    iv="{{"
			    while [ 0$c -lt 16 ];do
				iv2=$(dd if=/dev/urandom bs=1 count=1 2>/dev/null | $PrPWD/stdtohex)
				iv=$(echo "$iv 0x $iv2 ,")
				c=$((c+1))
			    done
			    iv=$(echo -n "$iv}}};"|$PrPWD/stddelcar ",}"|$PrPWD/stddelcar " ")
			    echo "<<< ####################  >>>"
			    echo "$iv"
			    echo "<<< ####################  >>>"

			    mkdir "$PrPWD/users"
			    mkdir "$PrPWD/users/output"
			    mkdir "$PrPWD/users/output/$usuar/"
			    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$outputdelc.c" ];do
				outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done
			    touch $outputdelc
			    namo0="$outputdelc.c"
			    outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    while [ -f "$outputdelc.c" ];do
				outputdelc=$(dd if=/dev/random bs=1 count=10 2>/dev/null |$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			    done
			    namo1="$outputdelc.c"

			    cat $PrPWD/users/$usuar-aes.c | $PrPWD/stdcar "unsigned char iv[1][16]=" > "$namo0"
			    echo "$iv ;" >> "$namo0"
			    cat $PrPWD/users/$usuar-aes.c | $PrPWD/stdcdr "unsigned char iv[1][16]=" | $PrPWD/stdcdr ";" >> "$namo0"
			    
			    iv=$(echo "REGISTRADO"|$PrPWD/stdtohex)
			    c=$(echo "$iv" |$PrPWD/stdbuscaarg_count " ")
			    mv "$namo0" "$namo1"
			    cat "$namo1" | $PrPWD/stdcar "unsigned char buf[1][" > "$namo0"
			    echo "$((c+1)) ]=" >> "$namo0"
			    pwss="{{"
			    while [ 0$c -gt 0 ];do
				iv2=$(echo "$iv" | $PrPWD/stdcarsin " ")
				pwss=$(echo "$pwss 0x $iv2 ,"|$PrPWD/stddelcar " ") 
				iv=$(echo "$iv" | $PrPWD/stdcdr " ")
				c=$(echo "$iv" |$PrPWD/stdbuscaarg_count " ")
			    done
			    echo "$pwss}}};"|$PrPWD/stddelcar ",}" >> "$namo0"
			    cat "$namo1" | $PrPWD/stdcdr "unsigned char buf[" | $PrPWD/stdcdr ";" >> "$namo0"
			    errores=$(gcc -o "$namo0-bin" "$namo0")
			    if [ -z "$errores" ];then
				./$namo0-bin
				./$namo0-bin > $namo1
				mkdir peticiones
				mv $namo0 peticiones/
				namo0="$PrPWD/users/output/$usuar/$filed"
				echo -n "encrypted=new Uint8Array([" > $namo0
				cat $namo1 | $PrPWD/stdcdr "int buf[" | $PrPWD/stdcdr "=" | $PrPWD/stddelcar "{" | $PrPWD/stddelcar "}"|$PrPWD/stdcarsin ";" >> $namo0
				echo -n "]);"  >> $namo0
				
				echo -n "iv=new Uint8Array([" >> $namo0
				cat $namo1 | $PrPWD/stdcdr "int iv[" |  $PrPWD/stdcdr "=" | $PrPWD/stddelcar "{" | $PrPWD/stddelcar "}"|$PrPWD/stdcarsin ";" >> $namo0
				echo -n "]);"  >> $namo0
				echo "processed=255;" >> $namo0
				echo "<<</$namo0\>>>"
				mv $namo1 peticiones/
				cat $namo0
			    fi
			else
			    mkdir $PrPWD/users
			    mkdir $PrPWD/users/output
			    mkdir $PrPWD/users/output/unencrypted
			    echo "USUARIO REGISTRADO, Por Favor Escoja otro nombre"
			    echo "errores=\"USUARIO REGISTRADO, Por Favor Escoja otro nombre\";" > $PrPWD/users/output/unencrypted/$filed
			    echo "processed=255;" >> $PrPWD/users/output/unencrypted/$filed
			fi
			if [ -n "$errores" ];then
			    echo "======================="
			    echo "$errores"
			fi
    			mv $fn.* peticiones/
		    fi
		fi
	    else
		rm $fn
	    fi
	fi
    fi
fi
