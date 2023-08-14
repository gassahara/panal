<?php
if ($_POST["texto2"]) {
    if(!$_POST["nombre"]) {
    $fn="";
    while(strlen($fn)<128){
      $cadn=rand(0, 255);
      if($cadn<16) {
        $fn = $fn . "0" . dechex($cadn);
      } else {
        $fn = $fn . dechex($cadn);
      }
    }
    } else fn=$_POST["nombre"];
    $filename = "msgs/" . $fn;
    if (file_exists($filename)) {
        echo "YA EXISTE ESE NOMBRE";
    } else {
    $fp = fopen($filename . "jpg", 'w');
    fwrite($fp, urldecode(base64_decode($_POST["texto2"])));
    fclose($fp);
    $fp = fopen($filename . "txt", 'w');
    fwrite($fp, $_POST["texto"]);
    fclose($fp);
    $fp = fopen("lista.txt", 'a');
    fwrite("$filename\n");
    fclose($fp);
    echo "$filename"."\n";
    }
}
?>
