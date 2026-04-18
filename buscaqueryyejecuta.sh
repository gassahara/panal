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
    esta=$(cat $nn | ./stdbuscaarg "<td>query</td><td>")
    fn=0;
    if [ -n "$esta" ];then
	echo "ESTA"
	query=$(cat $nn | grep "<td>query<" | sed "s/<td\>/;/g; s/<\/td\>/;/g " | tr "[\n\r\t]" ";" | cut -d ";" -f5)
	echo "<HTML><style> p { border-color: black; border-width: 1px;  border-collapse: 'collapse'; font-family: sans-serif; font-size: 12px; color:black; font-weight:normal; vertical-align:middle; text-align:center; } div {overflow: auto; float:left; border-collapse:collapse; height: 21%; width: 30%; text-align:center; span: 3%;} div:nth-child() {margin-left:11%; background-color: lightgreen; } div:nth-child() {margin-left:11%; background-color: lightgreen; } div:nth-child() { margin-right:14px; margin-left:5px; width: 18%; overflow: auto; float:left; border-collapse:collapse; height: 26%; width: 20%; text-align:center;} a:visited{text-decoration:none;} a {font-family:sans;font-weight:bold;color:blue;text-decoration:none;text-align:center;} img {width:33%;display:inline;} ul,li {display:inline;} </style></head><body style=\"background-color:#404040;background-image:url('hexagonos2.png');background-size: 100%;\"><p align=center style=\"font-size: 20pt;\" > <b>CATALOGO Y BUSQUEDA LIBRE, PURA Y HONESTA ;)</b> </p><table style=\"width:80%;height:80%;position:absolute;left:5%;top:10%;\"><tr>" > $nombre.html
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
	    if [ -x $e ];then
		fn=$(ls -1 funciones/$query*.html | wc -l | tr -d " " )
		fn=$((fn+1))
		echo "** $e $query) **"
		funciones/$e "$query" >> "funciones/$query$fn.html"
		echo -e "\n<td><table><tr><td rowspan=3> <a href=\"funciones/$query$fn.html\"><img style=\"width:100px;\" src=\"front1b.gif\" alttext=\"ABRIR consulta con $e\"> </a> </td>" >> $nombre.html
		echo "<HTML><BODY><pre>" > $nombre_$e.html
		cat $e | sed "s/\.\/\(.*\) /\.\/<a href=\"\1.c\"\>\1<\/a\> /g" >>  $nombre_$e.html
		echo "</pre></body></html>"
		if [ ! -f palabras3.html ];then
		while read ee;do
		    echo "<a href=\"$ee\"> $ee </a>" >> palabras3.html
		done < <(ls -1 palabras3/ )
		fi
		echo "<td><a href=\"$nombre_$e.html\"> Ver Codigo </a> </td></tr><tr><td> <a href=\"palabras3.html\"> Ver Catalogo </a> </td> </tr>  <tr><td><a onclick=\"document.getElementById('ifra').src ='funciones/$query$fn.html'\"> Ver Resultado de $e con $query </a> </td></tr></table> " >> $nombre.html
		ia=$((ia+1))
	    fi
	done < <(ls -1 funciones/ )
	echo "</tr><tr ><td colspan=4><iframe id='ifra' style=\"width:90%;height:90%;\"></iframe></td></tr></table> </table>  <table><tr><td><input type=\"button\" onclick=\"window.location.reload();\" value=\"RECARGAR\"> </td><td> <iframe=\"src=p2.html\"></iframe></td></tr></table>  </body></html>" >> $nombre.html
	mv -v $nn $nn.log
    fi
fi
;;
esac
done < <(./listadodirectorio_files $n )
