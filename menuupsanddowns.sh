#!/bin/bash
while [ 1 ];do
clear && printf '\e[3J'
prompt_x=$(tput cols)-6
tput cuu1
tput sc
pos_x=$(echo "oldscale=scale; scale=0; (($prompt_x)/2) ; scale=oldscale;" | bc -l)
tput cup 0 ${pos_x}
tput setaf 4 ; tput bold
echo -n "["
tput setaf 1
echo -n "MENU"
tput setaf 4 ; tput bold
echo -n "]"
tput rc
tput setaf 3 ; tput bold
tput cup 2 10
echo "ACCION A REALIZAR"
tput cup 4 10
tput setaf 5 ; tput bold
echo "1. Montar Dispositivos"
tput cup 6 10
tput setaf 5 ; tput bold
echo "2. Desmontar Dispositivos"
tput cup 7 10
echo "3. Transferir Archivos"
tput cup 8 10
echo "4. Salir"
read -rn1 -d "" accion
if [ "$accion" = "4" ];then
    exit 0
fi
if [ "$accion" = "1" ];then
    sh montalo.sh
fi
if [ "$accion" = "3" ];then
    lista=$(cat cat /proc/mounts | grep "/media" | grep -v "/DISCOGRANDE" | ./stdtohex)
    if [ -n "$lista" ];then
	if [ $(echo $lista | ./stdbuscaarg_count "0A") -gt 1 ];then
	    clear && printf '\e[3J'
	    prompt_x=$(tput cols)-6
	    tput cuu1
	    tput sc
	    pos_x=$(echo "oldscale=scale; scale=0; (($prompt_x)/2) ; scale=oldscale;" | bc -l)
	    tput cup 0 ${pos_x}
	    tput setaf 4 ; tput bold
	    echo -n "["
	    tput setaf 1
	    echo -n "MENU"
	    tput setaf 4 ; tput bold
	    echo -n "]"
	    tput rc
	    tput setaf 3 ; tput bold
	    tput cup 10 10
	    echo "Dispositivo"
	    i=1
	    lista2=$lista
	    while [ $i -le $(echo $lista2 | ./stdbuscaarg_count "0A") ];do
		tput cup $((12+$i)) 10
		echo -n $i.
		tput cup $((12+$i)) 13
		i2=1
		while [ $i2 -lt $i ];do
		    lista2=$(echo $lista2 | ./stdcdr 0A )
		    i2=$((i2+1))
		done
		echo $lista2 | ./stdcarsin 0A | ./stdcdr 20 | ./stdcarsin 20 | ./stdfromhex
		i=$((i+1))
		tput cup $((12+$i)) 13
	    done
	    read -rsn1 i
	    i2=1
	    while [ $i2 -lt $i ];do
		lista=$(echo $lista | ./stdcdr 0A )
		i2=$((i2+1))
	    done
	fi
	dispositivo=$(echo $lista | ./stdcarsin 0A | ./stdcdr 20 | ./stdcarsin 20 | ./stdfromhex)
    fi

    lista=$(cat cat ../userspass | ./stdtohex)
    if [ -n "$lista" ];then
	if [ $(echo $lista | ./stdbuscaarg_count "0A") -gt 1 ];then
	    clear && printf '\e[3J'
	    prompt_x=$(tput cols)-6
	    tput cuu1
	    tput sc
	    pos_x=$(echo "oldscale=scale; scale=0; (($prompt_x)/2) ; scale=oldscale;" | bc -l)
	    tput cup 0 ${pos_x}
	    tput setaf 4 ; tput bold
	    echo -n "["
	    tput setaf 1
	    echo -n "MENU"
	    tput setaf 4 ; tput bold
	    echo -n "]"
	    tput rc
	    tput setaf 3 ; tput bold
	    tput cup 10 10
	    echo "Usuario para $dispositivo"
	    i=1
	    lista2=$lista
	    while [ $i -le $(echo $lista2 | ./stdbuscaarg_count "0A") ];do
		tput cup $((12+$i)) 10
		echo -n $i.
		tput cup $((12+$i)) 13
		i2=1
		while [ $i2 -lt $i ];do
		    lista2=$(echo $lista2 | ./stdcdr 0A )
		    i2=$((i2+1))
		done
		echo $lista2 | ./stdcarsin 0A | ./stdcarsin 3A | ./stdfromhex
		i=$((i+1))
		tput cup $((12+$i)) 13
	    done
	    read -rsn1 i
	    i2=1
	    j=$(echo $lista | ./stdbuscaarg_count 0A )
	    while [ $i2 -lt $i ];do
		lista=$(echo $lista | ./stdcdr 0A )
		i2=$((i2+1))
	    done
	    usuario=$(echo $lista | ./stdcarsin 0A | ./stdcarsin 3A | ./stdfromhex)
	    if [ -n "$usuario" -a 0$i -le 0$j ];then
		pp1=$PWD
		cd /var/www/$usuario
		echo Analizando ...
		sh $pp1/estados_directorios.sh >/dev/null 2>/dev/null
		cd $pp1
		mc $dispositivo /var/www/$usuario
		cd /var/www/$usuario
		cd $pp1
		cd ..
		mkdir saldosupsanddowns/$usuario
		pp2="$PWD/saldosupsanddowns/$usuario"
		e=$(date +%M%S%N%d%m%Y)
		cd /var/www/$usuario
		sh $pp1/estados_directorios.sh 2>/dev/null 1>$pp2/$e
		cd $pp1
	   fi
	fi
    fi
fi
done
exit 0
