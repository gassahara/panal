<?php
$target_file = basename($_FILES["fileToUpload"]["name"]);
$namo = $_POST["namo"];
$file_tmp = $_FILES['fileToUpload']['tmp_name'];
print_r($_POST);
if(isset($_POST["submit"])) {
    if(isset($_POST["namo"])) {
      echo "./".$namo;
      move_uploaded_file($file_tmp,$namo);
      echo "Upload OK";
    } else {
      echo "Faltan Campos";
    }
} else {
  echo "Faltan Campos";
}
?>
