if [ ! -z "$1" ];then
    while read line;do
	echo "" >> $1.log
	sort -ru $1.log > $1.2.log
	line2=$(echo $line | sed "s/\&/\\\\\&/g; s/\[/\\\\\[/g; s/\]/\\\\\]/g; s/\./\\\\\./g; s/\"/\\\\\"/g; s/\//\\\\\//g; ")
	esta=$(grep "$line2" $1.log)
	if [ -z "$esta" ];then
	    echo "$line";
	    echo "$line" >> $1.log
	fi
    done
fi
