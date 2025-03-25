#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: compress <input_file.mov>"
  exit 1
fi

input_file="$1"

if [[ ! -f "$input_file" ]]; then
  echo "❌ Error: '$input_file' is not a valid file."
  exit 1
fi

if [[ "$input_file" != *.mov ]]; then
  echo "⚠️ Warning: Input file does not have a .mov extension."
fi

input_dir=$(dirname "$input_file")
output_dir="${input_dir}/compressed"

if [[ ! -d "$output_dir" ]]; then
  echo "📁 Creating output directory: $output_dir"
  mkdir -p "$output_dir"
  if [[ $? -ne 0 ]]; then
    echo "❌ Failed to create output directory."
    exit 1
  fi
fi

filename=$(basename -- "$input_file")
filename_no_ext="${filename%.*}"
output_file="${output_dir}/${filename_no_ext}.mp4"

echo "🎬 Compressing '$input_file' to '$output_file'..."
ffmpeg -i "$input_file" -vcodec libx264 -crf 23 -preset fast -acodec aac -b:a 128k "$output_file"

if [[ $? -eq 0 ]]; then
  echo "✅ Compression complete: $output_file"
else
  echo "❌ Compression failed."
  exit 1
fi