#!/bin/bash
# <!--
c=1
d=""
e=""
puerto=5000
while [ -z "$e" ];do
    echo $puerto #-->
    echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\">\n <BODY>\n <FORM ACTION=\"http://127.0.0.1:$puerto\">\n NECESIDAD<input name=\"A1\"></input>\"\n </FORM>\n </BODY>\n</HTML>"
#<!--    
    e=$(echo -e "$HTML1" | nc -l -p $puerto -C -q 1 -vvvvv)
    if [ -n "$e" ];then
	echo $e
    else
	puerto=$((puerto+1))
	if [ $puerto -gt 6000 ];then
	    puerto=5000
	fi
    fi
done
necesidad=$(echo "                                LISTO" | nc -l -p $puerto -vvvv)
echo $necesidad
nc -l $puerto | echo $necesidad
#-->
