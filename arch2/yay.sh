mkdir -p ~/dev
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git ~/dev/yay-bin
cd ~/dev/yay-bin
makepkg -si

yay -S --noconfirm hyprmon-bin

yay -S --noconfirm slack-desktop

yay -S --noconfirm forticlient-vpn
#https://community.fortinet.com/t5/FortiClient/Technical-Tip-How-to-use-FortiClient-SSL-VPN-from-the-CLI/ta-p/192581?externalID=FD41256
