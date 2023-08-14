#!/bin/bash
if [ -z "$1" ];then
    n="./"
else
    n="$1"
fi

while read nn;do
case "$nn" in
    *htm|*html)
if [ -n "$nn" ];then
    nombre=$(echo $nn | cut -d "_" -f1 )
    esta=$(cat $nn | ./stdbuscaarg "<td>filesubir</td><td>")
    fn=0;
    if [ -n "$esta" ];then
	echo "ESTA"
	query=$(cat $nn | grep "<td>query<" | sed "s/<td\>/;/g; s/<\/td\>/;/g " | tr "[\n\r\t]" ";" | cut -d ";" -f5)
	echo "<HTML><HEAD> <style>p, td, span { font-family: sans-serif; font-size: 12pt; }</style> </HEAD><BODY><p align=center> CATALOGO Y BUSQUEDA LIBRE, PURA Y HONESTA ;) </p><table style=\"width:80%;height:80%;position:absolute;left:5%;top:10%;\"><tr>" > $nombre.html
	ia=0
	while read e;do
	    nombro=$(echo $e | cut -d "." -f1)
	    gcc funciones/$e -o $nombro
	done < <(ls -1 funciones/*.c)
	while read e;do
	    if [ ! -x $e ];then
		chmod +x funciones/$e
	    fi
	done < <(ls -1 funciones/*.sh)
	while read e;do
	    if [ -x funciones/$e ];then
		fn=$(ls -1 funciones/$query*.html | wc -l | tr -d " " )
		fn=$((fn+1))
		echo "** $e $query) **"
		funciones/$e "$query" >> "funciones/$query$fn.html" &
		echo -e "\n<td><table><tr><td rowspan=3> <a href=\"funciones/$query$fn.html\"><img style=\"width:100px;\" src=\"front1b.gif\" alttext=\"ABRIR consulta con $e\"> </a> </td>" >> $nombre.html
		cat $e >> $nombre_$e.txt
		if [ ! -f $palabras3.html ];then
		while read ee;do
		    echo "<a href=\"$ee\"> $ee </a>" >> palabras3.html
		done < <(ls -1 palabras3/ )
		fi
		echo "<td><a href=\"$nombre_$e.txt\"> Ver Codigo </a> </td></tr><tr><td> <a href=\"palabras3.html\"> Ver Catalogo </a> </td> </tr>  <tr><td><a onclick=\"document.getElementsByTagName('iframe')[0].src ='funciones/$query$fn.html'\"> Ver Resultado de $e con $query </a> </td></tr></table> " >> $nombre.html
		ia=$((ia+1))
	    fi
	done < <(ls -1 funciones/ )
	echo "</tr><tr colspan=4><td><iframe style=\"width:100%\"></iframe></td></tr></table></body></html>" >> $nombre.html
	mv -v $nn $nn.log
    fi
fi
;;
esac
done < <(./listadodirectorio_files $n )
