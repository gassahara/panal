#PrPWD="/media/norma/gerardo/nube"
#PrPWD="/home/norma/nube.backup"
PrPWD="/Volumes/DATA/nube"
filo="$1"
linmin=200
pasa=1
palabras=$(cat $filo | iconv -t UTF-8 | $PrPWD/stdnoletras)
#echo "$palabras"
vanpalabras=$(echo "$palabras"|$PrPWD/stdbuscaarg " ")
palabro=1;
hasta=0
desde=0
#wiktionario="$PrPWD/wikiborrar/eswiktionary-20200901-pages-articles-multistream.xml";
wiktionario="/Volumes/4T/wikipedia/eswiktionary-20200901-pages-articles-multistream.xml";
cat dataC1cdrn.c | $PrPWD/stdcar "char *filo=\"" > $0.c
echo -n "$wiktionario"  >> $0.c
cat dataC1cdrn.c | $PrPWD/stdcdrcon "\";" >> $0.c
gcc -o $0-c-bin $0.c -O3 -lm
echo "<HTML><HEAD><STYLE>
span {
height: 150px;
font-size: 20pt;
letter-spacing: 3px;
padding: 25px -1px 25px -1px;
font-family: 'serif';
}
div {
font-size: 20pt;
letter-spacing: 3px;
}
img {
width:50px;
}
.grande {
  font-size: 30pt;
  letter-spacing: 5px;
  background-color: lightyellow;
  font-family: 'sans';
}
</STYLE>
<SCRIPT>"
echo "function geta(obj) {
    var attributes = obj.attributes;
    var length = attributes.length;
    var result = \"\";
    for (var i = 0; i < length; i++) {
      if(attributes[i].name==\"data-n\") result=attributes[i].value;
    }
    return result;
  };
  function seta(obj, valor) {
    var attributes = obj.attributes;
    var length = attributes.length;
    for (var i = 0; i < length; i++) {
      if(attributes[i].name==\"data-n\") attributes[i].value=valor;
    }
  };
  function getipo(obj) {
    var attributes = obj.attributes;
    var length = attributes.length;
    var result = \"\";
    for (var i = 0; i < length; i++) {
      if(attributes[i].name==\"data-tipo\") result=attributes[i].value;
    }
    return result;
  };
  function bustipo(tipo) {
    spans=document.getElementsByTagName('span');
    var j=0;
    while (j<spans.length) {
      if(spans[j].id.substring(0, 4)==\"pala\") {
        obj=spans[j];
        var attributes = obj.attributes;
        var length = attributes.length;
        var result = \"\";
        for (var i = 0; i < length; i++) {
           if(attributes[i].name==\"data-tipo\") {
                if(attributes[i].value.indexOf(tipo) > -1) {
                    obj.className=\"grande\";
                }
           }
        }
     }
     j++;
    }
  };
  function resettipo(tipo) {
    spans=document.getElementsByTagName('span');
    var j=0;
    while (j<spans.length) {
      if(spans[j].id.substring(0, 4)==\"pala\") {
        obj=spans[j];
        var attributes = obj.attributes;
        var length = attributes.length;
        var result = \"\";
        for (var i = 0; i < length; i++) {
           if(attributes[i].name==\"data-tipo\") {
                    obj.className=null;
           }
        }
     }
     j++;
    }
  };
  function setipo(obj, valor) {
    var attributes = obj.attributes;
    var length = attributes.length;
    for (var i = 0; i < length; i++) {
      if(attributes[i].name==\"data-tipo\") attributes[i].value=valor;
    }
  };
  function limpia() {
     spans=document.getElementsByTagName('span');
     tables=document.getElementsByTagName('table');
     i=0;
     while(i<tables.length) {
       if(tables[i].id.substring(0, 4) =='boto') tables[i].style.display='none';
       i++;
     }
     i=0;
     while(i<spans.length) {
       if(spans[i].id.substring(0, 4) =='pala') spans[i].style.backgroundColor='';
       i++;
     }
  }
  function limpiad() {
     spans=document.getElementsByTagName('div');
     i=0;
     while(i<spans.length) {
       if(spans[i].id.substring(0, 4) =='defi') spans[i].style.display='none';
       i++;
     }
  }
  function limpiadivstipos() {
     spans=document.getElementsByTagName('div');
     i=0;
     while(i<spans.length) {
       if(spans[i].id.substring(0, 5) =='tipos') spans[i].style.display='none';
       i++;
     }
  }
  function limpiap() {
     parras=document.getElementsByTagName('div');
     i=0;
     while(i<spans.length) {
       if(parras[i].id.substring(0, 4) =='parr') parras[i].style.backgroundColor='';
       i++;
     }
  }
"
echo "</SCRIPT></HEAD><BODY><hr><input type=\"button\" value=\"ARTÍCULOS DETERMINADOS\" onclick=\"resettipo();;bustipo('artículo determinado');\"></input><input type=\"button\" value=\"ARTÍCULOS INDETERMINADOS\" onclick=\"resettipo();;bustipo('artículo indeterminado');\"></input><input type=\"button\" value=\"VERBOS\" onclick=\"resettipo();bustipo('verbo');\"></input><input type=\"button\" value=\"SUSTANTIVOS\" onclick=\"resettipo();bustipo('sustantivo');\"></input><hr><br><br>"
palabri="";
previopunto=0;
vanpuntos=0;
echo -n "<div style=\"display:inline;\" id='parrafo$vanpuntos' onmouseout=\"this.style.backgroundColor='';\">"
while [ -n "$vanpalabras" ];do
    desde=$hasta
    hasta=$(echo "$palabras"|$PrPWD/stdcarsin " ")
    hastaborra=$(echo "$palabras"|$PrPWD/stdcarsin " ")
    hasta=$(expr 0$hasta - $desde )

#    echo "<((( $palabras )))>" 1>&2
#    cat $filo|$PrPWD/stdcdrn $desde|$PrPWD/stdcarn $hasta 1>&2
#    echo "<( $desde $hasta($hastaborra) )>" 1>&2
    
    if [ 0$hasta -gt 0 ];then
	palabrao=$(cat $filo|$PrPWD/stdcdrn $desde|$PrPWD/stdcarn $hasta)
	palabra=$(echo "$palabrao"|tr [:upper:] [:lower:])
	palabrao=$(echo -n "$palabrao"|$PrPWD/stdhtmlentities)
#	echo "($desde-$hasta)"
	prueba=$(echo -n "$palabra"| $PrPWD/stdnoletras)
	if [ -z "$prueba" ];then
	    echo "<$palabra>"  1>&2
	    palabrb=$(echo "$palabri"|$PrPWD/stdbuscaarg ";$palabra;")
	    if [ -z "$palabrb" ];then
		palabri="$palabri;$palabra;$palabro:"
		iniciotitulo=$(cat "$wiktionario" |$PrPWD/stdbuscaarg_donde_hasta "<title>$palabra</t")
		texto="";
		if [ 0$iniciotitulo -gt 0 ];then
		    fintitulo=$($PrPWD/$0-c-bin $iniciotitulo  | $PrPWD/stdbuscaarg_donde_hasta "</page" )

		    dondetraducciones=$($PrPWD/$0-c-bin "0$iniciotitulo" |  $PrPWD/stdcarn "0$fintitulo" | $PrPWD/stdbuscaarg_donde_hasta "== Traducciones")
		    if [ 0$dondetraducciones -gt 0 ];then
			fintitulo=$dondetraducciones
		    fi
		    echo "$iniciotitulo -- $fintitulo" 1>&2
		    texto=$($PrPWD/$0-c-bin $iniciotitulo |  $PrPWD/stdcarn $fintitulo  | grep -v "comment\|," | grep "=" | $PrPWD/stddelcar "{" | $PrPWD/stddelcar "=" | $PrPWD/stddelcar "}" | $PrPWD/stddelcar "  " |tr '|' '\n'|grep "adverbio\|artículo determinado\|artículo indeterminado\|verbo\|pronombre\|sustantivo\|adjetivo\|plural\|singular\|conjunción\|conjunciones\|preposic" | sed "s/|[a-zA-Z]//g; s/.*://g"|sort -u|tr '\n' ',')
		fi
#		texto=$(cat $wiktionario | $PrPWD/stdcdrcon "title>$palabra<" | $PrPWD/stdcarsin "</page" | $PrPWD/stdcarsin "==== Traducciones"  |grep -v "comment\|," | grep "=" | $PrPWD/stddelcar "{" | $PrPWD/stddelcar "=" | $PrPWD/stddelcar "}" | $PrPWD/stddelcar "  " |tr '|' '\n'|grep "adverbio\|artículo determinado\|artículo indeterminado\|verbo\|pronombre\|sustantivo\|adjetivo\|plural\|singular" | sed "s/|[a-zA-Z]//g; s/.*://g"|sort -u|tr '\n' ',')
		echo -n "<span id=\"palabra$palabro\" onmouseover=\"limpia(); document.getElementById('botones$palabro').style.display='inline';this.style.backgroundColor='yellow';\" "
		if [ -n "$texto" ];then
		    echo -n "<<<< $texto" 1>&2
		    echo -n "data-tipo=\"$texto\" "
		    palabri="$palabri$texto:"
		fi
		echo -n ">$palabrao</span><table data-n=\"0\" id=\"botones$palabro\" style=\"display:none;width:120px;position:relative;left:-10px;\" onmouseover=\"seta(this, 1);\" onmouseout=\"if(geta(this)) {this.style.display='none';seta(this,0);\" ><tr><td>"
		echo "$palabra"|$PrPWD/stdletras_muestra_y_signos_ascii|iconv -t ISO-8859-15|/Volumes/DATA/comp/festival/bin/text2wave -eval "(voice_cmu_us_clb_cg) " - | ffmpeg -i - -b:a 12000  $palabra.wav 2>/dev/null 1>/dev/null
		echo -n "<img id=\"defi$palabro\" data-n=\"0\" src=\"data:image/png;base64,"
		base64 definicion.png |tr -d '\n'
		echo -n "\" onclick=\"resettipo();limpiad(); document.getElementById('definicion$palabro').style.display=''; \"/></img></td></tr><tr><td>"
		echo -n "<img id=\"img$palabro\" src=\"data:image/png;base64,"
		base64 speaker.png |tr -d '\n'
		echo -n "\" onclick=\"resettipo();document.getElementById('AUDS0x1').src='data:audio/wav;base64,"
		base64 $palabra.wav|tr -d '\n'
		rm $palabra.wav
		echo -n "';;document.getElementById('AUD0x1').load();document.getElementById('AUD0x1').play();\"/></img>"	    
		echo -n "</table><div id='definicion$palabro' style=\"display:none;z-index:9999;position:fixed;overflow:scroll;left:15%;top:15%;background-color:lightblue;height:70%;width:70%;\"><img src=\"data:image/png;base64,"
		base64 close.png |tr -d '\n'
		echo -n "\" style=\"position:relative; left:90%;\" onclick=\"resettipo();limpiad(); \"/></img><pre>"
		lynx -useragent="Mozilla/4.0" "https://dle.rae.es/$palabra" --dump 2>/dev/null  | tr '\n' '#'  | tr '^' '#' | $PrPWD/stdcdr " Consultar#" | tr '#' '\n' | $PrPWD/stdcarsin " Real Academia" 
		echo -n "</pre></div>"
	    else
		palabrj=$(echo -n "$palabri"|$PrPWD/stdcdr ";$palabra;"|$PrPWD/stdcarsin ":")
		textoj=$(echo -n "$palabri"|$PrPWD/stdcdr ";$palabra;"|$PrPWD/stdcdr ":"|$PrPWD/stdcarsin ":")
		echo "[[ $palabrj $textoj ]]" 1>&2
		echo -n "<span id=\"palabra$palabro\"  data-tipo=\"$textoj\" onmouseover=\"limpia(); document.getElementById('botones$palabro').style.display='inline';this.style.backgroundColor='yellow';\">$palabrao </span><table data-n=\"0\" id=\"botones$palabro\" style=\"display:none;width:120px;position:relative;left:-10px;\" onmouseover=\"seta(this, 1);\" onmouseout=\"if(geta(this)) {this.style.display='none';seta(this,0);\" ><tr><td>"
		echo "$palabra"|$PrPWD/stdletras_muestra_y_signos_ascii|iconv -t ISO-8859-15|/Volumes/DATA/comp/festival/bin/text2wave  -eval "(voice_cmu_us_clb_cg) " - | ffmpeg -i - $palabra.wav 2>/dev/null 1>/dev/null
		echo -n "<img id=\"defi$palabro\" data-n=\"0\" src=\"data:image/png;base64,"
		base64 definicion.png |tr -d '\n'
		echo -n "\" onclick=\"resettipo();document.getElementById('defi$palabrj').click();\"/></img></td></tr><tr><td>"
		echo -n "<img id=\"img$palabro\" src=\"data:image/png;base64,"
		base64 speaker.png |tr -d '\n'
		echo -n "\" onclick=\"resettipo();document.getElementById('img$palabrj').click();\"/></img></td></tr></table>"
	    fi
	else
	    echo -n "$palabrao"|$PrPWD/stdhtmlentities
	fi
    fi
    
    final=$(cat $filo|$PrPWD/stdcdrn $hastaborra|$PrPWD/stdcarn 1|$PrPWD/stdbuscaarg ".")
    if [ -n  "$final" ];then
	echo -n "<span onmouseover=\"document.getElementById('parrafo$vanpuntos').style.backgroundColor='lightgreen';document.getElementById('parrafohablado$vanpuntos').style.display='';\">"
    fi
    
    cat $filo|$PrPWD/stdcdrn $hastaborra|$PrPWD/stdcarn 1 |$PrPWD/stdhtmlentities
    ##########
    echo -n "<<" 1>&2
    cat $filo|$PrPWD/stdcdrn $hastaborra|$PrPWD/stdcarn 1 1>&2
    echo -n ">>" 1>&2
    
    if [ -n  "$final" ];then
	hastapunto=$(echo "$palabras"|$PrPWD/stdcarsin " ")
	hastapunto=$(expr $hastapunto - $previopunto)
	cat $filo | $PrPWD/stdcdrn $previopunto | $PrPWD/stdcarn $hastapunto |$PrPWD/stdletras_muestra_y_signos_ascii| iconv -t ISO-8859-15|/Volumes/DATA/comp/festival/bin/text2wave  -eval "(voice_cmu_us_clb_cg) " - | ffmpeg -i - texto.wav 2>/dev/null 1>/dev/null
	echo -n "<img id=\"parrafohablado$vanpuntos\" src=\"data:image/png;base64,"
	base64 speaker.png |tr -d '\n'
	echo -n "\" onclick=\"resettipo();document.getElementById('AUDS0x1').src='data:audio/wav;base64,"
	base64 texto.wav|tr -d '\n'
	rm texto.wav
	echo -n "';;document.getElementById('AUD0x1').load();document.getElementById('AUD0x1').play();\" style=\"display:none;\"/></img>"

	previopunto=$(echo "$palabras"|$PrPWD/stdcarsin " ")
	previopunto=$(expr 0$previopunto + 1)
	vanpuntos=$(expr 0$vanpuntos + 1)
	echo -n "</span></div><div style=\"display:inline;\" id='parrafo$vanpuntos' onmouseout=\"this.style.backgroundColor='';\">"
    fi
    
    palabras=$(echo -n "$palabras"|$PrPWD/stdcdr " ")
#    echo "<<$palabras>>"
    vanpalabras=$(echo -n "$palabras"|$PrPWD/stdbuscaarg " ")
    palabro=$((palabro+1))
    hasta=$(expr 0$hastaborra + 1)
done

echo "<audio id=\"AUD0x1\"><source id=\"AUDS0x1\" src=\"\" type=\"audio/wav\"></audio> </BODY></HTML>"

