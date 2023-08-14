echo "NOMBRE"
read nombre
gpg --no-default-keyring --keyring keys/$nombre --quick-generate-key $nombre rsa4096 Sign
gpg --no-default-keyring --keyring keys/$nombre --export -a > keys/$nombre.pub
hexa=$(cat keys/$nombre.pub | ./stdtohex)
echo "echo '$hexa' | ./stdfromhex | ./stddelcar ' ' " > keys/t$nombre.pub
