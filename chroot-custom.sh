#!/bin/bash
#Time zone
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime 
#Sync clock
hwclock --systohc 
#Localization
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/'
sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/'
locale-gen
echo "LANG=en_US.UTF8" > /etc/locale.conf
#Network configuration
echo "arch" > /etc/hostname 
echo root:admin | chpasswd

pacman -S grub efibootmgr os-prober sudo polkit networkmanager xdg-user-dirs xdg-utils man-db man-pages texinfo ufw alsa-utils pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber mesa dkms linux-lts-headers nvidia-lts nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable ufw.service
systemctl enable fstrim.timer

ufw default deny
ufw enable

useradd -m ramon
echo ramon:admin | chpasswd

#Keyboard settings
localectl --no-convert set-x11-keymap "us,us" "pc86" "us-intl" "caps:escape_shifted_capslock"
