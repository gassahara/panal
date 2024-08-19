#!/bin/sh

process_file() {
    local file="$1"
    local base_name="$1"
    # Download and process the file if it is a JavaScript file
    if [ -f "$base_name" ]; then
        local pgp_start_count
        local pgp_end_count
        pgp_start_count=$(grep -c "BEGIN PGP MESSAGE" "$base_name")
        pgp_end_count=$(grep -c "END PGP MESSAGE" "$base_name")
        # Process PGP messages if counts match
        if [ "$pgp_start_count" -gt 0 ] && [ "$pgp_start_count" -eq "$pgp_end_count" ]; then
            echo ";$file;" > "$base_name.memoria"
            gpg --homedir "$PrPWD/user/" --no-default-keyring --keyring "$PrPWD/user/key.key" \
                --secret-keyring "$PrPWD/user/key.gpg" --trustdb-name "$PrPWD/user/trustdb.gpg" \
                -d < "$base_name" > "$base_name.c" 2>/dev/null
            # Process the C file
            if [ -s "$base_name.c" ]; then
                # Add comment header to C file
                {
                    echo '/*'
                    cat "$base_name.c"
                } > "$base_name.c.tmp"
                mv "$base_name.c.tmp" "$base_name.c"
                # Check for 'main' function and balance of braces
                if grep -q ' main' "$base_name.c"; then
                    local open_braces
                    local close_braces
                    open_braces=$(grep -c "{" "$base_name.c")
                    close_braces=$(grep -c "}" "$base_name.c")
                    if [ "$open_braces" -eq "$close_braces" ]; then
                        # Compile C file and handle errors
                        if ! gcc "$base_name.c" 2>/dev/null; then
                            rm "$base_name" "$base_name.c"
                            echo "There are errors in $base_name.c"
                        else
                            mkdir -p "$PrPWD/users/input/unencrypted"
                            mv "$base_name.c" "$PrPWD/users/input/unencrypted/"
                        fi
                    fi
                fi
            fi
        fi
    fi
}

# Function to check job status
check_job_status() {
    jobId="$1"
    job_status=$(curl -L "https://storage.googleapis.com/fs0/jobs/job-$jobId")
    echo "$job_status"
}

# Get job 
get_job() {
    job_json=$(curl -L "https://europe-west1-panal-429505.cloudfunctions.net/listGCSBucketJob?bucket=fs0")
    echo "$job_json"
}

# Function to process each inner array of the JSON data
process_json_entry() {
    filename="$1"
    if [ -n "$file_name" ] && [ ! -f "$file_name.memoria" ]; then
        # Check if file extension is not JavaScript
        if [ "$(echo "$file" | awk -F. '{print $NF}')" != "js" ]; then
            echo ";$file;" > "$file_name.memoria"
            return
        fi
	url="$2"
	dir="$3"
	fdir="./"
	if [ -n "$dir" ]; then
	    fdir="$fdir/$dir"
	    if [ ! -d "$fdir" ];then
		mkdir "$fdir"
	    fi
	fi
	echo "dir $fdir"
	# Download the file and save it in the 'files' directory
	curl -L "$url" -o "$fdir/$filename"
	echo "Downloaded: $filename"
	process_file "$fdir/$filename"
    fi
}

# Function to extract value from JSON key
extract_json_value() {
    json="$1"
    key="$2"
    echo "$json" | sed -n 's/.*"'"$key"'":"\([^"]*\)".*/\1/p'
}

# Function to process the entire JSON structure
download_files() {
    jobId="$1"
    filelistUrl="$2"
    # Fetch the JSON from the provided URL
    json_data=$(curl -s "$filelistUrl")
    # Process the JSON data
    echo "$json_data" | tr '[]{}' '
' | while IFS= read -r pair; do
        filename=$(echo "$pair" | cut -d',' -f1 | sed 's/^"//; s/"$//')
        url=$(echo "$pair" | cut -d',' -f2 | sed 's/^"//; s/"$//')
        dir=$(echo "$pair" | cut -d',' -f3 | sed 's/^"//; s/"$//')
	[ "$dir" = "msgs" ] && [ -n "$filename" ] && [ -n "$url" ] && process_json_entry "$filename" "$url" "$dir"
    done
}

# Initialize variables
PaPWD="$PWD"
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
# Extract program name from path
nomprograma=$0
while [ -n "`echo $nomprograma | $PrPWD/stdbuscaarg_donde_hasta '/' `" ]; do
    nomprograma=`echo $nomprograma | $PrPWD/stdcdr '/' `
done
# Change to project directory
cd "$PrPWD" || exit 1
PrPWD=$PWD
cd "$PaPWD" || exit 1
# Extract remote path from host.c
remotepath=`cat $PrPWD/host.c | $PrPWD/stdcdr 'host=' | $PrPWD/stdcdr '"' | $PrPWD/stdcarsin '"'`
echo $remotepath
job=$( get_job )
jobId=$( extract_json_value "$job" "jobId" )

job_status=$(check_job_status "$jobId")
status=$(extract_json_value "$job_status" "status")
while [ "$status" != "completed" ]; do
    echo "$jobId $status"
    sleep 5
    job_status=$(check_job_status "$jobId")
    status=$(extract_json_value "$job_status" "status")
done

outputFile=$(extract_json_value "$job_status" "outputFile")

if [ "$status" = "completed" ]; then
    echo "Job completed. Processing file list..."
    filelistUrl="https://europe-west1-panal-429505.cloudfunctions.net/htmlServer/html/${outputFile}"
    download_files "$jobId" "$filelistUrl"
else
    echo "Job not completed. Current status: $status"
fi
exit 0
