#!/bin/sh

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

# Main execution function

job=$( get_job )
jobId=$( extract_json_value "$job" "jobId" )

if [ -z "$jobId" ]; then
    echo "Please provide a job ID"
    exit 1
fi

job_status=$(check_job_status "$jobId")
status=$(extract_json_value "$job_status" "status")
outputFile=$(extract_json_value "$job_status" "outputFile")

if [ "$status" = "completed" ]; then
    echo "Job completed. Processing file list..."
    filelistUrl="https://europe-west1-panal-429505.cloudfunctions.net/htmlServer/html/${outputFile}"
    download_files "$jobId" "$filelistUrl"
else
    echo "Job not completed. Current status: $status"
fi
