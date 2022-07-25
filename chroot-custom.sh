#!/bin/bash
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime #Time zone
hwclock --systohc #Sync clock
sed -i '178s/.//' /etc/locale.gen #Localization
locale-gen
echo "LANG=en_US.UTF8" >> /etc/locale.conf
echo "arch" >> /etc/hostname #Network configuration
echo root:admin | chpasswd

pacman -S grub efibootmgr os-prober sudo polkit xdg-user-dirs xdg-utils man-db man-pages texinfo ufw alsa-utils pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber mesa nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable ufw.service
systemctl enable fstrim.timer

ufw default deny
ufw enable

useradd -m ramon
echo ramon:admin | chpasswd
echo "ramon ALL=(ALL) ALL" >> /etc/sudoers.d/ramon

echo 'Section "InputClass"' >> /etc/X11/xorg.conf.d/01-keyboard.conf
echo '        Identifier "system-keyboard"' >> /etc/X11/xorg.conf.d/01-keyboard.conf
echo '        MatchIsKeyboard "on"' >> /etc/X11/xorg.conf.d/01-keyboard.conf
echo '        Option "XkbOptions" "caps:escape_shifted_capslock"' >> /etc/X11/xorg.conf.d/01-keyboard.conf
echo 'EndSection' >> /etc/X11/xorg.conf.d/01-keyboard.conf
