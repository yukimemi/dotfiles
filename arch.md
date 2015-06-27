* loadkeys jp106
* cgdisk
* mkfs.ext4
* mount /dev/sda3 /mnt
* wifi-menu
* vi /etc/pacman.d/mirrorlist
  - Japan 4 行を一番上へ
* pacstrap /mnt base base-devel
* genfstab -U -p /mnt >> /mnt/etc/fstab
* vi /mnt/etc/fstab
  - ssd のために以下のオプションに変更
    rw,noatime,discard,data=writeback
* arch-chroot /mnt /bin/bash
* echo archair > /etc/hostname
* vi /etc/hosts
  - localhostのホスト名を編集
* ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
* vi /etc/locale.gen
  - 以下2行をコメント解除
    en_US.UTF-8
    ja_JP.UTF-8
* locale-gen
* vi /etc/locale.conf
  - LANG=en_US.UTF-8
* hwclock --systohc --utc
* vi /etc/vconsole.conf
  - 以下を記載
  KEYMAP=jp106
* pacman -S iw wpa_supplicant dialog
* mkinitcpio -p linux
* passwd
* pacman -S grub-efi-x86_64
* vi /etc/defaults/grub
  - GRUB_CMDLINE_LINUX_DEFAULT="quiet rootflags=data=writeback"
* grub-mkconfig -o /boot/grub/grub.cfg
* grub-mkstandalone -o boot.efi -d usr/lib/grub/x86_64-efi -O x86_64-efi --compress=xz boot/grub/grub.cfg
* mkdir /efi
* mount -t hfsplus -o force,rw /dev/sda2 /efi
* cp boot.efi /efi
* useradd -m -G wheel yukimemi
* passwd yukimemi
* visudo
  - wheel の行をコメント解除
* exit
* reboot

* wifi-menu
* sudo pacman -S xorg xorg-server-utils xorg-init alsa-utils awesome
* mkdir -p ~/.config/awesome
* cp /etc/xdg/awesome/rc.lua ~/.config/awesome
* vi ~/.xinitrc
  setxkbmap -model jp106 -layout jp
  exec awesome
* sudo pacman -S vim zsh git tmux


