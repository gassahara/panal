#$1: directorio, $2 si se revisan solo los archivos mas nuevos que la fecha de creacion de este archivo
#!/bin/bash
archivos=()
raiz="http://192.168.77.145/nube"
if [ "$2" -eq "0" -o  -z "$2" ];then
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find "$1" -type f -newer $0 -print0)
else
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find "$1" -type f -print0)
fi
echo "--"
peliculas=()
IFS=""
p2=1
for arc in "${archivos[@]}";do
    espelicula=$(./comepeliculas.sh "$arc")
    esmpd=$(./comempds.sh "$arc")
    #echo -e "${!archivos[@]} \n"
    if [ -n "$espelicula" -o -n "$esmpd" ]; then
	echo %% $espelicula %%%%%
	peliculas[$p2]="$arc"
	echo "-- ${peliculas[$p2]}"
	if [ -n "${peliculas[$p2]}" ];then
	    echo ">>$arc<<<"
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

	    echo "patho2: $patho2"
	    nombre=$(echo "${peliculas[$p2]}" | sed "s/\.webm\|\.mp4//g; s/[ \.-]1080p\|[ \.-]720p\|[ \.-]DivX\|[ \.-]mkv\|[ \.-]mp4\|[ \.-]avi\|[ \.-]webm\|[ \.-]WEB-DL\|[ \.-]x264\|[ \.-]AC3\|\-\|subs\|subtitle\|rip_\|subrip\|ripped\|: Nederlands\|\.com\|extended\|scorp\|sc0rp\|dvdrip\|XViDRLD\|Bluray\|mpd\|xvid\|WAF\|\-//Ig;" | sed "s/$patho2//g;")
	    titulo=$(ffmpeg -i "${peliculas[$p2]}" 2>&1 | grep -i "title" | head -n1)
	    titulo=$(echo -n "$titulo" | sed "s/subs\|subtitle\|rip_\|subrip\|ripped\|: Nederlands\|\.com\|extended\|scorp\|sc0rp\|dvdrip\|XViDRLD\|Bluray\|mpd\|xvid\|WAF\|\-//Ig" )
	    titulo="$nombre ($titulo)"
	    echo -e "TITULO: $titulo\n"
	    nombre=$(echo $nombre | sed "s/[()\.-]//Ig")

	    echo "patho2: $patho"
	    echo "sacando imagenes ${peliculas[$p2]}"
	    if [ -n "$3" ];then
		pps="$3/$nombro-%02d.jpg"
	    else
		pps="${peliculas[$p2]}-%02d.jpg"
	    fi
	    echo "pps=$pps"
	    ffmpeg -ss 1000 -threads 2 -r 1 -loglevel 1 -i "$arc" -frames:v 5 -vf "select=gt(scene\\,0.65)" -vsync vfr -vf fps=fps=1/610 "$pps" -n 2>&1
	    imgs=()
	    p=1
	    echo "<<<<<>>>>>>>>"
	fi
    fi
done

