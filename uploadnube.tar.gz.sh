curl --anyauth --insecure -T "nube.tar.gz" sftp://winankro:16913674@200.82.186.3:/home/winankro/uploadnube.tar.gz -vvvv 1>>uploadnube.tar.gz-0.log 2>&1 
 fino=$(cat uploadnube.tar.gz-0.log | grep -c "fine\|successfully transferred"); 
 if [ "$fino" -gt "0" ]; then
 echo "pedazo 0-0 listo";
 rm -v "uploadnube.tar.gz-0.ddpart" 
 rm -v "uploadnube.tar.gz-0.ddpart.sh" 
 fi
  
