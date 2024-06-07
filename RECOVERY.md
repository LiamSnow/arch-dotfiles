## Liam's Arch Recovery Manual

If you're reading this it means your day has been
going great :)

[Necessary Readings/Motivation](https://wiki.archlinux.org/title/Arch_is_the_best)

### 1
Insert Arch Installer USB Drive and boot into it

### 2

```
fdisk -l  # find LUKS volume (prob. `/dev/nvmeXn1p2`)
cryptsetup open /dev/LUKS cryptlvm
mount /dev/lg/root /mnt     # logical volumes may be called something else (ie not lg) -- I think lvs lists them
mount --mkdir /dev/lg/home /mnt/home   # optional
mount --mkdir /dev/EFI /mnt/boot  # optional but required for mkinitcpio stuff
```

### 3

```
arch-chroot /mnt zsh   # :)
```

Fix the boot issues, then `exit` chroot and `reboot`.

Hell yeah!!! 🐎🏇

### 4

Flex that you use Arch Linux.
