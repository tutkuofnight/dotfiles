#!/bin/bash

# Target directory
TARGET_DIR="$HOME/.config"

# Get the absolute path of the current directory (Dotfiles Root)
DOTFILES_DIR=$(pwd)

# Ensure .config directory exists
mkdir -p "$TARGET_DIR"

# Common components that are always linked regardless of the desktop environment
common_items=("kitty.conf" "satty" "nvim" "zed")

create_link() {
    local source_path="$1"
    local target_name="$2"
    
    # Remove existing file or directory at the target to prevent nested links
    rm -rf "$TARGET_DIR/$target_name"
    
    echo "Linking: $target_name -> $source_path"
    ln -sf "$DOTFILES_DIR/$source_path" "$TARGET_DIR/$target_name"
}

# 1. Link Common Configurations
echo "--- Applying Common Configs ---"
for item in "${common_items[@]}"; do
    if [ -e "$DOTFILES_DIR/$item" ]; then
        create_link "$item" "$item"
    else
        echo "Skipping: $item (Not found in $DOTFILES_DIR)"
    fi
done

# 2. Link Selective Components (Hyprland vs i3)
case $1 in
    hypr)
        echo "--- Applying Hyprland Setup ---"
        # Linking subfolders from the hyprland directory directly to .config
        create_link "hyprland/hypr" "hypr"
        create_link "hyprland/waybar" "waybar"
        ;;
    i3)
        echo "--- Applying i3 Setup ---"
        # Linking subfolders from the i3 directory directly to .config
        create_link "i3/i3" "i3"
        create_link "i3/polybar" "polybar"
        ;;
    *)
        echo "Error: Invalid argument."
        echo "Usage: ./manage.sh [hypr|i3]"
        exit 1
        ;;
esac

echo "--- Symlink process finished successfully! ---"