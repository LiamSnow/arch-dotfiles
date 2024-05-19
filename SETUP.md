# Liam's Arch Setup Instructions

The following instructions sets up basic Arch Linux with an encrypted root partition, dual booted with Windows via GRUB.

- References: [Install Guide](https://wiki.archlinux.org/title/Installation_guide), [Encryption](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition)

## 1\. Install

### Increase Font (Optional)

1. `setfont iso01-12x22.psfu.gz`

### Verify Boot

1. `cat /sys/firmware/efi/fw_platform_size` = `64`

### Connect to WiFi (Optional)

1. `iwctl`
2. `device list`
3. `station YOURDEVICE connect YOURSSID`
4. `quit`

### Internet Config

1. Verify: `ping cloudflare.com`
2. Check System Clock: `timedatectl`

### Partition Disk

1. `fdisk -l`
2. `fdisk DEVICE`
3. Print: `p`
4. Remove All Existing: `d`
5. Make EFI Partition (`EFI_DEV`):
   1. Make: `n`, #: `enter`, First Sector: `enter`, Last Sector: `+1G`, Signature: `Y`
   2. Change Type: `t`, Type: `1`
6. Make Root Partition (`ROOT_DEV`):
   1. Make: `n`, #: `enter`, First Sector: `enter`, Last Sector: `enter`, Signature: `Y`
7. Write: `w`

### Format & Mount

1. Format EFI: `mkfs.fat -F32 EFI_DEV`
2. Prep Encrypted Portion:

```
cryptsetup luksFormat ROOT_DEV
cryptsetup open ROOT_DEV cryptlvm
pvcreate /dev/mapper/cryptlvm
vgcreate lg /dev/mapper/cryptlvm
lvcreate -L 40G lg -n swap
lvcreate -L 80G lg -n root
lvcreate -l 100%FREE lg -n home   #note lowercase l
mkfs.btrfs /dev/lg/root
mkfs.btrfs /dev/lg/home
mkswap /dev/lg/swap
mount /dev/lg/root /mnt
mount --mkdir /dev/lg/home /mnt/home
swapon /dev/lg/swap
```

1. Mount EFI: `mount --mkdir EFI_DEV /mnt/boot`

### Install Essentials

```
pacstrap -i /mnt base base-devel linux linux-firmware grub networkmanager cryptsetup lvm2 neovim vim efibootmgr intel-ucode sof-firmware linux-headers
```

### Configure System

1. Generate `fstab` File: `genfstab -U /mnt >> /mnt/etc/fstab`
2. Root into New System: `arch-chroot /mnt bash`
3. Set Time Zone:

```
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
```

1. Check Time: `ls -l /etc/localtime`
2. Sync Hardware Clock: `hwclock --systohc`

### Localization

1. Edit `/etc/locale.conf` and add

```
export LANG="en_US.UTF-8"
export LC_COLLATE="C"
```

1. Edit `/etc/locale.gen` and uncomment `en_US.UTF-8 UTF-8`
2. Generate Locales: `locale-gen`

### Network Config

1. Set Hostname: `echo "HOSTNAME" > /etc/hostname`

### Root & Users

1. Disable Root Login: `passwd -l root`
2. Create User:

```
useradd -m -G wheel USERNAME
passwd USERNAME
EDITOR=nvim visudo
```

1. Commend out the line at the bottom `%wheel ALL=(ALL) ALL`. Save and quit.

### Keep Boot Messages ([source](https://wiki.archlinux.org/title/Getty#Have_boot_messages_stay_on_tty1))

1. Edit `/etc/systemd/system/getty@tty1.service.d/noclear.conf`:

```
[Service]
TTYVTDisallocate=no
```

### Remove Nouveau Drivers

My laptop has serious issues with Nouveau so this is instructions on how to remove them.

1. Edit `/etc/modprobe.d/nouveau_blacklist.conf`

```
blacklist nouveau
options nouveau modeset=0
```

1. After reboot check with `lsmod | grep nouveau`

### Initramfs

1. Add `microcode`, `encrypt`, and `lvm2` to `/etc/mkinitcpio.conf` such that:

```
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)
```

1. Regenerate Initramfs: `mkinitcpio -p linux`

### Configure GRUB

1. Make sure you are in chroot
2. Save Device UUIDs: `lsblk -f >> /etc/default/grub` (may need `blkid`)
3. Edit `/etc/default/grub`
   1. Remove output of step #2 but copy the UUID of the encrypted partition called `crypto_LUKS` (`ENCRYPTED_UUID_HERE`) and UUID of the decrypted ==root== partition called `btrfs` (`DECRYPTED_ROOT_UUID_HERE`) and put into:

```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet cryptdevice=UUID=ENCRYPTED_UUID_HERE:cryptlvm root=UUID=DECRYPT_UUID_HERE"
GRUB_CMDLINE_LINUX=""
```

1. Install GRUB:

```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```

1. Make Config: `grub-mkconfig -o /boot/grub/grub.cfg`

### Reboot

1. Exit chroot: `exit`
2. Reboot: `reboot`

### Reconnect to WiFi (Optional)

1. Enable: `sudo systemctl enable --now NetworkManager.service`
2. Connect to Existing:

```
sudo nmcli con up "ssid" --ask
```

1. Connect to New:

```
nmcli device wifi list
sudo nmcli dev wifi con "SSID" --ask
```

### Enable Pacman Parallel Downloads

1. Edit `/etc/pacman.conf` and uncomment `ParallelDownloads`

## 2\. Setup

### Packages, Dotfiles, and GUI

1. Install Packages (See \[\[Arch Packages\]\])
2. Get dotfiles from a flashdrive copy of NextCloud
3. Set Shell to Zsh: `chsh -s /bin/zsh`
4. Make Executable `chmod +x ~/.xinitrc`
5. Run `startx`

### Yay

1. Install

```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

1. Install packages \[\[Arch Packages\]\]

### NVIDIA Drivers

1. [Enable Multilib](https://wiki.archlinux.org/title/Multilib)
   1. Edit `/etc/pacman.conf` and uncomment `[multilib]`
2. Install `pacman -S nvidia nvidia-utils nvidia-settings lib32-nvidia-utils`
3. Edit `/etc/default/grub` add `nvidia-drm.modeset=1` to `GRUB_CMDLINE_LINUX_DEFAULT` in
4. Update GRUB Config `grub-mkconfig -o /boot/grub/grub.cfg`
5. Edit `/etc/mkinitcpio.conf`
   1. Add `nvidia`, `nvidia_modeset`, `nvidia_uvm`, `nvidia_drm` to `MODULES`
   2. Remove `kms` from `HOOKS`
6. Regenerate Initramsfs `mkinitcpio -P`

### GitHub Authentication

1. `gh auth login`

### Emojis

1. Copy `~/.config/fontconfig/fonts.conf`

### Trackpad

1. Copy `/etc/X11/xorg.conf.d/30-touchpad.conf`

### DNS

1. Copy `/etc/unbound/unbound.conf`
2. Copy `/etc/resolvconf.conf`
3. Resolv: `sudo resolvconf -u`
4. Setup: `sudo unbound-control-setup`
5. Start and Enable `sudo systemctl enable --now unbound.service`

### Firewall

1. Copy `/etc/nftables.conf`
2. Enable `sudo systemctl enable --now nftables`

### Power Management

1. Enable `thermald`: `sudo systemctl enable --now thermald`

### XSecureLock

1. Copy `xsecurelock` to `/usr/lib/systemd/system-sleep/`
2. Make executable with `chmod +x`

### Microcode

1. Edit `/etc/default/grub`, add `intel_ucode.img` to `GRUB_CMDLINE_LINUX_DEFAULT`
2. Regenerate Config: `sudo grub-mkconfig -o /boot/grub/grub.cfg`
3. Verify after reboot with: `dmesg | grep microcode`

### Auto Login

1. Edit `sudo systemctl edit getty@tty1.service` (at top of file):

```
[Service]
TTYVTDisallocate=no
ExecStart=
ExecStart=-/usr/bin/agetty --autologin <username> --noclear %I $TERM
```

### Dark Mode

```
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
```