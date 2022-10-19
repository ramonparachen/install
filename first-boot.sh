#wm + software
sudo timedatectl set-ntp true
sudo pacman -S xorg xterm kitty lightdm lightdm-gtk-greeter awesome network-manager-applet firefox vlc qbittorrent flatpak

systemctl enable lightdm.service

rm -rf /home/ramon/.config/awesome
cp -r /install/.config/awesome /home/ramon/.config/
chmod +x /home/ramon/.config/awesome/autorun.sh
cp /install/.vimrc /home/ramon/.vimrc
