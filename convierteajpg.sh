#!/bin/bash
archivos=()
date2=1
    while read -r -d '';do
	erc=$REPLY
	espelicula=$(./comepeliculas.sh "$erc")
	if [ -n "$espelicula" ];then
	    archivos+=("$erc")
	fi
    done < <(find "$1" -type f -print0)


    for arc in "${archivos[@]}";do

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
	erc=$(./haztitulo.sh "$arc")
	echo "(( $arc | $erc ))"
	ffmpeg -ss 00:05:00 -t 00:10:00 -threads 1 -r 1 -loglevel 1 -i "$arc"  -frames:v 5 -vf "select=gt(scene\\,0.7)" -vsync vfr -vf fps=fps=1/710 "$patho/$erc-%02d.jpg" -n 2>&1
	im=$(find "$patho" -name "$erc-*.jpg" -exec echo ",{};" \;)
	imagenes=$(echo "$im" | sed "s/,/<img src=\"/g; s/\;/\">/g" )

	    echo -e "<html lang=\"es\">\n <head><meta charset=\"utf-8\"/><title>WinanFlix comparte $erc </title><script src=\"$raiz/../dashjs/dist/dash.all.debug.js\"></script><script>function startVideo(mpd){var video, context, player;video = document.querySelector(\".dash-video-player video\");player = dashjs.MediaPlayer().create();player.initialize();player.attachView(video);player.attachVideoContainer(document.getElementById(\"videoContainer\"));player.setAutoPlay(false);player.attachSource(mpd);}</script><style>img {width:20%;height: auto;}; video {width: 80%;height: auto;}</style>\n<body onload=\"startVideo('$raiz/${peliculas[$p2]}');\" style=\"background: #e9e9e9; text-align: center;width:90%\" align=center><h1>WinanFlix comparte $titulo </h1><div class=\"container\"><div class=\"row\"><div class=\"dash-video-player col-md-9\"><input type=button onclick=\"startVideo('$raiz/${peliculas[$p2]}');\"></input><div id=\"videoContainer\"><video autoplay preload=\"true\" controls=\"true\" style=\"width:85%;\"><source src=\"$erc\"></source></video>\n</div><div style=\"width:60%\" align=center>$imagenes</div></div></div></div></body></html>" > "$patho/$erc.html"
	    echo "escribi a: $patho/$erc.html"

	    echo "TERMINO $erc"
    done

