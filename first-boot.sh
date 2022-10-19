#wm + software
sudo timedatectl set-ntp true
sudo pacman -S xorg xterm kitty lightdm lightdm-gtk-greeter awesome network-manager-applet firefox vlc qbittorrent flatpak

systemctl enable lightdm.service

#Keyboard settings
localectl --no-convert set-x11-keymap "us,us" "pc86" "us-intl" "caps:escape_shifted_capslock"

cp -r /install/.config /home/ramon
chmod +x /home/ramon/.config/awesome/autorun.sh
cp /install/.vimrc /home/ramon
