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
    
    if [ -n "$subt2" ];then
	echo -e "__________________\n $pwwd/$pather/$erchivo"


	VP9_DASH_PARAMS="-tile-columns 4 -frame-parallel 1"
	ffmpeg  -i  "$pwwd/$pather/$erchivo"   -movflags frag_keyframe+empty_moov  -probesize 180000   -filter_threads 2  -threads 2 -c:v libvpx-vp9 ${VP9_DASH_PARAMS}  -an -b:v 3200k -minrate 900k -maxrate 5200k  -bufsize 36400k  -vf "$subt2" -f webm -metadata  title=$titulo -strict -2 -dash 1  -acodec:0 vorbis "$pwwd/peliculas/$nombre/$nombre-u.webm" -y
	echo "modu" ffmpeg  -i  "$pwwd/$pather/$erchivo"   -movflags frag_keyframe+empty_moov  -probesize 180000   -filter_threads 2  -threads 2 -c:v libvpx-vp9 ${VP9_DASH_PARAMS}  -an -b:v 3200k -minrate 900k -maxrate 5200k  -bufsize 36400k  -vf "$subt2" -f webm -metadata  title=$titulo -strict -2 -dash 1  -acodec:0 vorbis "$pwwd/peliculas/$nombre/$nombre-u.webm" -y

	ffmpeg  -i  "$pwwd/$pather/$erchivo"   -movflags frag_keyframe+empty_moov  -probesize 180000  -threads 2   -filter_threads 2  -c:v libvpx-vp9 ${VP9_DASH_PARAMS}  -an -b:v 1800k -minrate 900k -maxrate 5200k  -bufsize 36400k  -vf:0 scale=-2:480 -vf "$subt2" -f webm -metadata  title=$titulo -strict -2 -dash 1  -acodec:0 vorbis "$pwwd/peliculas/$nombre/$nombre-480.webm" -y
	ffmpeg -threads 1 -i "$pwwd/$pather/$erchivo"    -strict -2 -ac 2 -c:a vorbis -b:a 128k -vn -f webm -dash 1  "$pwwd/peliculas/$nombre/$nombre-audio.ogg"  -y
	echo "modu"

	ffmpeg -f webm_dash_manifest -i "$pwwd/peliculas/$nombre/$nombre-u.webm"  -f webm_dash_manifest -i "$pwwd/peliculas/$nombre/$nombre-480.webm"  -f webm_dash_manifest  -threads 3 -i "$pwwd/peliculas/$nombre/$nombre-audio.ogg" -c copy -map 0 -map 1 -map 2 -adaptation_sets "id=0,streams=0,1 id=streams=2" "$pwwd/peliculas/$nombre/$nombre-webm.xml" -y -t 600
	echo "modu"

    else
	echo -e "__________________\n $pwwd/$pather/$erchivo"
	mkdir "peliculas/$nombre"
	VP9_DASH_PARAMS="-tile-columns 4 -frame-parallel 1"
	ffmpeg  -i  "$pwwd/$pather/$erchivo"  -movflags frag_keyframe+empty_moov -threads 2     -filter_threads 2  -probesize 180000 -c:v libvpx-vp9 ${VP9_DASH_PARAMS}  -an -b:v 3200k -minrate 900k -maxrate 5200k  -bufsize 36400k   -f webm -metadata  title=$titulo -strict -2 -dash 1  -acodec:0 vorbis "$pwwd/peliculas/$nombre/$nombre-u.webm" -y
	echo "modu"

	ffmpeg  -i  "$pwwd/$pather/$erchivo"   -movflags frag_keyframe+empty_moov -threads 2 -c:v libvpx-vp9 ${VP9_DASH_PARAMS}   -probesize 180000 -an -b:v 1800k -minrate 900k -maxrate 5200k  -bufsize 36400k  -vf:0 scale=-2:480 -f webm -metadata  title=$titulo -strict -2 -dash 1  -acodec:0 vorbis "$pwwd/peliculas/$nombre/$nombre-480.webm" -y
	ffmpeg -threads 1 -i "$pwwd/$pather/$erchivo"    -strict -2 -ac 2 -c:a vorbis -b:a 128k -vn -f webm -dash 1  "$pwwd/peliculas/$nombre/$nombre-audio.ogg"  -y
	echo "modu"
	ffmpeg -f webm_dash_manifest -i "$pwwd/peliculas/$nombre/$nombre-u.webm"    -f webm_dash_manifest -i "$pwwd/peliculas/$nombre/$nombre480.webm"  -f webm_dash_manifest -threads 2 -i "$pwwd/peliculas/$nombre/$nombre-audio.ogg" -c copy -map 0 -map 1 -map 2 -adaptation_sets "id=0,xostreams=0,1 id=streams=2" "$pwwd/peliculas/$nombre/$nombre-webm.xml" -y
	echo "modu"
    fi
    cd $pwwd
    #1>"peliculas/$erchivo.hazmp4depeliculass.log" 2>&1
    #echo "REVISANDO $erchivo"

echo "TERMINO $erchivo"
