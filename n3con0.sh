cat > $1.yn
cat $1.yn | ./stdhttpcontentsize 2>$1.rer 1>$1.red
__ln=( $( ls -Lon "$1.rer" ) )
rr=${__ln[3]}
#rr=$(wc -c $1.rer | sed "s/\(^ \{1,\}\)//g"  | cut -d " " -f1 )
if [ $rr -gt 0 ];then
    echo "AUN NO $rr"
else
    campo=1
    campof="."
    rec=$(cat "$1.yn" | ./stdhttpcontent)
    while [ -n "$campof" ];do
	campof=$(echo -n "$rec" | cut -d ";" -f$campo | sed "s/^ //g" | cut -d "=" -f1 )
	if [ "$campof" = "boundary" ];then
	    campof=$(echo -n "$rec" | cut -d ";" -f$campo | sed "s/^ //g" | cut -d "=" -f2 | tr -d "\r" )
	    echo "((( $campof"
	    break
	fi
	campo=$((campo+1))
    done
    echo $campof
    campoff=$(echo -e "$campof")
    campof2=$(echo "$campof" | sed "s/-/\\\\\\-/g")
    echo $campoff
    ff1=$(ggrep -boaw --binary-files=text "$campof2" $1.yn | cut -d ":" -f1 | head -n1 | tr -d "\n")
#    dd bs=1 skip=$ff1 if=$1.yn
    echo ... $ff1
#    dd bs=1 skip=$ff1 if=$1.yn | ./stdhttppostseparatefiles "$campoff"
#    echo $lista
fi
