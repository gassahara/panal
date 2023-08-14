cadena=$(ls -l "$1"); # el $ ejecuta la cadena entre parentesis y devuelve la salida de la ejecucion
i=1;
esp=$(echo "$cadena" | tr " " "\n" | wc -l);
echo $esp;
d=0;
medida=0
while [ "$i" -lt "$esp" ]   # los nuemros deben protegerse con comillas -lt (menor que) -gt (mayor que) -eq (igual a) == (cadena igual)
do
    campo=$(echo "$cadena" | cut  -d " " -f$i);
    if [ ${#campo} -gt "0" ]   #${#cadena} devuelve la longitud de cadena 
    then
	d=$((d+1)); #sintaxis para sumar 
	if [ "$d" -eq "5" ];then
	    medida=$campo;
	    echo "la medidad es $campo en $i $d";
	fi;
    fi;
    #echo $i $esp -----------
    i=$(($i+1));
done;
offset=0; offset2=0; mega=1048576;
echo -e "medida=$medida\nmega=$mega"
while [ "$medida" -gt "$mega" ]
do
    echo $medida-$offset-$offset2;
    offset2=$((offset2+1048576));
    curl -T -insecure "$1" scp://user:123456@127.0.0.1/var/www/html/$1 -r $offset-$offset2 -vvvv &
    offset=$offset2;   medida=$((medida-$mega));
done
