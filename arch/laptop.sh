
sudo systemctl enable iwd.service

sudo pacman -S --noconfirm --needed power-profiles-daemon

if ls /sys/class/power_supply/BAT* &>/dev/null; then
  # This computer runs on a battery
  powerprofilesctl set balanced || true
else
  # This computer runs on power outlet
  powerprofilesctl set performance || true
fi

