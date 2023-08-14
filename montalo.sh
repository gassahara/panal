#!/bin/sh
fn=""
direct=$PWD
cuan=$(echo "$0" | ./stdbuscaarg_count "/")
quita0a=" "
while [ 0$cuan -gt 0 ];do
    quita0a="$quita0a | ./stdcdr 2F  "
    cuan=$((cuan-1))
done
cc=$(echo "echo \"$0\" | ./stdtohex $quita0a | ./stdfromhex | ./stdcarsin \".sh\" ")
noo=$(eval $cc )
ll=$PWD/$noo.listado
cd /dev
ll=$(eval "$direct/listadodirectorio_special | $direct/stdtohex" )
cd $direct
cuant=$(echo $ll | ./stdbuscaarg_count  "2F 64 65 76 2F 73 64")
echo $ll | ./stdfromhex
while [ $cuant -gt 0 ];do
    quita0a=" "
    cuant2=$cuant
    while [ 0$cuant2 -gt 1 ];do
	quita0a="$quita0a | ./stdcdr  '2F 64 65 76 2F 73 64'"
	echo "$cuant $cuant2 oo"
	cuant2=$((cuant2-1))
    done
    fn=""
    fn=$(eval "echo $ll $quita0a |  ./stdcdrcon  '2F 64 65 76 2F 73 64'| ./stdcarsin 0A | ./stdfromhex" )
    label=""
    if [ -z "$(cat /proc/mounts | ./stdbuscaarg $fn)" ];then
	blkid $fn
	label=$(blkid $fn | ./stdcdr " LABEL=" | ./stdcdr '"' | ./stdcarsin '"')
	la=$(echo -n "$label" | wc -c)
	if [ -z "$label" -o 0$la -le 1 ];then
	    label=$(blkid $fn | ./stdcdr " PARTLABEL=" |  ./stdcdr '"' | ./stdcarsin '"')
	    la=$(echo -n "$label" | wc -c)
	    if [ -z "$label" -o 0$la -le 1 ];then
		label=$(blkid $fn | ./stdcdr " UUID=" |  ./stdcdr '"' | ./stdcarsin '"')
	    fi
	fi
	if [ -n "$label" ];then
	    umount -v "/media/$label"
	    mkdir "/media/$label"
	    mount $fn "/media/$label"
	fi
    fi
    cuant=$((cuant-1))
done

