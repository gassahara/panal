    __ln=( $( ls -Lon "$1.yn" ) )
    bites=${__ln[3]}
    bitem=0
    echo $bites $bitem
    while [ $bites -gt 0 ];do
	if [ $bitem -le ${#campoff} ];then
	    bitem=0
	else
	    bitem=$((bitem-${#campoff}))
	fi
	if [ $bites -ge 1048576 ];then
	    lista=$(dd count=1048576 skip=$bitem if=$1.yn | ggrep -boaw --binary-files=text "$campoff" | cut -d ":" -f1 | tr "\n" "," | sed "s/,/+$bitem\;\@/g" | tr "@" "\n" | bc | tr "\n" "@")
	else
	     lista=$(ggrep -boaw --binary-files=text "$campoff" $1.yn | cut -d ":" -f1 | tr "\n" "," | sed "s/,/+$bitem\;\@/g" | tr "@" "\n" | bc | tr "\n" "@" )	   
	fi
	bitem=$(($bitem+1048576))
	bites=$(($bites-1048576))
	echo $bites $bitem
	cc=2
	desde=1
	while [ $desde -gt 0 ];do
	    echo $lista desde $desde $ff
	    if [ $desde -gt 1 ];then
		hasta=$(echo $lista | cut -d "@" -f$cc)
		hasta=$((hasta-$desde))
		if [ "0$hasta" -gt "1" ];then
		    echo dd bs=1 count=$hasta skip=$desde if=$1.yn
		    dd bs=1 count=$hasta skip=$desde if=$1.yn
		    echo "%%%%%%%%%%%"
		    dd bs=1 count=$hasta skip=$desde if=$1.yn | ./stdhttppostseparatefiles
		fi
	    fi
	    desde=$(echo $lista | cut -d "@" -f$cc)
	    cc=$((cc+1))
	done
    done
