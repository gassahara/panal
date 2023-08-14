#!/bin/bash
erchivo=$(echo $1 | sed "s/\//\\\\\//g")
errores="....."
echo ">>$0<<<"
nf=$(echo $0 | wc -c)
nd=$((nf-1))
while [ "$nd" -gt "1" ];do
    fn=$0
            echo ":: $0" | dd bs=1 count=1 skip=$nd 2>/dev/null
    if [ "$(echo $0 | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
	ng=$nd;
	break;
    fi
    nd=$((nd-1))
done
if [ -z $ng ];then
    ng=2;
fi
fn=$(echo $0 | dd bs=1 count=$ng  2>/dev/null)
patho=`echo $fn | sed "s/\.\///g" `


nf=$(echo $erchivo | wc -c)
nd=$((nf-1))
while [ "$nd" -gt "1" ];do
    fn=$erchivo
    echo "<< $erchivo" | dd bs=1 count=1 skip=$nd 2>/dev/null
    if [ "$(echo $erchivo | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
	echo $erchivo | dd bs=1 count=1 skip=$nd 2>/dev/null
	ng=$nd;
	break;
    fi
    nd=$((nd-1))
done
if [ -z $ng ];then
    ng=2;
fi
fn=$(echo $erchivo | dd bs=1 skip=$((ng+1)) 2>/dev/null)
fn2=$(echo $erchivo | dd bs=1 count=$ng 2>/dev/null)
echo -e "______________\n$fn\n"
erchivo=`echo $fn | sed "s/$fn[\/]//g;"  | sed "s/\\\\\//g" `
pather=`echo $fn2 | sed "s/^\.\///g;" | sed "s/\\\\\//g" `

pwwd=`pwd`
#cd "$pather"

    if [ ! -d "peliculas/" ];then
	mkdir "peliculas/"
    fi
    mtitulo=$(echo $erchivo | sed "s/[ \.-]1080p\|[ \.-]720p\|[ \.-]DivX\|[ \.-]mkv\|[ \.-]mp4\|[ \.-]avi\|[ \.-]webm\|[ \.-]WEB-DL\|[ \.-]x264\|[ \.-]AC3\|\-//g")
    nombre=$(echo $mtitulo | sed "s/[ -\(\)]/_/g")
    mkdir "peliculas/$nombre"
    echo  "peliculas/$nombre"
    
    subt=""
    subtf=${erchivo:0:$((${#erchivo}-4))}
    subt=`echo "$subtf.srt"`
    echo "SUBT: $subt"
    if [ ! -f "$subt" ];then
	subt=`echo "$subtf.sub"`
    fi

    if [ ! -f "$subt" ];then
	subt=$(find "$pather" -iname "*.srt" | head -n1 )
        find "$pather" -iname "*.srt" | head -n1 
	echo "SUB:$subt"
    fi

    if [ ! -f "$subt" ];then
	subt=""
    fi

    if [ -n "$subt" ];then
    	ffmpeg -loglevel 1 -i "$subt" "$pwwd/peliculas/$nombre/$nombre.ass" -n
	echo "$pwwd/peliculas/$nombre/$nombre.ass"
        subt2="ass=$pwwd/peliculas/$nombre/$nombre.ass" #, split=2[out1][out2]"
        subt="  -vf  "
	map1="-map [out1]" 
	map2="-map [out2]" 
	map3="-map '[out3]'" 
	echo -e " SUBBT: $subt2 \n"
    fi

    ls -l "$pwwd/$pather/$erchivo"
    nombrearchivo="$pwwd/$pather/$erchivo"

    echo $nombrearchivo
    	    echo "sacando imagenes $nombrearchivo"
	    ffmpeg -ss 1000 -threads 2 -r 1 -loglevel 1 -i "$arc" -frames:v 5 -vf "select=gt(scene\\,0.65)" -vsync vfr -vf fps=fps=1/610 "$nombrearchivo-%02d.jpg" -n 2>&1


    cd $pwwd
    #1>"peliculas/$erchivo.hazmp4depeliculass.log" 2>&1
    #echo "REVISANDO $erchivo"

echo "TERMINO $erchivo"
