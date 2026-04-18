#!/bin/bash
dosbytes=$(dd if="$1" bs=1 count=2 2>/dev/null)
archivo=""
if [ "$dosbytes" == "PK" ];then
    archivo="$1"
fi
if [ ! -z "$archivo" ];then
    listado=$(unzip -l "$archivo" | grep "content\.xml\|word\/document.xml" -c)
   if [ "0$listado" -gt "0" ];then
       echo "$archivo"
   fi
fi
   
