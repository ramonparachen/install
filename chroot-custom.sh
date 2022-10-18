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

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable ufw.service
systemctl enable fstrim.timer

ufw default deny
ufw enable

useradd -m ramon
echo ramon:admin | chpasswd

#Caps works as Esc unless also press shift
echo "ramon ALL=(ALL) ALL" >> /etc/sudoers.d/ramon

echo 'Section "InputClass"' >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo '        Identifier "system-keyboard"' >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo '        MatchIsKeyboard "on"' >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo '        Option "XkbOptions" "caps:escape_shifted_capslock"' >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo 'EndSection' >> /etc/X11/xorg.conf.d/00-keyboard.conf

#Nvidia settings
##Set nvidia card as primary graphics provider
echo 'Section "OutputClass"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    Identifier "intel"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    MatchDriver "i915"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    Driver "modesetting"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo 'EndSection' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo 'Section "OutputClass"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    Identifier "nvidia"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    MatchDriver "nvidia-drm"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    Driver "nvidia"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    Option "AllowEmptyInitialConfiguration"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    Option "PrimaryGPU" "yes"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    ModulePath "/usr/lib/nvidia/xorg"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo '    ModulePath "/usr/lib/xorg/modules"' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo 'EndSection' >> /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf

#Monitor settings
echo '#!/bin/sh' >> /etc/lightdm/display-setup.sh
echo 'xrandr --setprovideroutputsource modesetting NVIDIA-0' >> /etc/lightdm/display-setup.sh
echo 'xrandr --output HDMI-0 --mode 1920x1080 --auto --primary' >> /etc/lightdm/display-setup.sh
echo 'xrandr --output eDP-1-1 --mode 1920x1080 --auto --left-of HDMI-0' >> /etc/lightdm/display-setup.sh

chmod +x /etc/lightdm/display-setup.sh
sed -ie '114s|$|display-setup-script=/etc/lightdm/display-setup.sh|' /etc/lightdm/lightdm.conf
