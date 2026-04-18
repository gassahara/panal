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
	if [ "$d" -eq "5" ]
	then
	    medida=$campo
	    echo "la medidad del archivo es $campo en $i $d";
	fi
    fi
    #echo $i $esp -----------
    i=$(($i+1));
done;
offset=0;
offset2=0;
mega=1048576;
echo -e "medida=$medida\nmega=$mega"
rm -vf $1.sh;
if [ -s  $nombre.sh ]
then
    echo "QUEDO POR SUBIR"
else
    echo "" > $nombre.sh
    while [ "$medida" -gt "$mega" ]
    do
	echo $medida-$offset-$offset2
	offset2=$((offset2+1048576));
	#fecha=$(date +%d_%m_%Y_%H%M);
	nombre="upload$1";
	echo -e "variable=\$(curl --anyauth --insecure -T \"$1\" scp://user:123456@127.0.0.1/var/www/html/$1 -r $offset-$offset2 -vvvv 2>&1 ); \n fino=\$(echo \$variable | grep -c \"fine\"); cero=0; if [ \"\$fino\" -gt \"\$cero\" ]; then\n echo \"pedazo $offset-$offset2 listo\";\nfi; ff=\$(find . -name $nombre-*); if [ \"\$(#ff)\" -lt \"1\" ]; then \n rm $nombre.sh\n fi\n if [ \"\$fino\" -gt \"$cero\" ]; then \n rm $nombre-$offset.sh \n fi\n  " >> $nombre-$offset.sh
	echo "$nombre-$offset.sh & \n" >> $nombre.sh;
	offset=$offset2;
	medida=$((medida-$mega));
    done
fi
#bash $nombre.sh
