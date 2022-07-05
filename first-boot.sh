#wm + software
sudo timedatectl set-ntp true
sudo pacman -S xorg xterm lightdm lightdm-gtk-greeter awesome firefox vlc qbittorrent vlc flatpak

systemctl enable lightdm.service

setxkbmap -option caps:escape_shifted_capslock
