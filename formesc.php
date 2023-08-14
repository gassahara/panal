<?php
if ($_POST["texto2"]) {
    $fn="";
    while(strlen($fn)<128){
      $cadn=rand(0, 255);
      if($cadn<16) {
        $fn = $fn . "0" . dechex($cadn);
      } else {
        $fn = $fn . dechex($cadn);
      }
    }
    $filename = "msgs/" . $fn . ".js";
    while (file_exists($filename)) {
        $filename = "msgs/" . $fn . ".js";
    }
    $fp = fopen($filename, 'w');
    fwrite($fp, $_POST["texto2"]);
    fclose($fp);
    echo $filename;
}
?>