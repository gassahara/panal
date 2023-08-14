#!/bin/bash
archivo="$1"
if [ -f "$archivo" ];then
    case "$archivo" in
	*png|*jpg|*jpeg|*bmp)
	    while read logfile;do
		thumbs=$(./buscatodos.sh "$logfile" "Input #" "Output #" "ffmpeg " "image2")
		if [ -n "$thumbs" ]
		then
		    thumbs=$(./buscatodosenunalinea.sh "$logfile"  "Output #" "image2")
		    if [ -n "$thumbs" ]
		    then
			thumbs=$(echo "$thumbs" | tr " " "\n" | tail -n1 | cut -d "'" -f2 | sed " s/\-/\\\\\-/g; s/%[0-9]*d/\[0\-9\]\*/g; s/\./\\\\\./g;")
			thumbs=$(echo $archivo | grep "$thumbs")
			if [ ! -z "$thumbs" ];then
			    thumbs=$(grep "Input #" "$logfile" | tr " " "\n" | tail -n1 | cut -d "'" -f2)
			    echo $thumbs
			    break;
			fi
		    fi
		fi
	    done< <(find ./ -iname "*log")
	    ;;
    esac
fi
