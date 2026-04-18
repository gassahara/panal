#!/bin/bash
center=0   # Start position of the center of the first image.
images=()
while read -r -d '';do
    images+=("$REPLY")
done < <(find /var/www/html/nube/peliculas -iname "*.jpg" -print0)

IF=""
for imag in "${images[@]}";do
    convert -size 1600x1600 "$image" -thumbnail 320x320 -set caption '%t' -bordercolor Lavender -background black -pointsize 12  -density 96x96  +polaroid  -resize 30%  -gravity center -background None -extent 100x100 -trim -repage +${center}+0\! MIFF:-
done |
    # read pipeline of positioned images, and merge together
    convert -background skyblue   MIFF:-  -layers merge +repage \
            -bordercolor skyblue -border 3x3   peliculas/overlapped_polaroids.jpg
