#!/bin/bash

sudo pacman -Syu --noconfirm
# Install Docker
sudo pacman -S docker docker-compose --noconfirm kubectl

sudo systemctl enable --now docker.service

sudo usermod -aG docker $USER

echo "Installation complete."
echo "IMPORTANT: Please log out and log back in (or restart) for the group changes to take effect."
