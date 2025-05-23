## Liam's Arch Setup Manaul

This is an extension of [SETUP.md](SETUP.md) and can replace
the instructions for `archinstall`.

Do not use this directly, always reference the [Arch Wiki Installation Guide](https://wiki.archlinux.org/title/Installation_guide).

### Partition Disk

```bash
fdisk -l
fdisk TARGET_DEVICE
p # print partitions
d # repeat to remove all
n # make EFI partition: # default, first sector: default, last sector: +2G, remove sig: yes
t # change type: 1 (EFI)
n # make LUKS partition: # default, first sector: default, last sector: default, remove sig: yes
w # save changes
```

### Format & Mount

Swap is optional, and replace `EFI` and `LUKS` with values from above.
(ex. `/dev/nvme0n1p1` and `p2`)

```bash
mkfs.fat -F32 /dev/EFI
cryptsetup luksFormat /dev/LUKS
cryptsetup open /dev/LUKS cryptlvm
pvcreate /dev/mapper/cryptlvm
vgcreate lg /dev/mapper/cryptlvm
lvcreate -L 40G lg -n swap
lvcreate -L 80G lg -n root
lvcreate -l 100%FREE lg -n home
mkfs.btrfs /dev/lg/root
mkfs.btrfs /dev/lg/home
mkswap /dev/lg/swap
mount /dev/lg/root /mnt
mount --mkdir /dev/lg/home /mnt/home
swapon /dev/lg/swap
mount --mkdir /dev/EFI /mnt/boot
```

### Install Essentials

```bash
pacstrap -i /mnt base base-devel linux linux-firmware grub networkmanager cryptsetup lvm2 neovim vim efibootmgr intel-ucode sof-firmware linux-headers zsh
```

## Configure System

```bash
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt zsh   # :)
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
nvim /etc/locale.conf # `export LANG="en_US.UTF-8"` and `export LC_COLLATE="C"`
nvim `/etc/locale.gen` # uncomment `en_US.UTF-8 UTF-8`
locale-gen
echo "HOSTNAME" > /etc/hostname
nvim /etc/systemd/system/getty@tty1.service.d/noclear.conf # `[Service]` and `TTYVTDisallocate=no`
nvim /etc/modprobe.d/nouveau_blacklist.conf # `blacklist nouveau` and `options nouveau modeset=0`
nvim /etc/mkinitcpio.conf
# HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)
mkinitcpio -p linux
```

### Users

```bash
passwd -l root # disable root
useradd -m -G wheel USERNAME
passwd USERNAME
EDITOR=nvim visudo # uncomment `%wheel ALL=(ALL) ALL`
```

### Configure GRUB

TODO Switch to Systemd-Boot

```bash
blkid >> /etc/default/grub
nvim /etc/default/grub
# Remove all from `blkid` but copy UUID of `crypto_LUKS` and UUID of decrypted root partition `btrfs` and put below
# GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 cryptdevice=UUID=XXX:cryptlvm root=UUID=XXX"
# GRUB_CMDLINE_LINUX=""
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```
