#!/bin/bash

DOTFILES_DIR=$(pwd)
CONFIG_DIR=~/.config
HOME_DIR=~

# Ensure the config directory exists
mkdir -p $CONFIG_DIR

# List of items to symlink into .config
config_items=(
  "aerospace"
  "alacritty"
  "cava"
  "mc"
  "neofetch"
  "nvim"
  "ranger"
  "raycast"
  "sketchybar"
  "sway"
  "tmux"
  "waybar"
  "wofi"
)

# List of items to symlink into home directory
home_items=(
  ".wezterm.lua"
  ".zshrc"
  "Brewfile"
)

# Function to create symlinks and remove old ones if they exist
create_symlink() {
  local source=$1
  local target=$2

  if [ -L "$target" ]; then
    echo "Removing existing symlink at $target"
    rm "$target"
  elif [ -e "$target" ]; then
    echo "Backing up existing file at $target"
    mv "$target" "${target}.bak"
  fi

  ln -s "$source" "$target"
  echo "Linked $target -> $source"
}

# Symlink items into .config directory
for item in "${config_items[@]}"; do
  create_symlink "$DOTFILES_DIR/$item" "$CONFIG_DIR/$item"
done

# Symlink items into home directory
for item in "${home_items[@]}"; do
  create_symlink "$DOTFILES_DIR/$item" "$HOME_DIR/$item"
done

