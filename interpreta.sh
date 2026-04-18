while [ ! -f stdcdr ];do
    cd ..
done
d=$(date +%M%S%N | ./stdcarn 5 | ./stdtohex | ./stddelcar " " )
cadena=$(cat)
identificador=$(echo $cadena |./stdcarsin 0A |./stdfromhex)
address=$(echo $cadena |./stdcdr 0A |./stdcarsin 0A |./stdfromhex)
echo "address=$address"
cmd=$(echo "$address" |base64 --decode |./stdtohex|./stdcar 0A|./stdfromhex)
echo "cmd=$cmd"
echo "cat datas/C1 | $cmd |./stdtohex |./stdcdr 7B|./stdcarsin '7D 0A' |./stdfromhex" > data/f$address.sh
echo $address $identificador
echo $cmd
sh data/f$address.sh > data/$identificador.sh
tx=$(./stdcdr 0A |./stdcdr 0A)
address=$(echo $tx |./stdfromhex|sh data/$identificador.sh)
mkdir bloque
echo "$identificador {" > bloque/$identificador-$d
sh $identificador.sh >>  bloque/$identificador-$d
echo "7D 0A 0A"|./stdfromhex  >>  bloque/$identificador-$d
