#!/bin/bash

# Convert mov to mp4
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <output_dir>"
    exit 1
fi

input_file="$1"
output_dir="$2"

# Create output directory if it doesn't exist
echo "Creating output directory $output_dir"
mkdir -p "$output_dir"

# Extract filename without extension
filename=$(basename -- "$input_file")
filename_no_ext="${filename%.*}"

# Set output file path
output_file="${output_dir}/${filename_no_ext}.mp4"

# Run FFmpeg to compress and save to the output directory
echo "Converting $input_file to $output_file"
ffmpeg -i "$input_file" -vcodec libx264 -crf 23 -preset fast -acodec aac -b:a 128k "$output_file"
echo "Done"