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

  echo "🎬 Compressing '$input_file' → '$output_file'"
  ffmpeg -i "$input_file" -vcodec libx264 -crf 23 -preset fast -acodec aac -b:a 128k "$output_file" < /dev/null

  if [[ $? -eq 0 ]]; then
    echo "✅ Done: $output_file"
  else
    echo "❌ Failed: $input_file"
  fi
}

# Check args
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