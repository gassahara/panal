#!/bin/sh
fn=""
PaPWD="$PWD"
stdcdr="stdcdr"
stdcdrd=""
while [ ! -f "$stdcdrd$stdcdr" ];do
    stdcdrd=$(echo "../$stdcdrd")
done
PrPWD=$stdcdrd
pasa=0
nomprograma=$0
slash=$(echo "$nomprograma"| $PrPWD/stdbuscaarg_donde_hasta "/" )
while [ -n "$slash" ];do
    nomprograma=$(echo "$nomprograma"| $PrPWD/stdcdr "/" )
    slash=$(echo "$nomprograma" | $PrPWD/stdbuscaarg_donde_hasta "/" )
done
#echo "$nomprograma.."
sleep 0.1
$PrPWD/listadodirectorio_files_extension .c|$PrPWD/stdtohex > $nomprograma.lis
busca=".."
echo -n "" > $nomprograma.cha
posicion=0;
dondes=$( cat "$nomprograma.lis" |$PrPWD/stdbuscaarg_donde "0A")
encuentra="ALGO"
while [ -n "$dondes" -a -n "$encuentra" ];do
    listf=$(cat "$nomprograma.lis" | $PrPWD/stdcdrn "0$posicion"|$PrPWD/stdcarsin "0A"|$PrPWD/stdfromhex)
    posicion=$(echo "$dondes" |$PrPWD/stdcarsin " ")
    dondes=$(echo "$dondes" |$PrPWD/stdcdr " ")
    chacha=$(echo "$listf"|$PrPWD/stdtohex |$PrPWD/chacha20)
    encuentra=$(cat $nomprograma.memoria | $PrPWD/stdbuscaarg ";$listf;$chacha;")
done
if [ -z "$encuentra" ];then
    echo ";$listf;$chacha;" >> $nomprograma.memoria
fi
if [ -n "$dondes" ];then
    $0 &
else
    ps1=3
    while [ 0$ps1 -gt 2 ];do
    	ps1=$(ps -Am -o ";%c:" |  $PrPWD/stddelcar " " | $PrPWD/stdbuscaarg_count ";$nomprograma:" )
    	sleep 1
    done
    $0 &
fi
if [ -z "$encuentra" ];then
    fn=$listf
    echo "<< fn $fn >>"
    ttest=$(echo -n "$fn" |$PrPWD/stddelcar " ")
    if [ -n "$ttest" ];then

	slash=$(echo "$fn" | $PrPWD/stdbuscaarg_donde_hasta "/" )
	while [ -n "$slash" ];do
	    fn=$(echo "$fn" | $PrPWD/stdcdr "/" )
	    slash=$(echo $fn | $PrPWD/stdbuscaarg_donde_hasta "/" )
	done
    	echo "0 $busca ($fn)"
	len=$(cat "$fn"|wc -c)
	if [ 0$len -gt 0 ];then
	    mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
	    opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
	    closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
	    balan=$(echo "$opens-$closs"|bc)
	    if [ 0$opens -gt 0 -a "$balan" = "0" -a -n "$mains" ];then
    		ejec="$fn.$nomprograma.bin"
    		gcc -o $ejec $fn
		echo "$ejec"
		echo "__________"
    		r2t=$(echo -n ""|./$ejec |$PrPWD/stdhttp | $PrPWD/stdunescape| $PrPWD/stdhttpgetfilehtmlcomprueba )
		if [ -n "$r2t" ];then
		    cad1=$(echo -n ""|./$ejec |$PrPWD/stdhttp | $PrPWD/stdunescape | $PrPWD/stdhttpgetfilehtml )
		    cad2=$(echo -n ""|./$ejec |$PrPWD/stdhttpcontent)
		    if [ -n "$cad1" -a -n "$cad2" ];then
			echo "POST >$fn<"
			cad1=$(echo -n ""|./$ejec |$PrPWD/stdhttpcontentsize)
			echo "ESPERANDO..."
			while [ -z "$cad1" ];do
			    cad1=$(echo -n ""|./$ejec |$PrPWD/stdhttpcontentsize )
			    sleep 0.01
			done
			echo "COMPLETO"
			msg="<p>Un momento por favor $fn </p>"
			echo "<HTML><BODY>$msg</BODY></HTML>" > $fn.htmly
			cd "$PrPWD"
			PrPWD=$PWD
			cd "$PaPWD"
			dira=$(echo "$PaPWD"|$PrPWD/stdcdr "$PrPWD/")
#			dira=$(echo "$dira/posts")
			salida=$(echo "<HTML><HEAD><BODY ><iframe id='frama' src=''  onload=\"setTimeout(function () { document.getElementById('boto').click();}, 3000); \"></iframe><input id='boto' type='button' onclick=\"if(!document.getElementById('frama').contentDocument) document.getElementById('frama').src='$dira/$fn.html'; if(document.getElementById('frama').contentDocument) { alert(document.getElementById('frama').contentDocument.body.innerHTML); if(!document.getElementById('frama').contentDocument.body.innerHTML || document.getElementById('frama').contentDocument.body.innerHTML == '$msg') { document.getElementById('frama').src='$dira/$fn.html'; }} \"></input></body></html>");

			cuantos=$(echo -n "$salida" | wc -c )
			cabecera2=$(echo -n "HTTP/1.1 200 OK"| $PrPWD/stdtohex)
			cabecera=$(echo -n "$cabecera2 0D 0A ")
			cabecera2=$(echo -n "Content-Length: $cuantos"| $PrPWD/stdtohex)
			cabecera=$(echo -n "$cabecera $cabecera2 0D 0A ")
			cabecera2=$(echo -n "Content-Type: text/html;"| $PrPWD/stdtohex)
			cabecera=$(echo -n "$cabecera $cabecera2 0D 0A 0D 0A ")
			cabecera2=$(echo -n "$salida"| $PrPWD/stdtohex)
			cabecera=$(echo -n "$cabecera $cabecera2")
			echo -n "$cabecera"| $PrPWD/stdfromhex
			echo -n "$cabecera"| $PrPWD/stdfromhex | ./$ejec 1>/dev/null
			campof=$(echo -n ""|./$ejec | $PrPWD/stdhttpcontent | $PrPWD/stdcdr "boundary=" | $PrPWD/stdtohex | $PrPWD/stdcarsin 0A | $PrPWD/stdfromhex )
			echo "\n\n\n<$campof>"
    			mkdir peticiones
    			mv $fn peticiones/
			mkdir posts

			cabecera="#include <string.h>\n#include <stdio.h>\n#include <stdlib.h>\n";
			parastdin="char *buffer;\nbuffer=calloc(512, sizeof(char));\nchar *temporal;\ntemporal=calloc(512, sizeof(char));\nbzero(buffer, 512);\nbzero(temporal, 512);\nchar buff[2];\nint r=1;\nint rr=0;\nint rt=512;\nint offset=0;\nwhile(r>0) {\nr=fread(buff, sizeof(char), 1, stdin);\nif(r<1) break;\nbuffer[rr]=buff[0];\nrr++;\nwhile(rr>rt-1) {\nfree(temporal);\ntemporal=calloc(rr, sizeof(char));\nmemcpy(temporal, buffer, rr);\nfree(buffer);\nbuffer=calloc(rr+512, sizeof(char));\nbzero(buffer, 512);\nmemcpy(buffer, temporal, rr);\nrt=rr+512;\n}\n}\nbuffer[rr]=0;\nif(rr<=1) {\nbuffer[0]='0';\nbuffer[1]=0;}";
			
			filen=$(dd if=/dev/urandom bs=1 skip=10 count=4|$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			while [ -f "posts/$filen.in" ];do
			    filen=$(dd if=/dev/urandom bs=1 skip=10 count 4|$PrPWD/stdtohex|$PrPWD/stddelcar " ")
			done
			echo -n ""|./$ejec > posts/$filen.in
			singuion=0
			completo="$cabecera int main( int argc, char *argv[] ) {\n $parastdin \nFILE *f1=fopen(\"../$fn.html\", \"w+\");\nif(rr>1) fwrite(buffer, 1,rr,f1);\nfclose(f1);\nFILE *f2=fopen(\"$filen.in\", \"r\");\nwhile(fread(buffer,1,1,f2)) {\nprintf(\"%c\",buffer[0]);\n}\nfclose(f2);\n}"
			guione=$(echo -e "$cabecera"|$PrPWD/stdbuscaarg "-e")
			if [ -n "$guione" ];then
			    echo "$completo" > posts/$filen.c
			else
			    echo -e "$completo" > posts/$filen.c
			fi
			
    			echo "%%%%%%%%%"
		    fi
		fi
	    fi
	fi
    fi
fi
