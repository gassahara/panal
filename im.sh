#!/bin/bash
center=0   # Start position of the center of the first image.
images=()
while read -r -d '';do
    images+=("$REPLY")
done < <(find peliculas -iname "*.jpg" -print0)
rm -v peliculas/overlapped_polaroids.jpg
rm -v peliculas/overlapped_polaroids-a.jpg
IF=""
row=0
for imag in "${images[@]}";do
    if [ -f "$imag" ];then
    convert -size  720x548 "$imag"  -thumbnail 530x370 -bordercolor red -background black -pointsize 36 -density 122x122 -resize 33%  -gravity center -background None -trim -repage -${center}+$row \ \! MIFF:-
    center=$((center+180))
    if [ $center -gt 1550 ];then
	row=$((row+110))
	center=0
    fi
    fi
done |
    convert -background black   MIFF:- -layers merge +repage  -bordercolor skyblue -border 3x3  -distort Perspective '0,0,0,0   0,2000,0,2000 2000,0,2300,-600 2000,2000,2300,2950' peliculas/overlapped_polaroids-a.jpg

convert peliculas/overlapped_polaroids-a.jpg -alpha Set mask5.png ( -clone 0,1 -alpha Opaque -compose Hardlight -composite \) -delete 0 -compose In -composite  peliculas/overlapped_polaroids.jpg
