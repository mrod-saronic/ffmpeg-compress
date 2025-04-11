#!/bin/bash

# Function to trim a video file
trim_video() {
  input_file="$1"
  start_time="$2"
  end_time="$3"

  if [[ ! -f "$input_file" ]]; then
    echo "❌ '$input_file' is not a file. Skipping."
    return
  fi

  input_dir=$(dirname "$input_file")
  filename=$(basename -- "$input_file")
  filename_no_ext="${filename%.*}"
  output_dir="${input_dir}/trimmed"
  # Update the output file name to include the start and end times
  output_file="${output_dir}/${filename_no_ext}_trimmed_${start_time//:/-}_${end_time//:/-}.mp4"

  mkdir -p "$output_dir"

  echo "✂️ Trimming '$input_file' from $start_time to $end_time → '$output_file'"
  ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c copy "$output_file"

  if [[ $? -eq 0 ]]; then
    echo "✅ Trimmed video saved as '$output_file'"
  else
    echo "❌ Failed to trim '$input_file'"
  fi
}

# Check arguments
if [[ $# -lt 3 ]]; then
  echo "⚠️ Usage: trim <file> <start_time> <end_time>"
  echo "Example: trim video.mp4 00:01:00 00:02:00"
  exit 1
fi

# Call the trim function
trim_video "$1" "$2" "$3"