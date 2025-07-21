#!/bin/bash

# --- Configuration ---
# Set this to the username for which NVM and Oh My Zsh should be installed.
# If unset, it defaults to the user running the script.

# --- Helper Functions ---

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install packages using pacman, with sudo if needed
install_pacman() {
  if ! command_exists pacman; then
    echo "Error: pacman is not available. This script is for Arch Linux."
    exit 1
  fi
  echo "--- Installing packages via pacman: $@" 
  sudo pacman -Syu --noconfirm "$@"
  if [ $? -ne 0 ]; then
    echo "Error installing packages with pacman. Please check the output."
    exit 1
  fi
}

# Function to install packages using yay (AUR helper)
install_yay() {
  if ! command_exists yay; then
    echo "Error: yay (or another AUR helper) is not found."
    echo "Please install an AUR helper first. For example:"
    echo "  git clone https://aur.archlinux.org/yay.git"
    echo "  cd yay && makepkg -si --noconfirm"
    exit 1
  fi
  echo "--- Installing packages via yay: $@" ---
  yay -S --noconfirm "$@"
  if [ $? -ne 0 ]; then
    echo "Error installing packages with yay. Please check the output."
    exit 1
  fi
}

INSTALL="sudo pacman -Syu --noconfirm"

INSTALL_AUR="yay -S --noconfirm"

# --- System Update ---
echo "--- Updating system package database and upgrading all packages ---"
$INSTALL

# --- Core Utilities and Development Packages ---
echo "--- Installing common utilities and development packages ---"
$INSTALL git base-devel nano curl vim htop tmux fzf ripgrep stow pavucontrol zsh xsel xclip cmake pkg-config freetype2 jq
$INSTALL hyprland hyprpaper hypridle hyprlock mako pipewire wireplumber xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland noto-fonts waybar yay grim slurp wofi nautilus
$INSTALL ghostty 
$INSTALL neovim 


$INSTALL_AUR xdg-desktop-portal-hyprland-git

# --- Language Runtimes and Tooling ---

$INSTALL go 
$INSTALL rust 
$INSTALL zig 
$INSTALL nvm 


# Docker CLI
echo "--- Enabling and starting Docker service ---"
$INSTALL docker docker-compose
sudo systemctl enable docker --now



# VS Code (using AUR)
echo "--- Installing VS Code (visual-studio-code-bin) from AUR ---"
$INSTALL_YAY visual-studio-code-bin

# Slack (using AUR)
echo "--- Installing Slack from AUR ---"
$INSTALL_YAY slack-desktop

# Zed Editor (using AUR, package name might vary, common is zed-editor)
echo "--- Installing Zed Editor from AUR ---"
$INSTALL_YAY zed-editor # Adjust package name if needed

# Chrome (using AUR)
echo "--- Installing Google Chrome (google-chrome) from AUR ---"
$INSTALL_YAY google-chrome

$INSTALL_YAY zen-browser-bin

# --- User-specific Configurations (NVM, Oh My Zsh) ---

# Set Zsh as default shell for the user
echo "--- Setting Zsh as the default shell for user: $INSTALL_FOR_USER ---"
if ! command_exists zsh; then
  echo "Error: zsh is not installed. Cannot set as default shell."
else
  sudo chsh -s $(which zsh) "$INSTALL_FOR_USER"
  echo "Zsh set as default shell for $INSTALL_FOR_USER. Please log out and log back in."
fi


echo "install ho my zsh"
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


echo ""
echo "--- Script finished ---"
echo "Please review the output for any errors."
echo "For NVM and Rust to work correctly, you may need to close and reopen your terminal."
echo "If you changed the default shell to Zsh, log out and log back in."
echo ""
echo "Remember to configure your Hyprland settings separately in ~/.config/hypr/hyprland.conf"
