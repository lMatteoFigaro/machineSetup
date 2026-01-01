#!/bin/bash

# 1. Get the current username
USER_NAME=$(whoami)

# 2. Create the systemd override for TTY1 Autologin
echo "Setting up TTY1 autologin..."
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/

cat <<EOF | sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $USER_NAME --noclear %I \$TERM
EOF

# 3. Add Hyprland auto-start logic to the shell profile
# This detects if you are using zsh or bash and updates the correct file
PROFILE_FILE="$HOME/.zprofile"

echo "Adding Hyprland start logic to $PROFILE_FILE..."

cat <<EOF >> "$PROFILE_FILE"

# Start Hyprland automatically on TTY1
if [ -z "\$DISPLAY" ] && [ "\$(tty)" = "/dev/tty1" ]; then
    exec start-hyprland
fi
EOF

echo "Setup complete. Please reboot to test."
