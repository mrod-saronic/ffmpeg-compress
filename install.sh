#!/bin/bash

INSTALL_DIR="$HOME/.local/bin"

mkdir -p "$INSTALL_DIR"

cp compress.sh "$INSTALL_DIR/compress"
chmod +x "$INSTALL_DIR/compress"

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "Adding $INSTALL_DIR to PATH in ~/.bashrc (or ~/.zshrc)..."
    
    SHELL_RC=""
    if [[ -f "$HOME/.bashrc" ]]; then
        SHELL_RC="$HOME/.bashrc"
    elif [[ -f "$HOME/.zshrc" ]]; then
        SHELL_RC="$HOME/.zshrc"
    fi

    if [[ -n "$SHELL_RC" ]]; then
        echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$SHELL_RC"
        echo "✅ Added to PATH. Restart your terminal or run: source $SHELL_RC"
    else
        echo "⚠️ Couldn't find your shell config file. Add this to your PATH manually:"
        echo "export PATH=\"\$PATH:$INSTALL_DIR\""
    fi
else
    echo "✅ compress command is now available. Try running: compress input.mov /path/to/output/"
fi