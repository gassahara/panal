dir=""
nf=$(echo $0 | wc -c)
nd=$((nf-1))
while [ "$nd" -gt "1" ];do
    fn=$0
    if [ "$(echo $0 | dd bs=1 count=1 skip=$nd 2>/dev/null)" == "/" ];then
	ng=$nd;
	fn=$(echo $0 | dd bs=1 count=$ng  2>/dev/null)
    fi
    nd=$((nd-1))
done
patho=$fn

for e in "$@";do
    esodoc=$($patho/esodoc.sh "$e")
    if [ ! -z "$esodoc" ];then
	archivo="$e"
    fi
    if [ -d "$e" ];then
	dir="$e"
    fi
done
if [ "$#" -lt "3" ];then
    echo -e "POR FAVOR INTRODUZCA TRES ARGUMENTOS\n"
    exit 1
fi

if [ -z "$archivo" ];then
    echo -e "DEBE INTRODUCIR UN ARCHIVO A CONVERTIR\n"
    exit 1
fi

if [ ! -e "$archivo" ];then
    echo -e "???\n"
    exit 1
fi

if [ -z "$dir" ];then
    echo -e "DEBE CREAR U DIRECTORIO PARA ALMACENAR LOS RESULTADOS\n"
    exit 1
fi

for e in "$@";do
    sigue=0
    if [ "$e" == "archivo" ];then
	sigue=1
    fi
    if [ "$e" == "$dir" ];then
	sigue=1
    fi
    if [ "$sigue" != "1" ];then
	sarchivo="$e"
    fi
done

cp "$archivo" "$archivo.zip"
unzip -o "$archivo.zip" -d "$dir";
sleep 3
rm -v "$archivo.zip"
rels=""
cd "$dir"
if [ -e "content.xml" ];then
    erchivo="content.xml";
fi

if [ -e "word/document.xml" ];then
    erchivo="word/document.xml";
    rels="word/_rels";
fi

echo -e "<HTML><meta charset=\"utf-8\">\n" > "$sarchivo"
cat "$erchivo" |  sed "s/<?xml/<div style = \"width: 90%; height: 90%; \"/g; s/text\:body/body/g; s/w\:body/body/g; s/<w\:p /<p /g; s/text\:p /p /g; s/text\:section/div /g; s/w\:p>/p><\/div><\/b><\/i>/g; s/text\:p>/p>/g; " |  sed "s/<text\:span/<span /g" |  sed "s/text\:span>/span>/g" |  sed "s/w\:b w\:val\=\"0\"/<\/b>/g" |  sed "s/<pPr/<br/g" | sed "s/<pStyle /<p style /g" |  sed "s/<\/pStyle/<\/b><\/i><\/p/g" |  sed "s/<w\:i w\:val\=\"1\"/<i/g" |  sed "s/<w\:b[ \/]/<\/b><b /g" |  sed "s/<w\:i w\:val\=\"0\"/<\/i/g" |  sed "s/<w\:i[ \/]/<\/i><i /g" |  sed "s/text:style-name/class/g" |  sed "s/<w\:jc /<\/div><div /g" | sed "s/w\:val=\"center\"/align = \"center\"/g" |  sed "s/<w\:rPr/<\/b><\/i><span /g" | sed "s/<\/w\:rPr/<\/span/g" | sed "s/<>//g" |  sed "s/\<\/\>//g" | sed "s/<jc /<div /g" | sed "s/<sz w:val=/<span style=\"font-size: /g"   |  sed "s/<w\:t\b[^>]*>/<span>/g"  |  sed "s/<\/w\:t\b[^>]*>/<\/span>/g" | sed "s/<\/w\:r\b[^>]*>/ /g"  | sed "s/<w\:r\b[^>]*>/ /g; s/<w\:tbl/<table/g; s/<w\:tr/<tr/g; s/<w\:tc/<td/g; s/<\/w\:tbl/<\/table/g; s/<\/w\:tr/<\/tr/g; s/<\/w:tc/<\/td/g; s/<table\:table /<table /g; s/<table\:table-row /<tr /g; s/<table\:table-cell /<td /g; s/<\/table\:table/<\/table/g; s/<\/table\:table-row/<\/tr/g; s/<\/table\:table-cell/<\/td/g; s/<draw\:frame/<div/g; s/<\/draw\:frame/<\/div/g; s/<draw\:image\b[^xlink\:href]*xlink\:href/<img src/g; " >> "$sarchivo"

if [ "${#rels}" -gt "0" ];then
    while read idd;do
	id=$(echo $idd | grep -o " Id=\"\b[^\"]*\"" | cut -d "\"" -f2)
	image=$(echo $idd | grep -o " Target=\"[^\"]*\"" | cut -d "\"" -f2)
	image=$(find . -path "*$image*")
	echo $image--
	image=$(echo $image | sed "s/\./\\\\\./g; s/\"/\\\\\"/g; s/\//\\\\\//g; ")
	cat $sarchivo | sed "s/\"$id\"/\><img src=\"\.\/$image\"></g" > $sarchivo.html.temp
	mv $sarchivo.html.temp $sarchivo
    done< <(cat $rels/* | tr [\<\>] "\n" | grep -i image)
fi
