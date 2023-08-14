echo "[[[[ $1 ]]]]"
ll=$(cat $1.in | ./stdbuscaarg  $'\r\n\r\n' )
echo "[$ll]"
if [ -n "$ll" ];then
    cp -v $1.in $1.yn
    cat "$1.yn" | ./stdhttp > "$1.req" 
fi
rm $1.yn
