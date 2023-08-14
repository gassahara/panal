archivo="$1"
dev=$(./visorpelicula.sh "$archivo")
if ! [ -z "$dev" ];then
    desdel=$(grep -boi "<source src" "$archivo" | sed "s/[[:space:]]\{2,\}/ /g" | head -n1 | cut -d ":" -f1)
    buscan=$(dd if="$archivo" bs=1 skip=$desdel 2>/dev/null )
    #echo $buscan
    x=${buscan%%<source src*}
    a="<source src"
    buscan=$(echo $buscan | dd bs=1 skip=$((${#x}+${#a})) 2>/dev/null)
    #echo $buscan
    #echo $0

    x=${buscan%%>*}
    #echo $x
    buscan=$(echo "$buscan" | cut -d '"' -f2)

nf=$(echo $buscan | wc -c)
nd=$((nf-1))
while [ "$nd" -gt "1" ];do
    fn=$0
    if [ "$(echo $buscan | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
	ng=$((nd+1));
	fn=$(echo $buscan | dd bs=1 count=$ng  2>/dev/null)
	nd=0;
    fi
    nd=$((nd-1))
done
patho=$(echo $fn | sed "s/\//\\\\\//g")
patho=$(echo $buscan | sed "s/$patho//g")
echo $patho
#echo $buscan

while read arch;do
	grep -i "input" "$arch" | cut -d "'" -f2
	break;
done < <(find ./ -iname "*.log" -exec ./stdbuscatodos.sh "{}" "$patho" "input" \;)
    
#    hastal=$(grep -noi "</title" $archivo | sed "s/[[:space:]]\{2,\}/ /g" | cut -d ":" -f1)
#    buscan=$(head -n$hastal $archivo)
#    x=${buscan%%</title*}
#    echo $x
#    hastal=$(grep -boi "</title" $archivo | sed "s/[[:space:]]\{2,\}/ /g" | cut -d ":" -f1)
#    hasta=$((hastal+${#x}))

#    echo $desde $hasta

#    hasta=$((hasta-$desde))
#    echo $hasta
#    erchivo=$(dd if=$archivo bs=1 skip=$desde count=$hasta 2>/dev/null ) # | tr " " "\n" | tail -n1)
#    echo $erchivo;
fi
