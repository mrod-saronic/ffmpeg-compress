#!/bin/bash

# Detect the operating system
OS=$(uname -s)

# Install ffmpeg
if ! command -v ffmpeg &> /dev/null; then
  echo "📦 Installing ffmpeg..."
  if [[ "$OS" == "Darwin" ]]; then
    # macOS
    brew install ffmpeg
  elif [[ "$OS" == "Linux" ]]; then
    # Linux
    if command -v apt &> /dev/null; then
      sudo apt update && sudo apt install -y ffmpeg
    elif command -v yum &> /dev/null; then
      sudo yum install -y epel-release && sudo yum install -y ffmpeg
    else
      echo "❌ Unsupported package manager. Please install ffmpeg manually."
      exit 1
    fi
  elif [[ "$OS" == "MINGW"* || "$OS" == "CYGWIN"* || "$OS" == "MSYS"* ]]; then
    # Windows
    echo "⚠️ Windows detected. Please follow these steps to install ffmpeg:"
    echo "1. Download the FFmpeg zip file from https://ffmpeg.org/download.html."
    echo "2. Extract the zip file to a directory (e.g., C:\\ffmpeg)."
    echo "3. Add the bin directory (e.g., C:\\ffmpeg\\bin) to your system's PATH."
    echo "4. Restart your terminal or command prompt."
    exit 0
  else
    echo "❌ Unsupported operating system. Please install ffmpeg manually."
    exit 1
  fi
else
  echo "✅ ffmpeg is already installed."
fi

INSTALL_DIR="$HOME/.local/bin"
COMPRESS_SCRIPT_NAME="compress"
TRIM_SCRIPT_NAME="trim"

mkdir -p "$INSTALL_DIR"

# Copy and make compress.sh executable
cp compress.sh "$INSTALL_DIR/$COMPRESS_SCRIPT_NAME"
chmod +x "$INSTALL_DIR/$COMPRESS_SCRIPT_NAME"

# Copy and make trim.sh executable
cp trim.sh "$INSTALL_DIR/$TRIM_SCRIPT_NAME"
chmod +x "$INSTALL_DIR/$TRIM_SCRIPT_NAME"

# Detect shell config file
SHELL_RC=""
if [[ $SHELL == *zsh* ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ $SHELL == *bash* ]]; then
  if [[ -f "$HOME/.bashrc" ]]; then
    SHELL_RC="$HOME/.bashrc"
  elif [[ -f "$HOME/.bash_profile" ]]; then
    SHELL_RC="$HOME/.bash_profile"
  fi
fi

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  if [[ -n "$SHELL_RC" ]]; then
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$SHELL_RC"
    echo "✅ Added $INSTALL_DIR to your PATH in $SHELL_RC"
    echo "🔁 Please run: source $SHELL_RC"
  else
    echo "⚠️ Could not detect your shell config. Please add this to your shell config manually:"
    echo "export PATH=\"\$PATH:$INSTALL_DIR\""
  fi
else
  echo "✅ $INSTALL_DIR is already in your PATH."
fi

echo "🎉 Install complete! Both 'compress' and 'trim' commands are now available."