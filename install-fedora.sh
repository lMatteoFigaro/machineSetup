#!/bin/bash

# Fedora Machine Setup Installation Script
# Converts the Ansible playbooks to a dnf-based installation script for Fedora
# Run with: sudo bash install-fedora.sh

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_error "This script must be run with sudo"
        exit 1
    fi
}

# Check if running as root
check_root

print_info "Starting Fedora machine setup..."

# Update system
print_info "Updating system packages..."
dnf update -y

dnf copr enable scottames/ghostty

# Install common utilities and development packages
print_info "Installing common utilities and development packages..."
dnf install -y \
    git \
    nano \
    curl \
    vim \
    htop \
    tmux \
    fzf \
    ripgrep \
    stow \
    zsh \
    cmake \
    gcc-c++ \
    pkg-config \
    jq \
    go \
    rust cargo \
    ghostty \
    google-chrome-stable

# Install Docker
print_info "Installing Docker..."
dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl start docker
systemctl enable docker

# Get the current user (the one who ran sudo)
CURRENT_USER="${SUDO_USER:-$(id -un)}"
print_info "Adding user $CURRENT_USER to docker group..."
usermod -aG docker "$CURRENT_USER"

# Install Neovim
print_info "Installing Neovim..."
NVIM_INSTALL_DIR="/opt/nvim"
mkdir -p "$NVIM_INSTALL_DIR"
cd /tmp
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz -C "$NVIM_INSTALL_DIR" --strip-components=1
ln -sf "$NVIM_INSTALL_DIR/bin/nvim" /usr/local/bin/nvim
rm -f nvim-linux-x86_64.tar.gz

# Install Google Cloud SDK
print_info "Installing Google Cloud SDK..."
GCLOUD_DOWNLOAD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz"
mkdir -p /opt/google-cloud-sdk
cd /tmp
curl -L "$GCLOUD_DOWNLOAD_URL" -o google-cloud-cli-latest.tar.gz
tar xzf google-cloud-cli-latest.tar.gz -C /opt/google-cloud-sdk/ --strip-components=1
ln -sf /opt/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud
rm -f google-cloud-cli-latest.tar.gz

# Install Slack
print_info "Installing Slack..."
cd /tmp
# Try to download the latest Slack version
curl -L https://downloads.slack-edge.com/desktop-releases/linux/x64/4.47.69/slack-4.47.69-0.1.el8.x86_64.rpm -o slack-latest.rpm
dnf install -y ./slack-latest.rpm
rm -f slack-latest.rpm

# Install Helium web browser
print_info "Installing Helium web browser..."
cd /tmp
curl -L https://github.com/imputnet/helium-linux/releases/download/0.7.7.1/helium-0.7.7.1-x86_64.AppImage -o helium.AppImage
chmod +x helium.AppImage
mv helium.AppImage /usr/local/bin/helium

curl -fsSL https://opencode.ai/install | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

print_info "Installation complete!"
print_warn "Please log out and log back in for group membership changes to take effect (docker group for $CURRENT_USER)"
print_warn "Also run 'source ~/.bashrc' or open a new terminal to use the newly installed tools"
