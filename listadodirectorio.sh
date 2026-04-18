#!/bin/bash
if [ -z "$1" ];then
    nn="./"
else
    nn="$1"
fi
n=$(./listadodirectorio $nn | tr "\n" "*")
      echo $n | tr "*" "\n" | ./stdlistadodirectorio_files
while [ -n "$n" ];do
      nn=$(echo $n | tr "*" "\n" | ./stdlistadodirectorio | tr "\n" "*");
      n=$(echo $nn)
      echo $n | tr "*" "\n" | ./stdlistadodirectorio_files
done