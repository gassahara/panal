#!/bin/bash
errores="....."
echo ">>$0<<<"

nomprograma=$0
while [ $(echo $nomprograma | /var/www/html/nube/stdbuscaarg_count "/") -gt 0 ];do
    nomprograma=$(echo $nomprograma | /var/www/html/nube/stdcdr "/" )
done
patho=$(echo $0 | /var/www/html/nube/stdcarsin "/$nomprograma")
echo $patho $nomprograma
fn=$1
while [ $(echo $fn | /var/www/html/nube/stdbuscaarg_count "/") -gt 0 ];do
    fn=$(echo $fn | /var/www/html/nube/stdcdr "/" )
done
pather=$(echo $1 | /var/www/html/nube/stdcarsin "/$fn")
echo "pather/$fn" $pather $fn

if [ ! -d "peliculas/" ];then
    mkdir "$patho/peliculas/"
fi
mtitulo=$(echo $fn | sed "s/[ \.-]1080p\|[ \.-]720p\|[ \.-]DivX\|[ \.-]mkv\|[ \.-]mp4\|[ \.-]avi\|[ \.-]webm\|[ \.-]WEB-DL\|[ \.-]x264\|[ \.-]AC3\|\-//g")
nombre=$(echo $mtitulo | sed "s/[ -\(\)]/_/g")
mkdir "$patho/peliculas/$nombre"
echo "_____________________________"
echo  "$patho/peliculas/$nombre"

echo -e "_-_-_-_-_-_-_-__\n $pather/$fn"
ffmpeg -loglevel 32  -threads 2 -i "$pather/$fn" -vcodec libx264 -g 92 -movflags frag_keyframe+faststart+empty_moov -probesize 180000 -ac 2 -c:a aac -b:a 196k -dash 1 -b:v 4800k -minrate 900k -maxrate 5200k  -bufsize 36400k  -force_key_frames "expr:gte(t,n_forced)"   -f dash -init_seg_name "init_u_\$RepresentationID\$_$nombre.mp4" -media_seg_name "segmento_u_\$RepresentationID\$_\$Number\$_$nombre.mp4" -metadata  title="$mtitulo"  "$patho/peliculas/$nombre/$nombre-mpd-u.mpd" -y

ffmpeg -loglevel 32  -threads 2  -i "$pather/$fn" -vcodec libx264 -g 92 -movflags frag_keyframe+faststart+empty_moov -probesize 180000 -ac 2 -c:a aac -b:a 196k -dash 1 -b:v 4800k -minrate 900k -maxrate 5200k  -bufsize 36400k  -vf "scale=-2:480"  -qscale 3 -force_key_frames "expr:gte(t,n_forced)"  -f dash -init_seg_name "init-480-\$RepresentationID\$_$nombre.mp4" -media_seg_name "segmento-480_\$RepresentationID\$_\$Number\$_$nombre.mp4" -metadata  title="$mtitulo"  "$patho/peliculas/$nombre/$nombre-mpd-480.mpd" -y

echo "$patho/peliculas/$nombre/$nombre-mpd-u.mpd"
echo "modu"

leng=$(echo -n $1 |wc -c)
leng=$(echo $leng-4|bc )
subt2=$(echo $1 | /var/www/html/nube/stdcarn $leng)
subt="$subt2.vtt"
echo "$subt"
if [ ! -f "$subt" ];then
    subt="$subt2.srt"
    if [ -f "$subt" ];then
	python /var/www/srt-xls-vtt-transfrom/srt2vtt.py "$subt" "$patho/peliculas/$nombre/"
    else
	subt=$(find "$patho/peliculas/$nombre/" -name "*.srt" |head -n1)
    fi
else
    cp "$subt" "$patho/peliculas/$nombre/$nombre.vtt"
fi
echo "$patho/peliculas/$nombre/$nombre.vtt"
echo "............."
if [ -n "$subt" ];then
    cat "$patho/peliculas/$nombre/$nombre-mpd-u.mpd" | /var/www/html/nube/stdcarsin "<AdaptationSet " > "$patho/peliculas/$nombre/u.mpd"
    echo "<AdaptationSet contentType=\"text\" lang=\"en\" mimeType=\"text/vtt\"> <Role schemeIdUri=\"urn:mpeg:dash:role:2011\" value=\"subtitle\"/> <Representation bandwidth=\"218\" id=\"subtitles/en\"> <BaseURL>$subt</BaseURL> </Representation> </AdaptationSet>" >> "$patho/peliculas/$nombre/u.mpd"
    cat "$patho/peliculas/$nombre/$nombre-mpd-u.mpd" | /var/www/html/nube/stdcdrcon "<AdaptationSet " >> "$patho/peliculas/$nombre/u.mpd"
    mv "$patho/peliculas/$nombre/u.mpd" "$patho/peliculas/$nombre/$nombre-mpd-u.mpd"
    cat "$patho/peliculas/$nombre/$nombre-mpd-480.mpd" | /var/www/html/nube/stdcarsin "<AdaptationSet " > "$patho/peliculas/$nombre/u.mpd"
    echo "<AdaptationSet contentType=\"text\" lang=\"en\" mimeType=\"text/vtt\"> <Role schemeIdUri=\"urn:mpeg:dash:role:2011\" value=\"subtitle\"/> <Representation bandwidth=\"218\" id=\"subtitles/en\"> <BaseURL>$subt</BaseURL> </Representation> </AdaptationSet>" >> "$patho/peliculas/$nombre/u.mpd"d
    cat "$patho/peliculas/$nombre/$nombre-mpd-480.mpd" | /var/www/html/nube/stdcdrcon "<AdaptationSet " >> "$patho/peliculas/$nombre/u.mpd"
    mv "$patho/peliculas/$nombre/u.mpd" "$patho/peliculas/$nombre/$nombre-mpd-480.mpd"
fi

echo "TERMINO $erchivo"
