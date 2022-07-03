#wm + software
sudo timedatectl set-ntp true
sudo pacman -S xorg lightdm lightdm-gtk-greeter awesome firefox vlc qbittorrent vlc flatpak

systemctl enable lightdm.service
