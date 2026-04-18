#$1: directorio, $2 si se revisan solo los archivos mas nuevos que la fecha de creacion de este archivo #3 si se comaparan las imagenes $4 si se crean las imagenes 
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

echo "<<<<<>>>>>>>>"
for p in "${!peliculas[@]}";do
    p2=1
    menor=99999999
    igual=()
    IFS="$
"
    while [ $p2 -lt "${#peliculas[@]}" ];do
	if [ ! $p2 -eq $p ];then
	    echo -e "COMPARANDO \n${peliculas[$p]} \n cn ${peliculas[$p2]}\n"
	    str1=$(sed -ne "s/.*\"PT\(.*\"\)/ \1/p; s/.* \([0-9]\{1,\}\)H/Horas: \1 \\\\\n /p; s/.* \([0-9]\{1,\}\)M/Minutos: \1 \\\\\n /p;" ${peliculas[$p]}  | grep "Horas\|Minutos\|Segundos")
	    str2=$(sed -ne "s/.*\"PT\(.*\"\)/ \1/p; s/.* \([0-9]\{1,\}\)H/Horas: \1 \\\\\n /p; s/.* \([0-9]\{1,\}\)M/Minutos: \1 \\\\\n /p;" ${peliculas[$p2]}  | grep "Horas\|Minutos\|Segundos")
	    if [ "$str1" = "$str2" ];then
		p3=1
		while [ $p3 -lt 5 ];do
		    if [ -f "${peliculas[$p]}-0$p3.jpg" ];then
			if [ -f "${peliculas[$p2]}-0$p3.jpg" ];then
			    menos=$(compare-im6 -metric mae "${peliculas[$p]}-0$p3.jpg"  "${peliculas[$p2]}-0$p3.jpg" -compose src  -alpha opaque -fuzz 20 -similarity-threshold 20% c.jpg 2>&1 \; | grep -o "(\b[^)]*" | sed "s/(//g; s/[0]\.//g; s/\-*//g; " )
			    echo "${peliculas[$p2]} M: $menos"
			    if [ "0$menos" -lt "399015" ];then
				igual+=("${peliculas[$p2]}")
				menor=$menos
			    fi
			fi
		    fi
		    p3=$((p3+1))
		done
	    fi
	fi
	p2=$((p2+1))
    done

    echo -e "${peliculas[$p]} != $igual por $menor "
    for ig in "${igual[@]}";do
	rm -v  "${peliculas[$p]}.html"
	if [ -n "$ig" ]; then
	    echo -e "-------- $ig \n"
	    igual2=$(echo ${peliculas[$p]} | sed "s/\//\\\\\//Ig" )
	    igual3=$(echo $ig | sed "s/\//\\\\\//Ig" )
	    echo -e "${peliculas[$p]}  = $ig "
	    nombre=$(echo "${peliculas[$p]}" | sed "s/\.webm\|\.mp4//Ig" )
	    echo "nombre>> $nombre"
	    if [ -f "$ig.html" -a -f " ${peliculas[$p]}" ];then
		rm -v "$ig.html"
	    fi
	    if [ -f "$nombre.html" ];then
		cat "$nombre.html" | sed "s/<\/video/<source src=\"\.\.\/$igual3\"><\/source><\/video/Ig"
		esta=$(grep "<source src=\"\.\.\/$igual2\"" $nombre.html)
		echo "esta <<>> $esta"
		if [ -z "$esta" ];then
		    escribe=$(cat "$nombre.html" | sed "s/<\/video/<source src=\"\.\.\/$igual2\"><\/source><\/video/Ig" )
		    echo $escribe > "$nombre.html"
		fi
	    else

		poster=$(grep -oi "<img \b[^>]*>" ${visores[$p]} | grep "id=\"poster\"" )
		titulo=$(ffmpeg -i "${peliculas[$p2]}" 2>&1 | grep -i "title" | head -n1)
		titulo=$(echo -n "$titulo" | sed "s/subs\|subtitle\|rip_\|subrip\|ripped\|: Nederlands\|\.com\|extended\|scorp\|sc0rp\|dvdrip\|XViDRLD\|Bluray\|mpd\|xvid\|WAF\|\-//Ig" )
		titulo="$nombre ($titulo)"
		echo -e "..............\nPOSTER: $poster\nTITULO: $titulo\n"	  
		echo -e "<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte $titulo </title><script src=\"http://192.168.77.145/dashjs/dist/dash.all.debug.js\"></script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte <span>$titulo</span></h1><div align=center style=\"width:80%;position: relative; top:20%;left:10%;\">\n$poster <video autoplay preload=\"true\" controls=\"true\" style=\"width:85%;\"><source src=\"$raiz/$ig\"></source><source src=\"$raiz/${peliculas[$p]}\"></source></video>\n</div><div style=\"width:60%\" align=center><img src=\"$raiz/${peliculas[$p]}-02.jpg\"></img><img src=\"$raiz/${peliculas[$p]}-03.jpg\"></img></div></body></html>" > "$nombre.html"
	    fi
	    echo -e "${peliculas[$p]} ===== $igual "
	fi
    done
    #read
done
fi
#touch $0
#setsid $0 &
