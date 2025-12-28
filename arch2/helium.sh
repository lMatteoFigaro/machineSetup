#!/bin/bash

# Define variables
URL="https://github.com/imputnet/helium-linux/releases/download/0.7.7.1/helium-0.7.7.1-x86_64.AppImage"
DEST="/usr/local/bin/helium"
DESKTOP_FILE="/usr/share/applications/helium.desktop"

# Install fuse2 (required for AppImages)
sudo pacman -S --needed fuse2 --noconfirm

# Download the AppImage
echo "Downloading Helium Browser..."
sudo curl -L "$URL" -o "$DEST"

# Make it executable
sudo chmod +x "$DEST"

# Create the .desktop file for the application menu
echo "Creating desktop entry..."
sudo tee "$DESKTOP_FILE" > /dev/null <<EOF
[Desktop Entry]
Name=Helium
Exec=/usr/local/bin/helium --password-store=basic
Icon=web-browser
Type=Application
Categories=Network;WebBrowser;
Terminal=false
Comment=Helium Browser AppImage
EOF

echo "Installation complete!"
echo "You can now launch Helium from your application menu or by typing 'helium' in the terminal."
