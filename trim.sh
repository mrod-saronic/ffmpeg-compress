#!/bin/bash

# Function to validate timestamp format (HH:MM:SS or MM:SS)
validate_timestamp() {
  local timestamp="$1"
  if [[ ! "$timestamp" =~ ^([0-9]{2}:)?[0-9]{2}:[0-9]{2}$ ]]; then
    echo "❌ Invalid timestamp format: '$timestamp'. Expected format is HH:MM:SS or MM:SS."
    return 1
  fi
  return 0
}

# Function to trim a video file
trim_video() {
  input_file="$1"
  start_time="$2"
  end_time="$3"

  if [[ ! -f "$input_file" ]]; then
    echo "❌ '$input_file' is not a file. Skipping."
    return
  fi

  if ! validate_timestamp "$start_time"; then
    exit 1
  fi
  if ! validate_timestamp "$end_time"; then
    exit 1
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
if [[ $# -eq 0 ]]; then
  echo "⚠️ Please provide a file to compress."
  echo "Run 'compress --help' for usage."
  exit 1
fi

if [[ "$1" == "--help"]]; then
  echo "Usage:"
  echo "  trim <file> <start_time> <end_time>  Trim a video file between the specified timestamps"
  echo "  trim --help                          Show this help message"
  echo
  echo "Examples:"
  echo "  trim video.mp4 00:01:00 00:02:00     Trim video.mp4 from 1:00 to 2:00"
  exit 1
elif [[ $# -eq 3]]; then
  trim_video "$1" "$2" "$3"
elif [[ $# -lt 3 ]]; then
  echo "⚠️ Invalid arguments. Run 'trim --help' for usage."
  exit 1
fi