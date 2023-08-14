#!/bin/bash
archivos=()
if [ -z $1 ];then
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find peliculas/ -type f -newer $0 -print0)
else
while read -r -d '';do
    archivos+=("$REPLY")
done < <(find peliculas/ -type f -print0)
fi

peliculas=()
IFS=""
p2=1
for arc in "${archivos[@]}";do
    espelicula=$(./comepeliculas.sh "$arc")
    if [ -n "$espelicula" ]; then
	#echo %% $espelicula %%%%%
	peliculas[$p2]="$arc"
	echo "-- ${peliculas[$p2]}"
	if [ -n "${peliculas[$p2]}" ];then
	    if [ -z $2 ];then
		nombre=$(echo "${peliculas[$p2]}") # | sed "s/\.webm\|\.mp4//g")
		titulo=$(ffmpeg -i "${peliculas[$p]}" 2>&1 | grep -i "title")
		if [ -z "$titulo" ];then
		    titulo="$nombre"
		fi
		echo -e "<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte $titulo </title><script src=\"http://192.168.77.145/dashjs/dist/dash.all.debug.js\"></script><script>function startVideo(mpd){var video, context, player;video = document.querySelector(\".dash-video-player video\");player = dashjs.MediaPlayer().create();player.initialize();player.attachView(video);player.attachVideoContainer(document.getElementById(\"videoContainer\"));player.setAutoPlay(false);player.attachSource(mpd);}</script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte </h1><div class=\"container\"><div class=\"row\"><div class=\"dash-video-player col-md-9\"><input type=button onclick=\"startVideo('http://192.168.77.145/nube/peliculas/v.mpd');\"></input><div id=\"videoContainer\"><video autoplay preload=\"true\" controls=\"true\" style=\"width:85%;\"><source src=\"../${peliculas[$p2]}\"></source></video>\n</div><div style=\"width:60%\" align=center><img src=\"../${peliculas[$p2]}-01.jpg\"></img><img src=\"../${peliculas[$p2]}-02.jpg\"></img><img src=\"../${peliculas[$p2]}-03.jpg\"></img><img src=\"../${peliculas[$p2]}-04.jpg\"></img><img src=\"../${peliculas[$p2]}-05.jpg\"></img></div></div></div></div></body></html>" > "$nombre.html"
		ffmpeg -ss 1 -threads 12 -loglevel 1 -i "$arc" -frames:v 5 -vf "select=gt(scene\\,0.6)" -vsync vfr -vf fps=fps=1/560 "${peliculas[$p2]}-%02d.jpg" -y 2>&1
	    fi
	    p2=$((p2+1))
	fi
    fi
done
p=1
for p in "${!peliculas[@]}";do
    p2=1
    menor=99999999
    igual=()
    IFS=\n
    while [ $p2 -lt "${#peliculas[@]}" ];do
	if [ ! $p2 -eq $p ];then
	    echo -e "%%%%%%%%%%%%%%%%%%\n${peliculas[$p]}"
	    if [ -n $(ffmpeg -i "${peliculas[$p]}" 2>&1 | grep Durat | grep -o "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\." | sed "s/[:\.]//g") ];then
		if [ -n $(ffmpeg -i "${peliculas[$p2]}" 2>&1 | grep Durat | grep -o "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\." | sed "s/[:\.]//g") ];then
		    if [ $(ffmpeg -i "${peliculas[$p]}" 2>&1 | grep Durat | grep -o "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\." | sed "s/[:\.]//g") -eq $(ffmpeg -i "${peliculas[$p2]}" 2>&1 | grep Durat | grep -o "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\." | sed "s/[:\.]//g") ];then
			p3=1
			while [ $p3 -lt 5 ];do
			    if [ -f "${peliculas[$p]}-0$p3.jpg" ];then
				if [ -f "${peliculas[$p2]}-0$p3.jpg" ];then
				    menos=$(compare-im6 -metric mae "${peliculas[$p]}-0$p3.jpg"  "${peliculas[$p2]}-0$p3.jpg" -compose src  -alpha opaque -fuzz 20 -similarity-threshold 20% c.jpg 2>&1 \; | grep -o "(\b[^)]*" | sed "s/(//g; s/[0]\.//g; s/\-*//g; " )
				    echo ${peliculas[$p2]} M: $menos
				    if [ $menos -lt 399015 ];then
					igual+=("${peliculas[$p2]}")
					menor=$menos
				    #else
					#igual=""
				    fi
				fi
			    fi
			    p3=$((p3+1))
			done
		    fi
		fi
	    fi
	fi
	p2=$((p2+1))
    done

    echo -e "${peliculas[$p]} != $igual por $menor "
    for ig in "${igual[@]}";do
	rm -v  "${peliculas[$p]}.html"
	if [ -n "$ig" ]; then
	    echo -e "-------- $ig \n"
	    igual2=$(echo ${peliculas[$p]} | sed "s/\//\\\\\//g" )
	    igual3=$(echo $ig | sed "s/\//\\\\\//g" )
	    echo -e "${peliculas[$p]}  = $ig "
	    nombre=$(echo "${peliculas[$p]}" | sed "s/\.webm\|\.mp4//g" )
	    rm -v "$ig.html"
	    if [ -f "$nombre.html" ];then
		cat "$nombre.html" | sed "s/<\/video/<source src=\"\.\.\/$igual3\"><\/source><\/video/g"
		esta=$(grep "<source src=\"\.\.\/$igual2\"" $nombre.html)
		if [ -z "$esta" ];then
		    escribe=$(cat "$nombre.html" | sed "s/<\/video/<source src=\"\.\.\/$igual2\"><\/source><\/video/g" )
		    echo $escribe > "$nombre.html"
		fi
	    else
		echo -e "<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte $titulo </title><script src=\"../../dashjs/dist/dash.all.debug.js\"></script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte </h1><div align=center style=\"width:80%;position: relative; top:20%;left:10%;\">\n<video autoplay preload=\"true\" controls=\"true\" style=\"width:85%;\"><source src=\"../$ig\"></source><source src=\"../${peliculas[$p]}\"></source></video>\n</div><div style=\"width:60%\" align=center><img src=\"../${peliculas[$p]}-02.jpg\"></img><img src=\"../${peliculas[$p]}-03.jpg\"></img></div></body></html>" > "$nombre.html"
	    fi
	    echo -e "${peliculas[$p]} ===== $igual "
	fi
    done
    #read
done
touch $0
#setsid $0 &
