#!/bin/bash
query=$1
if [ -f "palabras/$query" ];then
    cabeza=$(cat palabras/$query | head -n2 | tail -n1)
    tienedireccion=0;
    esarc=0
    esdir=0
    ind=1
    s2=$(echo $cabeza | grep -o ";" | wc -l)
    s2=$((s2+1))
    while [ $s2 -gt 0 ];do
	t=$(echo $cabeza | cut -d ";" -f$s2)
	if [ ${#t} -gt 1 ];then
	if [ -f "$t" ];then
	    indice=$s2
	    esarc=1;
	    s2=0
	else
	    nnn=$(./agarragethttp "$t" | wc -c | tr -d " ")
	    if [ -z "$nnn"  ];then
		indice=$s2
		esdir=1
		s2=0
	    fi
	fi
	fi
	s2=$((s2-1))
    done
    if [ $((esdir+$esarc)) -gt 0 ];then
	tienedireccion=1
    fi
    
    if [ "$tienedireccion" -gt "0" ];then
	while read n;do
	    i=1
		    if [ $esdir -gt 0 ];then
			t=$(echo $n | cut -d ";" -f$indice)
			./hazgethttp "$t" | grep "$query"
		    fi
		    if [ $esarc -gt 0 ];then
			t=$(echo $n | cut -d ";" -f$indice)
			echo -e "<p><a href=\"$t\"> $t </a></p>\n<p>"
			grep "$query" "$t" | dd bs=1 count=150 2>/dev/null
			echo -e "</p>\n";
		    fi
		i=$((i+1))
	done < <(cat palabras/$query)
    fi
else
	echo -e "\n <p> LO SIENTO, ESA PALABRA NO ESTA INDIZADA </p>\n"
fi
