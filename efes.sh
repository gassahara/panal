#!/bin/bash
clear && printf '\e[3J'
prompt_x=$(tput cols)-6
tput cuu1
tput sc
pos_x=$(echo "oldscale=scale; scale=0; (($prompt_x)/2) ; scale=oldscale;" | bc -l)
tput cup 0 ${pos_x}
tput setaf 4 ; tput bold
echo -n "["
tput setaf 1
echo -n "EFEMERIDES"
tput setaf 4 ; tput bold
echo -n "]"
tput rc
tput setaf 3 ; tput bold
tput cup 2 10
echo "POR FAVOR INTRODUZCA LOS DATOS SEGUN SE REQUIERAN"
tput cup 4 10
tput setaf 5 ; tput bold
read -p "FECHA DE NACIMIENTO (DD/MM/AAAA, separado por punto (.) slash (/) o guion (-) " fecha
fecha=$(echo $fecha | sed "s/[\/.]/-/g")
tput cup 5 10
read -p "HORA DE NACIMIENTO (UT) en fomato 'HH:MM[am/pm]'  (sin espacios)" hora
tput cup 6 10
read -p "LONGITUD DEL LUGAR DE NACIMIENTO en formato 'HH:MM[WO/E]'  " lon
tput cup 7 10
read -p "LATITUD DEL LUGAR DE NACIMIENTO en formato 'HH:MM[N/S]'  " lat 
tput cup 8 10
read -p "LATITUD DEL LUGAR DE LA EFEMERIDE en formato 'HH:MM[N/S]'  " late 
tput cup 9 10
read -p "LONGITUD DEL LUGAR DE LA EFEMERIDE en formato 'HH:MM[WO/E]'  " lone
./swee.sh "$fecha" "$hora" "$lat" "$lon"
horar=$(echo $hora | sed "s/ //g;s/ //g;")
pm=$(echo $horar | grep -c "[Pp][\.][Mm]\|[Pp][Mm]");
horar=$(echo $horar | sed "s/[A-Za-z ]//g");
horam=$(echo $horar | cut -d ":" -f1 )
minuto=$(echo $horar | cut -d ":" -f2 )
if [ $pm -ne 0 ];then
    horam=$(($horam+12))
    horar=$(echo "$horam:$minuto")
fi
ff=$(echo "$lat" | grep "[0-9][0-9]\:[0-9][0-9] [Nn]\|[0-9][0-9]\:[0-9][0-9][Nn]");
if [ "0${#ff}" -gt "0" ];then
    latr=$(echo $lat | sed "s/[A-Z]//g");
    echo "lat=$latr";
fi
ff=$(echo $lat | grep "[0-9][0-9]\:[0-9][0-9][ ][Ss]" )
if [ "0${#ff}" -gt "0" ];then
    latr=$(echo $lat | sed "s/[A-Za-z ]//g");
    latr="S$lat";
    echo "lat=$latr";
fi
ff=$(echo $lon | grep "[0-9][0-9]\:[0-9][0-9][OWow]")
if [ "0${#ff}" -gt 0 ];then
    lonr=${lon:0:$((${#lon}-1))}
    lonr="W$lonr";
    echo "lon=$lon";
fi
ff=$(echo $lon | grep "[0-9][0-9]\:[0-9][0-9][Ee]")
if [ "0${#ff}" -gt 0 ];then
    lonr=${$lon:0:$((${#lon}-1))}
    echo "lon=$lonr";
fi
lonr=$(echo $lonr | sed "s/:/-/g")
latr=$(echo $latr | sed "s/:/-/g")
echo -e "-----\n$fecha\n$horar\n$latr\n$lonr\n----------\n"

horar=$(echo $horar | sed "s/[^0-9:]//g" | sed "s/:/-/g" )
echo "$fecha.$horar.$lonr.$latr.txt"
asc=$(cat "$fecha.$horar.$lonr.$latr.txt" | grep "p=1&" | cut -d "&" -f2 | cut -d "=" -f2)
asca=$(echo $asc | cut -d " " -f1)
asce=$(echo $asc | cut -d " " -f2)
ascap=$(./dms.sh $asca)
ascep=$(./dms.sh $asce)
echo "planeta=ASCEN&RA=$asca&pos=$ascap&tipo=ASCENCIONAL"
echo "planeta=ASCEN&RA=$asce&pos=$ascep&tipo=ECLIPTICO"

read -p "REUBICAR ASCENDENTE? (S): " reubicar
if [ "$reubicar" = "S" ];then
    zod_nam=("Aries" "Taurus" "Geminis" "Cancer" "Leo" "Virgo" "Libra" "Scorpio" "Sagittarius" "Capricornius" "Aquarius" "Piscis" " ");
    echo "DONDE DEBERIA ESTAR EL ASCENDENTE?"
    for z in ${!zod_nam[@]};do
	echo "$((z+1)) > ${zod_nam[$z]}"
    done
    read -p "NUMERO DE SIGNO:" reubicar
    reubicar=$((($reubicar*30)-1))
    segundo=1
    fechh=$(echo $fecha | sed "s/[-\/]/./g")
    dia=$(echo $fechh | cut -d "." -f1)
    mes=$(echo $fechh | cut -d "." -f2)
    anno=$(echo $fechh | cut -d "." -f3)
#    echo -e "if ($asca > $reubicar || $asca < ($reubicar - 30) || $asce > $reubicar || $asce < ($reubicar - 30) ) {print \"1\" } else {print \"0\" }"
    ascn=$(echo -e "if ($asca > $reubicar || $asca < ($reubicar - 30) || $asce > $reubicar || $asce < ($reubicar - 30) ) {print \"1\" } else {print \"0\" }" | bc -l)
    while [ $ascn -gt 0 ];do
	ascn=$(echo -e "if ($asca > $reubicar || $asce > $reubicar) {print \"1\" } else {print \"0\" }" | bc -l)
	if [ $ascn -gt 0 ];then
	    segundo=$((segundo-1))
	    if [ $segundo -lt 0 ];then
		minuto=$((minuto-1))
		segundo=59
	    fi
	    if [ $minuto -lt 0 ];then
		horam=$((horam-1))
		minuto=59
	    fi
	    if [ $horam -lt 0 ];then
		dia=$((dia-1))
		horam=23
	    fi
	fi

	ascn=$(echo -e "if ($asca < ($reubicar-30) || $asce < ($reubicar-30)) {print \"1\" } else {print \"0\" }" | bc -l)
	if [ $ascn -gt 0 ];then
	    segundo=$(echo "$segundo+1" | bc -l)
	    if [ $segundo -gt 59 ];then
		minuto=$((minuto+1))
		segundo=0
	    fi
	    if [ $minuto -gt 59 ];then
		horam=$((horam+1))
		minuto=0
	    fi
	    if [ $horam -gt 23 ];then
		dia=$((dia+1))
		horam=0
	    fi
	    if [ $dia -lt 1 ];then
		if [ $mes -eq 2 ];then
		    dia=28
		fi
		if [ $mes -eq 3 -o  $mes -eq 5 -o  $mes -eq 7 -o $mes -eq 9  -o $mes -eq 11  ];then
		    dia=30
		fi
		if [ $mes -eq 1 $mes -eq 2 -o  $mes -eq 4 -o  $mes -eq 6 -o  $mes -eq 8 -o $mes -eq 10  -o $mes -eq 12  ];then
		    dia=31
		fi
	    fi
	fi
	hora="$horam:$minuto:$segundo"
	fecha="$dia-$mes-$anno"
	horar=$(echo $hora | sed "s/[^0-9:]//g" | sed "s/:/-/g" )
	echo "VAMOS PARA: $reubicar y estamos en $asca $asce"
	echo -e "-----\n$fecha\n$horar\n$latr\n$lonr\n----------\n"
	./swee.sh "$fecha" "$hora" "$lat" "$lon"
	asc=$(cat "$fecha.$horar.$lonr.$latr.txt" | grep "p=1&" | cut -d "&" -f2 | cut -d "=" -f2)
	asca=$(echo $asc | cut -d " " -f1)
	asce=$(echo $asc | cut -d " " -f2)
	ascap=$(./dms.sh $asca)
	ascep=$(./dms.sh $asce)
	echo "planeta=ASCEN&RA=$asca&pos=$ascap&tipo=ASCENCIONAL"
	echo "planeta=ASCEN&RA=$asce&pos=$ascep&tipo=ECLIPTICO"
	ascn=$(echo -e "if ($asca > $reubicar || $asca < ($reubicar-30) || $asce > $reubicar || $asce < ($reubicar - 30) ) {print \"1\"} else {print \"0\"}" | bc -l)
    done
fi
echo "Calculando Aspectos.. $fecha.$horar.$lonr.$latr.txt ($fecha $hora $lat $lon)"
cat "$fecha.$horar.$lonr.$latr.txt" | ./aspecto2.sh $lat $lon "$fecha" "$hora" # | grep "ASCENCIONAL"
aspectos="aspectos/$fecha.$horar.$latr.$lonr"
proc=0;
cuantos=$(find "aspectos/$fecha.$horar.$latr.$lonr"  -type f | wc -l)
fs=0


diae=$(date "+%d")
mese=$(date "+%m")
anoe=$(date "+%Y")

#echo "cueuando fechas en directorios"  1>&2
#pla2=0
#mesf=$((mese+12))
#mese=$((mese-1))
#while [ $mese -lt $mesf ];do
#    mese=$((mese+1))
#	if [ $mese -gt 12 ];then
#		mese=1
#		anoe=$((anoe+1));
#	fi
#	diae=0
#   while [ $diae -lt 31 ];do
#		diae=$((diae+1))
#		houre=-1;
#		while [ $houre -lt 23 ];do
#			houre=$((houre+1))
#			minse=-1;
#			while [ $minse -lt 59 ];do
#				minse=$((minse+1))
#				#echo "$diae-$mese-$anoe-$houre-$minse"
#				if [ ! -d "transitos" ];then
#					mkdir "transitos"
#				fi
#				if [ ! -d "transitos/$lonr.$latr" ];then
#					mkdir "transitos/$lonr.$latr"
#				fi
#				if [ ! -d "transitos/$lonr.$latr/$diae-$mese-$anoe" ];then
#					mkdir "transitos/$lonr.$latr/$diae-$mese-$anoe"
#				fi
#				if [ ! -f "transitos/$lonr.$latr/$diae-$mese-$anoe/$planetb-$houre-$minse.tra" ];then
#					echo "escribiendo transitos/$lonr.$latr/$diae-$mese-$anoe/$houre-$minse.tra"
#					while read q;do
#						IFS="&"
#						planeta=($q)
#						pa=${planeta[0]}
#						planetb=${pa:2}
#						echo "$q" > "transitos/$lonr.$latr/$diae-$mese-$anoe/$planetb-$houre-$minse.tra"
#					done < <(./swem-e -nor$lat -est$lon -ut"$houre:$minse" -alt$alt -b$diae.$mese.$anoe )
#				fi
#			done
#		done
#   done
#done

#seleccionar aspecto
clear && printf '\e[3J'
prompt_x=$(tput cols)-6
tput cuu1
tput sc
pos_x=$(echo "oldscale=scale; scale=0; (($prompt_x)/2) ; scale=oldscale;" | bc -l)
tput cup 0 ${pos_x}
tput setaf 4 ; tput bold
echo -n "["
tput setaf 1
echo -n "ASPECTOS"
tput setaf 4 ; tput bold
echo -n "]"
tput rc
tput setaf 3 ; tput bold
tput cup 2 10
echo "INTRODUZCA UNA LISTA SEPARA POR COMAS DE LOS ASPECTOS A CALCULAR EFEMERIDES (Maximo 5, 0 para todos)"
fg=1
while read f;do
    f=$(cat $f)
    echo "$fg > $f"
    fg=$((fg+1))
done < <(find "aspectos/$fecha.$horar.$latr.$lonr"  -type f | sort -u )
fg=0
while [ $fg -eq 0 ];do
    read -p "LISTA DE ASPECTOS (Max 5, 0=todos): " lista
if [ "$lista" = "0" ];then
	fg=1
else
    comas=$(echo $lista | grep -o "," | wc -l)
    echo $lista
    echo $comas
    if [ $comas -gt 0 -a $comas -lt 10 ];then
	fg=1
	while [ $comas -gt 0 ];do
	    ultimo=$(echo $lista | cut -d "," -f $comas )
	    echo ".$ultimo."
	    if [ "0${#ultimo}" -gt 0 ];then
		fg=1
	    else
		fg=0
		break
	    fi
	    comas=$((comas-1))
	done
    else
	fg=0
    fi
fi
done
if [ "$lista" = "0" ];then
    while read f;do
#	clear && printf '\e[3J'
#	tput setaf 4 
#	tput cup 14 20
	g=$(echo $f | sed "s/aspectos\/$fecha.$horar.$latr.$lonr\///g") 
	echo "Examinando [[ $f ]] ($fs/$cuantos)"
	if [ ! -d "efemerides" ];then
	    mkdir "efemerides"
	fi
	if [ ! -d "efemerides/$fecha.$horar.$latr.$lonr" ];then
	    mkdir "efemerides/$fecha.$horar.$latr.$lonr"
	fi
#	tput setaf 3 ; tput bold
#	tput cup 30 40
	echo -n "<(["
#	tput cup 30 75
#	tput setaf 3 ; tput bold
	echo -n "])>"
#	tput setaf 5
#	tput cup 30 45
	./efet.sh "$f" "$late" "$lone" "$fecha" "$horar" "$latr" "$lonr" "$g"
	fs=$((fs+1))
    done < <(find "aspectos/$fecha.$horar.$latr.$lonr"  -type f | sort -u )
else
    lista=",$lista,"
    fg=0
    while read f;do
	fg=$((fg+1))
	esta=$(echo "$lista" | grep -c ",$fg,")
	if [ $esta -gt 0 ];then
#	    clear && printf '\e[3J'#
#	    tput setaf 4 
#	    tput cup 14 20
	    g=$(echo $f | sed "s/aspectos\/$fecha.$horar.$latr.$lonr\///g") 
	    echo "[[ $f ]] ($fs/$cuantos)"
	    if [ ! -d "efemerides" ];then
		mkdir "efemerides"
	    fi
	    if [ ! -d "efemerides/$fecha.$horar.$latr.$lonr" ];then
		mkdir "efemerides/$fecha.$horar.$latr.$lonr"
	    fi
	    #cat "$f" | ./efemeride3.sh  "$lat" "$lon" >  "efemerides/$fecha.$horar.$latr.$lonr/$g" & 
	    proc=$(ps -emf | grep -c "efet.sh" )
#	    tput setaf 3 ; tput bold
#	    tput cup 30 40
#	    echo -n "<(["
#	    tput cup 30 75
#	    tput setaf 3 ; tput bold
#	    echo -n "])>"
#	    tput setaf 5
	    #if [ $proc -gt 0 ];then
		#proc=$(echo "oldscale=scale; scale=0; $proc/2 ; scale=oldscale;"| bc -l)
	    #fi
	   i=1
	   while [ $i -lt 255 ];do echo "";i=$((i+1));done
	    if [ $proc -gt 2 ];then
		tput cup 30 45
		./efet.sh "$f" "$late" "$lone" "$fecha" "$horar" "$latr" "$lonr" "$g" #&
		ppid=$(ps -emf | grep "efet.sh" | sed "s/  / /g; s/  / /g" | cut -d " " -f 3 | head -n2 | tail -n1)
		wait $ppid
		echo "ESPERANDO DESOCUPAR TAREAS ($proc)"
	    else
		./efet.sh "$f" "$late" "$lone" "$fecha" "$horar" "$latr" "$lonr" "$g" 
	    fi
#	    tput setaf 4 
	    fs=$((fs+1))
	fi
    done < <(find "aspectos/$fecha.$horar.$latr.$lonr"  -type f | sort -u )
    ppid=$(ps -emf | grep "efet.sh" | sed "s/  / /g; s/  / /g" | cut -d " " -f 3 | head -n2 | tail -n1)
    if [ "0${#ppid}" -gt "0" ];then
	wait $ppid
    fi
fi
echo "$fec $lon $lat $fec2.$hora2.$lon.$lat.txt"
cat efemerides/$fecha.$horar.$latr.$lonr/* > "efemerides/$fecha.$horar.$latr.$lonr.efe"
