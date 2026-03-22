#!/bin/bash

# Target directory
TARGET_DIR="$HOME/.config"
DOTFILES_DIR=$(pwd)

# Package Lists
COMMON_PKGS="kitty neovim zed satty git base-devel appimagelauncher spotify brave-bin zen-browser-bin vlc"
HYPR_PKGS="hyprland waybar rofi-wayland swww hyprpicker hyprlock hypridle"
I3_PKGS="i3-wm polybar rofi feh picom"

# --- Functions ---

install_yay() {
    if ! command -v yay &> /dev/null; then
        echo "--- yay not found. Installing yay from AUR... ---"
        # Install git and base-devel first if not present
        sudo pacman -S --needed --noconfirm git base-devel
        
        # Clone and build yay
        TEMP_DIR=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$TEMP_DIR/yay"
        cd "$TEMP_DIR/yay" || exit
        makepkg -si --noconfirm
        cd "$DOTFILES_DIR" || exit
        rm -rf "$TEMP_DIR"
        echo "--- yay installed successfully. ---"
    else
        echo "--- yay is already installed. ---"
    fi
}

create_link() {
    local source_path="$1"
    local target_name="$2"
    rm -rf "$TARGET_DIR/$target_name"
    echo "Linking: $target_name -> $source_path"
    ln -sf "$DOTFILES_DIR/$source_path" "$TARGET_DIR/$target_name"
}

# --- Main Execution ---

# 1. Ensure yay is installed first
install_yay

# 2. Set Installer
INSTALLER="yay -S --noconfirm --needed"

mkdir -p "$TARGET_DIR"

case $1 in
    hypr)
        echo "--- Starting Hyprland Setup ---"
        $INSTALLER $COMMON_PKGS $HYPR_PKGS
        
        # Linking logic
        common_items=("kitty.conf" "satty" "nvim" "zed" "chromium-flags.conf")
        for item in "${common_items[@]}"; do
            [ -e "$DOTFILES_DIR/$item" ] && create_link "$item" "$item"
        done
        create_link "hyprland/hypr" "hypr"
        create_link "hyprland/waybar" "waybar"
        ;;
    i3)
        echo "--- Starting i3wm Setup ---"
        $INSTALLER $COMMON_PKGS $I3_PKGS
        
        # Linking logic
        common_items=("kitty.conf" "satty" "nvim" "zed" "chromium-flags.conf")
        for item in "${common_items[@]}"; do
            [ -e "$DOTFILES_DIR/$item" ] && create_link "$item" "$item"
        done
        create_link "i3/i3" "i3"
        create_link "i3/polybar" "polybar"
        ;;
    *)
        echo "Usage: ./manage.sh [hypr|i3]"
        exit 1
        ;;
esac

echo "--- Setup complete! All packages installed and files linked. ---"