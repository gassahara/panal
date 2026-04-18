#$1: directorio, $2 si se revisan solo los archivos mas nuevos que la fecha de creacion de este archivo #3 si se comaparan las imagenes $4 si se crean las imagenes 
#!/bin/bash
arc="$1"
nf=$(echo "$arc" | wc -c)
nd=$((nf-1))
while [ "$nd" -gt "1" ];do
    fn="$arc"
    if [ "$(echo \"$arc\" | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
	ng=$nd;
	fn=$(echo $arc | dd bs=1 count=$ng  2>/dev/null)
	break;
    fi
    nd=$((nd-1))
done
patho=$fn
patho2=$(echo "$fn" | sed "s/\//\\\\\//g; s/\./\\\\\\./g; ")
nombro=$(echo $arc | dd bs=1 skip=$ng  2>/dev/null)
nombre=$(echo "$nombro" | sed "s/\.webm\|\.mp4//g; s/[ \.-]1080p\|[ \.-]720p\|[ \.-]DivX\|[ \.-]mkv\|[ \.-]mp4\|[ \.-]avi\|[ \.-]webm\|[ \.-]WEB-DL\|[ \.-]x264\|[ \.-]AC3\|\-\|subs\|subtitle\|rip_\|subrip\|ripped\|: Nederlands\|\.com\|extended\|scorp\|sc0rp\|dvdrip\|XViDRLD\|Bluray\|mpd\|xvid\|WAF\|\-//Ig;" | sed "s/$patho2//g;")
titulo=$(echo -n "$nombre" | sed "s/subs\|subtitle\|rip_\|subrip\|ripped\|: Nederlands\|\.com\|extended\|scorp\|sc0rp\|dvdrip\|XViDRLD\|Bluray\|mpd\|xvid\|WAF\|\-//Ig" )
echo $titulo
