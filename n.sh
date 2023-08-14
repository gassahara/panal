#!/bin/bash
rm n.txt
while read -r ;do
    echo $REPLY | sed -n "/GET/" >> n.txt
    b="${#REPLY}"
    if [ $b -lt 2 ];then
	echo $b | hexdump -c 1>&2
	break
    fi    
done
ss=$(stat -c "%s" n.txt)

echo -e "HTTP/1.1 200 OK\nContent-Length: $ss\nContent-Type: text/html; charset=ISO-8859-1\n"
cat n.txt
echo -e "\r\n"
