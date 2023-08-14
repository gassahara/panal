#!/bin/bash
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
pasa=0
videos="$1"
videon=$videos
while [ $(echo "$videon" | $PrPWD/stdbuscaarg_count "/" ) -gt 0 ];do
    videon=$(echo "$videon" | $PrPWD/stdcdr "/" )
done
videop=$(echo "$videos" | $PrPWD/stdcarsin "$videon")
videon2=$(echo "$videon" | $PrPWD/stddelcar ".")
videoo="$videop$videon2"
echo "c $videos"
echo "p $videop"
echo "v $videon"
echo "o $videoo"
mkdir "$PrPWD/$videoo"
echo "convirtiendo $PrPWD/$videoo/480-$videon"
ffmpeg -loglevel 32  -threads 4 -i "$PrPWD/$videos"  -vcodec libx264  -g 92 -movflags frag_keyframe+faststart+empty_moov -an -dash 80 -b:v 254320 -bufsize 24400k  -vf "scale=240:-2" -qscale 3 -force_key_frames "expr:gte(t,n_forced*2)" -f dash -init_seg_name "init_240-$videon" -media_seg_name "segmento_240-\$Number\$-$videon" "$PrPWD/$videoo/240-$videon-mpd-u.mpd" -y
ffmpeg -loglevel 32  -threads 4 -i "$PrPWD/$videos"  -vcodec libx264  -g 92 -movflags frag_keyframe+faststart+empty_moov -an -dash 80 -b:v 507246 -bufsize 24400k  -vf "scale=320:-2" -qscale 3 -force_key_frames "expr:gte(t,n_forced*2)" -f dash -init_seg_name "init_320-$videon" -media_seg_name "segmento_320-\$Number\$-$videon" "$PrPWD/$videoo/320-$videon-mpd-u.mpd" -y
ffmpeg -loglevel 32  -threads 4 -i "$PrPWD/$videos"  -vcodec libx264  -g 92 -movflags frag_keyframe+faststart+empty_moov -an -dash 80 -b:v 759798 -bufsize 24400k -vf "scale=480:-2" -qscale 3 -force_key_frames "expr:gte(t,n_forced*2)" -f dash -init_seg_name "init-480-$videon"  -media_seg_name "segmento-480-\$Number\$-$videon" "$PrPWD/$videoo/480-$videon-mpd-u.mpd" -y
ffmpeg -loglevel 32  -threads 4 -i "$PrPWD/$videos"  -vcodec libx264  -g 92 -movflags frag_keyframe+faststart+empty_moov -an -dash 80 -b:v 4952892 -bufsize 24400k  -vf "scale=720:-2" -qscale 3 -force_key_frames "expr:gte(t,n_forced*2)" -f dash -init_seg_name "init_720-$videon" -media_seg_name "segmento_720-\$Number\$_$videon" "$PrPWD/$videoo/720-$videon-mpd-u.mpd" -y
echo "HACIENDO MPD"
ffmpeg -loglevel 32  -threads 4 -i "$PrPWD/$videos"  -vcodec libx264  -g 60 -keyint_min 60 -movflags frag_keyframe+faststart+empty_moov -probesize 180000 -ac 2 -c:a aac -b:a 196k -dash 1 -b:v 9914554 -bufsize 36400k  -force_key_frames "expr:gte(t,n_forced*2)" -f dash -init_seg_name "init_u-\$RepresentationID\$-$videon" -media_seg_name "segmento_u-\$RepresentationID\$_\$Number\$-$videon" "$PrPWD/$videoo/$videon-mpd-u.mpd" -y
echo "HECHO MPD"
cadr=$(echo -n "<Representation "|$PrPWD/stdtohex)
cad1=$(cat "$PrPWD/$videoo/240-$videon-mpd-u.mpd"|$PrPWD/stdcdr 'contentType="video"'|$PrPWD/stdcdr '<Representation id="0"'|$PrPWD/stdcar "</Representation>"|$PrPWD/stdtohex)
n=$(cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdbuscaarg_donde_hasta 'contentType="video"')
i=$(cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcdrn "0$n"|$PrPWD/stdbuscaarg_donde_hasta '<Representation id="0"')
echo "n 0$n+0$i-22"
n=$(echo "0$n+0$i-22"|bc)
cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcarn "0$n" > "$PrPWD/$videoo/$videon-mpd-u.tmp"
echo "$cadr $cad1" |$PrPWD/stdfromhex >> "$PrPWD/$videoo/$videon-mpd-u.tmp"
cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcdrn "0$n" >> "$PrPWD/$videoo/$videon-mpd-u.tmp"
mv -v "$PrPWD/$videoo/$videon-mpd-u.tmp" "$PrPWD/$videoo/$videon-mpd-u.mpd"

cad1=$(cat "$PrPWD/$videoo/320-$videon-mpd-u.mpd"|$PrPWD/stdcdr 'contentType="video"'|$PrPWD/stdcdr '<Representation id="0"'|$PrPWD/stdcar "</Representation>"|$PrPWD/stdtohex)
n=$(cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdbuscaarg_donde_hasta 'contentType="video"')
i=$(cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcdrn "0$n"|$PrPWD/stdbuscaarg_donde_hasta '<Representation id="0"')
echo "n 0$n+0$i-22"
n=$(echo "0$n+0$i-22"|bc)
cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcarn "0$n" > "$PrPWD/$videoo/$videon-mpd-u.tmp"
echo "$cadr $cad1" |$PrPWD/stdfromhex >> "$PrPWD/$videoo/$videon-mpd-u.tmp"
cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcdrn "0$n" >> "$PrPWD/$videoo/$videon-mpd-u.tmp"
mv -v "$PrPWD/$videoo/$videon-mpd-u.tmp" "$PrPWD/$videoo/$videon-mpd-u.mpd"

cad1=$(cat "$PrPWD/$videoo/480-$videon-mpd-u.mpd"|$PrPWD/stdcdr 'contentType="video"'|$PrPWD/stdcdr '<Representation id="0"'|$PrPWD/stdcar "</Representation>"|$PrPWD/stdtohex)
n=$(cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdbuscaarg_donde_hasta 'contentType="video"')
i=$(cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcdrn "0$n"|$PrPWD/stdbuscaarg_donde_hasta '<Representation id="0"')
echo "n 0$n+0$i-22"
n=$(echo "0$n+0$i-22"|bc)
cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcarn "0$n" > "$PrPWD/$videoo/$videon-mpd-u.tmp"
echo "$cadr $cad1" |$PrPWD/stdfromhex >> "$PrPWD/$videoo/$videon-mpd-u.tmp"
cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcdrn "0$n" >> "$PrPWD/$videoo/$videon-mpd-u.tmp"
mv -v "$PrPWD/$videoo/$videon-mpd-u.tmp" "$PrPWD/$videoo/$videon-mpd-u.mpd"

cad1=$(cat "$PrPWD/$videoo/720-$videon-mpd-u.mpd"|$PrPWD/stdcdr 'contentType="video"'|$PrPWD/stdcdr '<Representation id="0"'|$PrPWD/stdcar "</Representation>"|$PrPWD/stdtohex)
n=$(cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdbuscaarg_donde_hasta 'contentType="video"')
i=$(cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcdrn "0$n"|$PrPWD/stdbuscaarg_donde_hasta '<Representation id="0"')
echo "n 0$n+0$i-22"
n=$(echo "0$n+0$i-22"|bc)
cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcarn "0$n" > "$PrPWD/$videoo/$videon-mpd-u.tmp"
echo "$cadr $cad1" |$PrPWD/stdfromhex >> "$PrPWD/$videoo/$videon-mpd-u.tmp"
cat "$PrPWD/$videoo/$videon-mpd-u.mpd"|$PrPWD/stdcdrn "0$n" >> "$PrPWD/$videoo/$videon-mpd-u.tmp"
mv -v "$PrPWD/$videoo/$videon-mpd-u.tmp" "$PrPWD/$videoo/$videon-mpd-u.mpd"
