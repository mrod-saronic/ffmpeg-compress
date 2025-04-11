#!/bin/bash

if ! command -v ffmpeg &> /dev/null; then
  echo "📦 Installing ffmpeg..."
  brew install ffmpeg
else
  echo "✅ ffmpeg is already installed."
fi

if ! command -v pv &> /dev/null; then
  echo "📦 Installing pv..."
  brew install pv
else
  echo "✅ pv is already installed."
fi

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="compress"

mkdir -p "$INSTALL_DIR"

cp compress.sh "$INSTALL_DIR/$SCRIPT_NAME"
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Detect shell config file
SHELL_RC=""
if [[ $SHELL == *zsh* ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ $SHELL == *bash* ]]; then
  SHELL_RC="$HOME/.bashrc"
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

echo "🎉 Install complete!"