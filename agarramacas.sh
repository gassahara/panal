#!/bin/sh
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
    echo "."
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
sleep 0.1
touch $PrPWD/users/cuentas/macs.txt
touch $PrPWD/users/cuentas/macsx.txt
mkdir $PrPWD/users/cuentas
ssh soportem@192.168.77.254 -p 2248 "/ip dhcp-server lease export terse" > $PrPWD/users/cuentas/macsx.txt
macs=$(cat $PrPWD/users/cuentas/macsx.txt | grep --color -o  "[0-F][0-F]\:[0-F][0-F]\:[0-F][0-F]\:[0-F][0-F]\:[0-F][0-F]\:[0-F][0-F]" | diff - $PrPWD/users/cuentas/macs.txt | grep --color -o  "[0-F][0-F]\:[0-F][0-F]\:[0-F][0-F]\:[0-F][0-F]\:[0-F][0-F]\:[0-F][0-F]" | tr [:lower:] [:upper:] | tr '
> ' ';')
echo "$macs"
enc=$(echo "$macs" | $PrPWD/stdbuscaarg ";" )
echo "$enc"
macshtml2=""
echo "( $enc )"
while [ -n "$enc" ];do
    macs1=$(echo "$macs"|$PrPWD/stdcarsin ";")
    macs2=$(echo "$macs"|$PrPWD/stdcdr ";")
    macs="$macs2"
    macs2="" 
    ip=$(grep "$macs1" "$PrPWD/users/cuentas/macsx.txt"|$PrPWD/stdcdr "address="|$PrPWD/stdcarsin " ")
    queue=$(ssh soportem@192.168.77.254 -p 2248 "/queue simple export terse" | grep "$ip" | $PrPWD/stdcdr "max-limit=" | $PrPWD/stdcarsin " ")
    subida=$(echo $queue| $PrPWD/stdcarsin "/"|sed "s/M/000000/g"|sed "s/k/000/g")
    descarga=$(echo $queue| $PrPWD/stdcdr "/"|sed "s/M/000000/g"|sed "s/k/000/g")
    macs2=$(echo "$macs1" | tr -d ':' )
    echo "<table><tr><td>Subida en bits </td><td> Descarga en bits </td></tr><tr><td><input id=\"descargademac\" value=\"$descarga\"/></td><td><input id=\"subidademac\" value=\"$subida\"/></td></tr></table>" > "$PrPWD/users/output/unencrypted/$macs2-plan.html"
    macshtml="$macshtml<option value=\"$macs1\">$macs1</option>"
    macshtml2="$macshtml<option value=\"$macs1\">$macs1</option>"
echo "$macs1"
    enc=$(echo "$macs" | $PrPWD/stdbuscaarg ";" )
done
echo "$macshtml" > $PrPWD/users/output/unencrypted/macs.html
echo ".."
sleep 600
$0 &
