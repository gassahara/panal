#!/bin/sh

# Store the current working directory
PaPWD=`pwd`

# Initialize variables for finding stdcdr
stdcdr="stdcdr"
stdcdrd=""

# Find the stdcdr program in parent directories
while [ ! -f "$stdcdrd$stdcdr" ]; do
    stdcdrd="../$stdcdrd"
    # Prevent infinite loop by checking if we've reached the root directory
    case "$stdcdrd" in
        ../../../../../../../../../../../../../)
            echo "Error: stdcdr not found in parent directories"
            exit 1
            ;;
    esac
done
PrPWD=$stdcdrd

# Extract the program name from the full path
nomprograma=`basename "$0"`

# Change to the directory where stdcdr was found
cd "$PrPWD" || exit 1
PrPWD=`pwd`
cd "$PaPWD" || exit 1

# Get a list of .c files in the current directory
lista0=`$PrPWD/listadodirectorio_files_extension .c`
PbPWD=`echo "$PaPWD" | $PrPWD/stdcdr "$PrPWD"`

# Initialize variables for processing the file list
posicion=0
dondes=`echo "$lista0" | $PrPWD/stdbuscaarg_donde '
'`
encuentra="ALGO"

# Process each .c file
while [ -n "$dondes" ] && [ -n "$encuentra" ]; do
    listf=`echo "$lista0" | $PrPWD/stdcdrn "$posicion" | $PrPWD/stdcarsin '
'`
    posicion=`echo "$dondes" | $PrPWD/stdcarsin " "`
    posicion=`expr $posicion + 1`
    dondes=`echo "$dondes" | $PrPWD/stdcdr " "`
    [ -z "$listf" ] && continue
    
    # Generate a checksum for the file
    chacha=`cat "$listf" | $PrPWD/chacha20`
    encuentra=`$PrPWD/stdbuscaarg ";$listf;$chacha;" "$nomprograma.memoria"`
done

# Exit if the filename is empty
if [ -z "$listf" ]; then
   sleep 60
   $0 &
   exit 0
fi
   
# If the file is not in memory, add it
[ -z "$encuentra" ] && echo ";$listf;$chacha;" >> "$nomprograma.memoria"

# Implement a simple locking mechanism
ps1=1
while [ -f "$nomprograma.lock-$ps1" ]; do
    if [ $ps1 -lt 2 ]; then
        ps1=`expr $ps1 + 1`
    else
        ps1=1
        sleep 1
    fi
done

# Start a new instance of the script
$0 &

# Exit if the file has already been processed
[ -z "$encuentra" ] || exit 0

# Set the filename and remove leading/trailing spaces
fn=$listf
fn=`echo "$fn" | $PrPWD/stddelcar " "`

# Extract the base filename
fn=`basename "$fn"`

# Get the file size
len=`wc -c < "$fn" | $PrPWD/stddelcar " "`
[ $len -eq 0 ] && exit 0

# Check if the file contains a main function with balanced braces
mains=$(cat "$fn"|$PrPWD/stdbuscaarg " main")
opens=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "{")
closs=$(cat "$fn"|$PrPWD/stdcdr " main"|$PrPWD/stdbuscaarg_count "}")
[ $opens -eq 0 ] || [ $opens -ne $closs ] || [ $mains -eq 0 ] && exit 0

# Compile the file and exit if there are errors
errores=`gcc "$fn" 2>&1`
[ -n "$errores" ] && exit 0

# Extract variable declarations from the file
variables=`cat "$fn" | $PrPWD/stddeclaracionesdevariable | tr -d '\n'`
userfromfile=`echo "$variables" | $PrPWD/stdcdr ";char *" | $PrPWD/stdcarsin "="`

# Extract IV and encrypted data variable names
ivfromfile=""
encryptedfromfile=""
echo "$variables" | tr ';' '\n' | while read line; do
    if $PrPWD/stdbuscaarg "int " "$line" > /dev/null && $PrPWD/stdbuscaarg "[16]" "$line" > /dev/null; then
        ivfromfile=`echo "$line" | $PrPWD/stdcdr "int " | $PrPWD/stdcarsin "["`
    elif $PrPWD/stdbuscaarg "int " "$line" > /dev/null && $PrPWD/stdbuscaarg "][" "$line" > /dev/null; then
        encryptedfromfile=`echo "$line" | $PrPWD/stdcdr "int " | $PrPWD/stdcarsin "["`
    fi
done

# Extract file descriptor variable name
filedfromfile=`echo "$variables" | $PrPWD/stdcdr ";FILE *" | $PrPWD/stdcarsin "="`

# Exit if any required variable is missing
[ -z "$userfromfile" ] || [ -z "$ivfromfile" ] || [ -z "$encryptedfromfile" ] || [ -z "$filedfromfile" ] && exit 0

# Extract filename from the code
filed=`$PrPWD/stdbuscaarg "$filedfromfile = fopen(" "$fn" | $PrPWD/stdcdr "fopen(" | $PrPWD/stdcarsin ","`
filed=`echo "$filed" | $PrPWD/stddelcar '"'`

# Extract username from the code
usuarioo=`$PrPWD/stdbuscaarg "$userfromfile =" "$fn" | $PrPWD/stdcdr "=" | $PrPWD/stddelcar '"' | $PrPWD/stdcarsin '"'`

# Check if user file exists, if not, write error and exit
if [ ! -f "$PrPWD/users/$usuarioo/$usuarioo-aes.c" ]; then
    mkdir -p "$PrPWD/users/output/unencrypted"
    echo "errores=\"Error de usuario de nombre de usuario o contraseña\";" > "$PrPWD/users/output/unencrypted/$filed"
    echo "processed=255;" >> "$PrPWD/users/output/unencrypted/$filed"
    exit 0
fi

# Generate a random filename for temporary C file
outputdelc=`dd if=/dev/urandom bs=1 count=10 2>/dev/null | $PrPWD/stdtohex | tr -d ' '`
while [ -f "$outputdelc.c" ]; do
    outputdelc=`dd if=/dev/urandom bs=1 count=10 2>/dev/null | $PrPWD/stdtohex | tr -d ' '`
done

# Extract array index, IV, and message from the code
arrayindex=`$PrPWD/stdbuscaarg "int $ivfromfile[" "$fn" | $PrPWD/stdcdr "[" | $PrPWD/stdcarsin "]"`
iv=`$PrPWD/stdbuscaarg "int $ivfromfile[$arrayindex] = {" "$fn" | $PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}"`
msj=`$PrPWD/stdbuscaarg "int $encryptedfromfile[" "$fn" | $PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}"`

# Create a new C file with the extracted data
$PrPWD/stdcar "unsigned char iv[" "$PrPWD/users/$usuarioo/$usuarioo-aes.c" > "$outputdelc.c"
echo "$arrayindex] = {$iv};" >> "$outputdelc.c"
$PrPWD/stdcdr "unsigned char iv[" "$PrPWD/users/$usuarioo/$usuarioo-aes.c" | $PrPWD/stdcdr ";" >> "$outputdelc.c"

$PrPWD/stdcar "unsigned char buf[" "$outputdelc.c" > "$outputdelc-2.c"
echo "$arrayindex] = {$msj};" >> "$outputdelc-2.c"
$PrPWD/stdcdr "unsigned char buf[" "$outputdelc.c" | $PrPWD/stdcdr ";" >> "$outputdelc-2.c"
mv "$outputdelc-2.c" "$outputdelc.c"

# Compile the new C file
errores=`gcc -o "$outputdelc-bin" "$outputdelc.c" 2>&1`
if [ -n "$errores" ]; then
    mkdir -p "$PrPWD/users/output/unencrypted"
    echo "errores=\"Error de usuario de nombre de usuario o contraseña\";" > "$PrPWD/users/output/unencrypted/$filed"
    echo "processed=255;" >> "$PrPWD/users/output/unencrypted/$filed"
    exit 0
fi

# Generate a random filename for output data
datosdelc=`dd if=/dev/urandom bs=1 count=10 2>/dev/null | $PrPWD/stdtohex | tr -d ' '`
while [ -f "$datosdelc.c" ]; do
    datosdelc=`dd if=/dev/urandom bs=1 count=10 2>/dev/null | $PrPWD/stdtohex | tr -d ' '`
done

# Run the compiled binary and store the output
"$PaPWD/$outputdelc-bin" > "$datosdelc.c"

# Generate a random filename for the final output
outputdelcu=`dd if=/dev/urandom bs=1 count=10 2>/dev/null | $PrPWD/stdtohex | tr -d ' '`
while [ -f "$outputdelcu.c" ]; do
    outputdelcu=`dd if=/dev/urandom bs=1 count=10 2>/dev/null | $PrPWD/stdtohex | tr -d ' '`
done

# Process the output data
printf "/*" > "$outputdelcu.c"
$PrPWD/stdbuscaarg "buf[" "$datosdelc.c" | $PrPWD/stdcdr "{" | $PrPWD/stdcarsin "}" | $PrPWD/stdfromdec >> "$outputdelcu.c"

# Compile the final output
errores=`gcc -o "$outputdelcu-bin" "$outputdelcu.c" 2>&1`
if [ -z "$errores" ]; then
    mkdir -p "$PrPWD/users/input/$usuarioo"
    cp -v "$outputdelcu.c" "$PrPWD/users/input/$usuarioo/"
fi

# Write the final status
mkdir -p "$PrPWD/users/output/unencrypted"
echo "errores=\"Entrada registrada correctamente, en cuanto se encuentre procesada aparecera la respuesta en la lista de mensajes (con el titulo indicado en la entrada)\";" >> "$PrPWD/users/output/unencrypted/$filed"
echo "processed=255;" >> "$PrPWD/users/output/unencrypted/$filed"

