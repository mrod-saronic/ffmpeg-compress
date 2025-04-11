#!/bin/bash

# Function to compress a single file
compress_file() {
  input_file="$1"

  if [[ ! -f "$input_file" ]]; then
    echo "❌ '$input_file' is not a file. Skipping."
    return
  fi

  input_dir=$(dirname "$input_file")
  filename=$(basename -- "$input_file")
  filename_no_ext="${filename%.*}"
  output_dir="${input_dir}/compressed"
  output_file="${output_dir}/${filename_no_ext}.mp4"

  mkdir -p "$output_dir"

  # Get the duration of the input file in seconds
  duration=$(ffprobe -i "$input_file" -show_entries format=duration -v quiet -of csv="p=0" | awk '{printf "%.0f", $1}')
  if [[ -z "$duration" || "$duration" -eq 0 ]]; then
    echo "❌ Unable to determine duration for '$input_file'. Skipping."
    return
  fi

  # Convert duration to minutes for display
  duration_minutes=$(awk "BEGIN {printf \"%.2f\", $duration / 60}")
  echo "🕒 Video Duration: $duration_minutes minutes"

  # Create a temporary file for progress tracking
  progress_file=$(mktemp)

  echo "🎬 Compressing '$input_file' → '$output_file'"
  ffmpeg -i "$input_file" -vcodec libx264 -crf 23 -preset fast -acodec aac -b:a 128k -f mp4 -y "$output_file" \
    -progress "$progress_file" -loglevel error &

  ffmpeg_pid=$!

  # Display progress bar
  while kill -0 "$ffmpeg_pid" 2>/dev/null; do
    sleep 1
    current_time=$(grep "out_time_ms" "$progress_file" | tail -n 1 | cut -d= -f2)
    if [[ -n "$current_time" ]]; then
      current_time_sec=$((current_time / 1000000))
      percent=$((current_time_sec * 100 / duration))
      if [[ $percent -gt 100 ]]; then
        percent=100
      fi
      bar_length=$percent # Scale to fit 100 characters
      bar=$(printf "%-${bar_length}s" "#" | tr ' ' '#')
      printf "\r⏳ Progress: [%-100s] %d%%" "$bar" "$percent"
    fi
  done

  # Clean up
  rm -f "$progress_file"

  wait "$ffmpeg_pid"
  if [[ $? -eq 0 ]]; then
    echo -e "\n✅ Done: $output_file"
  else
    echo -e "\n❌ Failed: $input_file"
  fi
}

# Check arguments
if [[ $# -eq 0 ]]; then
  echo "⚠️ Please provide a file to compress."
  echo "Run 'compress --help' for usage."
  exit 1
fi

if [[ "$1" == "--batch" ]]; then
  search_dir="${2:-.}"         # Default to current directory if not provided
  pattern="${3:-*.mov}"        # Default pattern to *.mov

  if [[ ! -d "$search_dir" ]]; then
    echo "❌ The directory '$search_dir' does not exist or is not accessible."
    exit 1
  fi

  echo "🔍 Searching in '$search_dir' for files matching '$pattern'..."
  shopt -s nullglob
  files=("$search_dir"/$pattern)

  if [[ ${#files[@]} -eq 0 ]]; then
    echo "⚠️ No files found."
    exit 1
  fi

  for file in "${files[@]}"; do
    compress_file "$file"
  done
elif [[ "$1" == "--help" ]]; then
  echo "Usage:"
  echo "  compress <file.mov>                  Compress a single file"
  echo "  compress --batch [dir]               Compress all .mov files in a directory"
  echo "  compress --batch [dir] '[pattern]'   Compress all .mov files or matching pattern in a directory"
  echo
  echo "Examples:"
  echo "  compress video.mov"
  echo "  compress --batch ./recordings"
  echo "  compress --batch ./recordings 'screen*.mov'"
  exit 1
elif [[ $# -eq 1 ]]; then
  compress_file "$1"
else
  echo "⚠️ Invalid arguments. Run 'compress --help' for usage."
  exit 1
fi