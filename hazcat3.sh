#!/bin/bash
mkdir palabras3
mkdir temporal3
if [ -z "$1" ];then
    n="./"
else
    n="$1"
fi
while read nn;do
    case "$nn" in
	*htm*|*txt|*xml)
	    if [ -n "$nn" ];then
		echo $nn
		lynx "$nn" --dump | ./stdseparapalabras_dict | sort -u -r > ll3.txt
		echo "" > $ll33.txt
		while read rr;do
		    estaa=$(cat words-wne-2006-12-06.txt | ./stdbuscaarg "$rr")
		    if [ -n "$estaa" ];then
			echo $rr >> $ll33.txt
		    fi
		    done< <(cat ll3.txt)
		mv -v ll33.txt ll3.txt
		AFS=$IFS
		IFS="\n"
		while read ll;do
		    if [ ${#ll} -gt 2 ];then
			nesta=$(cat "$nn"  | ./stdbuscaarg_count "$ll" )
			echo "== $ll ";
			while read lll;do
			    echo "*** $ll ";
			    nnesta=$(cat "$nn"  | ./stdbuscaarg_count "$lll" )
			    nesta=$((nesta+nnesta))
			done< <(grep "<entry" wne-2006-12-06.xml -2 | grep -2 -w "$ll" | grep -w "<entry" | sed -n "s/.*<entry word=\"\(.*#\).*/\1/p" | cut -d "#" -f1 | sed "s/_/ /g")
			esta=""
			if [ -f "palabras3/$ll" ];then
			    esta=$(cat palabras3/$ll | ./stdbuscaarg )
			fi
			if [ -z "$esta" ];then
			    echo escribe $nn en $ll
			    cat palabras3/$ll > temporal3/$ll
			    echo -e "$nesta;$ll;$nn" >> temporal3/$ll
			    cat temporal3/$ll | sort -u -r > palabras3/$ll
			    rm -v temporal3/$ll
			fi
		    fi
		done < <(cat ll3.txt)
		IFS=$AFS
	    fi
	    nn=""
            ;;
    esac
done < <(./listadodirectorio.sh $n)
