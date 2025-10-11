#!/bin/bash

INSTALL="sudo pacman -Syu --noconfirm"

INSTALL_AUR="yay -S --noconfirm"

# --- System Update ---
echo "--- Updating system package database and upgrading all packages ---"
$INSTALL

# --- Core Utilities and Development Packages ---
echo "--- Installing common utilities and development packages ---"
$INSTALL git base-devel nano curl vim htop tmux fzf ripgrep stow pavucontrol zsh xsel xclip cmake pkg-config freetype2 jq
$INSTALL hyprland hyprpaper hypridle hyprlock mako hyprpolkitagent qt5-wayland qt6-wayland noto-fonts waybar grim slurp wofi nautilus iwd impala rsync
$INSTALL ghostty wiremix
$INSTALL neovim 
$INSTALL openssh 
$INSTALL pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber


# Install yay
mkdir ~/dev
cd ~/dev

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


$INSTALL_AUR xdg-desktop-portal-hyprland-git

# --- Language Runtimes and Tooling ---

$INSTALL go 
$INSTALL rust 
$INSTALL zig 
$INSTALL nvm 
$INSTALL zed 


# Docker CLI
echo "--- Enabling and starting Docker service ---"
$INSTALL docker docker-compose
sudo systemctl enable docker --now



# VS Code (using AUR)
echo "--- Installing VS Code (visual-studio-code-bin) from AUR ---"
$INSTALL_AUR visual-studio-code-bin

# Slack (using AUR)
echo "--- Installing Slack from AUR ---"
$INSTALL_AUR slack-desktop

# Chrome (using AUR)
echo "--- Installing Google Chrome (google-chrome) from AUR ---"
$INSTALL_AUR google-chrome

$INSTALL_AUR zen-browser-bin

# --- User-specific Configurations (NVM, Oh My Zsh) ---

$INSTALL_AUR wdisplays


echo "install ho my zsh"
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

