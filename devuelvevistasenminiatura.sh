archivo="$1"
while read arch;do
      dev=$(./buscatodos.sh "$arch" "ffmpeg " "Input #" "$archivo" "Output #" "image")
      if [ ! -z "$dev" ];then
	  dev=$(./buscatodosenunalinea.sh "$arch" "Input #" "$archivo")
	  if [ ! -z "$dev" ];then
	      dev=$(./buscatodosenunalinea.sh "$arch" "Output #" "$archivo" "image")
	      echo "|$dev|"
	      echo "\n ./buscatodosenunalinea.sh \"$arch\" \"Output #\" \"$archivo\" \"image\" \n"
	      lista="";
	      if [ ! -z "$dev" ];then
		  dev2=$(echo "$dev" | tr " " "\n" | tail -n1 | cut -d "'" -f2 | sed "s/\%[0-9]*d/\&/g" | tr "&" "\*" | sed "s/ /\\\ /g")
		  lista="<ul>\n"
		  while read ll;do
		      lista="$lista<li><img src=\"$ll\"></li>\n"
		  done< <(find . -path "./$dev2" | sort -u)
		  lista="$lista</ul>"
	      fi
	  fi
      fi
done< <(find -iname "*log" )
if [ ! -z "$lista" ];then
    echo -e "$lista"
fi
