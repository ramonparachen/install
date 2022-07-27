#wm + software
sudo timedatectl set-ntp true
sudo pacman -S xorg xterm alacritty lightdm lightdm-gtk-greeter awesome network-manager-applet firefox vlc qbittorrent vlc flatpak

systemctl enable lightdm.service
