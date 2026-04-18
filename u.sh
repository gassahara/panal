VP9_DASH_PARAMS="-tile-columns 4 -frame-parallel 1"

ffmpeg -threads 1 -i $1  -c:v libvpx-vp9 -b:v 1500k -keyint_min 24 -g 25 ${VP9_DASH_PARAMS} -an -f webm -dash 1  peliculas/v.webm
ffmpeg -threads 1 -i $1  -strict -2 -c:a vorbis -b:a 128k -vn -f webm -dash 1  peliculas/va.webm
ffmpeg  -f webm_dash_manifest -i peliculas/v.webm -f webm_dash_manifest -i peliculas/va.webm  -c copy -map 0 -map 1  -f webm_dash_manifest -adaptation_sets "id=0,streams=0 id=1,streams=1"  peliculas/v.mpd
