cat $1.yn | ./stdhttpcontentsize 2>$1.rer 1>$1.red
__ln=( $( ls -Lon "$1.rer" ) )
rr=${__ln[3]}
#rr=$(wc -c $1.rer | sed "s/\(^ \{1,\}\)//g"  | cut -d " " -f1 )
if [ $rr -gt 0 ];then
    rr=${__ln[3]}
    sleep 1
    ./n3con.sh "$1"
else
    campo=1
    campof="."
    echo "<HTML><BODY > <p>Espere un momento ... </p> </body></html>" > $1.html
#onload=\"if(document.getElementsByTagName('a').length<1) window.location.reload();\"> <p>Espere un momento ... </p> </body></html>" > $1.html;

    campof=$(cat "$1.yn" | ./stdhttpcontent | ./stdcdr "boundary=" | ./stdcarsin ";" )
    mkdir posts
    cadena="./stdcdr \"$campof\" "
    i=0
    estaenboundary=$(cat $1.yn | eval $cadena  | ./stdbuscaarg "$campof" )
    while [ -n "$estaenboundary" ];do
	cadena="$cadena | ./stdcdr \"$campof\" "
	cat $1.yn | eval $cadena | ./stdcarsin "$campof" > posts/$1_$i.post
	estaenboundary=$(cat $1.yn | eval $cadena  | ./stdbuscaarg "$campof" )
	i=$((i+1))
    done
    #dd bs=1 skip=$ff1 if=$1.yn | ./stdhttppostseparatefiles_adocumento "$campoff" > $1.html
fi
