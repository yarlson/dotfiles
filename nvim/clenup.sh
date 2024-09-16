#!/bin/bash

set -euo pipefail

echo "Starting Neovim cleanup..."

directories=(
  "$HOME/.local/share/nvim"
  "$HOME/.cache/nvim"
)

for dir in "${directories[@]}"; do
  if [ -e "$dir" ]; then
    echo "Removing $dir..."
    rm -rf "$dir"
  else
    echo "$dir does not exist, skipping."
  fi
done

echo "Neovim cleanup completed."
