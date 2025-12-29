#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit
fi

echo "--- Updating System ---"
pacman -Syu --noconfirm

echo "--- Installing CUPS and Base Print Packages ---"
# cups: The print server
# cups-pdf: Allows printing to PDF
# ghostscript: Interpreter for PostScript/PDF
# gsfonts: Standard functional fonts
pacman -S --noconfirm cups cups-pdf ghostscript gsfonts

echo "--- Installing Common Drivers ---"
# hplip: HP Printers
# gutenprint: High quality drivers for Canon, Epson, Lexmark, Sony, etc.
pacman -S --noconfirm hplip gutenprint

echo "--- Enabling and Starting CUPS ---"
systemctl enable --now cups

echo "--- Adding current user to 'lp' group ---"
# Use the SUDP_USER variable to get the user who called sudo
if [ -n "$SUDO_USER" ]; then
    usermod -aG lp "$SUDO_USER"
    echo "User $SUDO_USER added to the lp group."
else
    echo "Could not detect username to add to lp group. Please do so manually."
fi

echo "---------------------------------------------------"
echo "Installation Complete!"
echo "You can now configure your printer at: http://localhost:631"
echo "Note: You may need to log out and back in for group changes to take effect."
echo "---------------------------------------------------"
