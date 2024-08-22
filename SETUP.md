# Liam's Arch Setup Instructions

## 1\. Install

### Increase Font 👴 (Optional)

1. `setfont iso01-12x22.psfu.gz`

### Connect to WiFi 📶 (Optional)

```bash
iwctl
device list
station YOURDEVICE connect YOURSSID
quit
```

### Internet 🌐

1. Verify: `ping cloudflare.com`

### Installer
\#plzdontcallmeasoydev

Alternatives see [Manual Instructions](SETUP_MANUAL.md)

1. Run `archinstall`
```bash
Mirros: United States
Disk Config: btrfs, defaults
Disk Encryption: of course
Bootloader: Systemd-boot :)
Root PW: none (disables)
Profile: ?
Audio: ?
Additional Packages: neovim base-devel zsh...
Network Config: NetworkManager
Timezone: New_York
Optional Repos: multilib
Select Nvidia Prop drivers (wherever it is)
```
2. `exit` and `reboot`

## 2\. Setup

### Reconnect to WiFi (Optional)

```bash
sudo systemctl enable --now NetworkManager.service
sudo nmcli con up "ssid" --ask
```

### Packages, Dotfiles, & Desktop 📦

```bash
nvim /etc/pacman.conf  # uncomment `ParallelDownloads`

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
sudo rm -rf paru

paru -S  # packages from PACKAGES.md
chsh -s /bin/zsh

setxkbmap -option caps:ctrl_modifier
```

### Syncthing

```bash
sudo systemctl enable --now syncthing@liams.service
# open https://localhost:8384
# enter computer code for server
ssh -L 8384:localhost:8384 user@server_ip
# open https://localhost:8385
# enter computer code
# share default folder
# accept share on 8384
# wait until sync is complete
stow XXX # copy stow command from Sync/.zshrc
cd Sync/Arch/arch-priv
./linked.sh
cd ~
startx
```

### NVIDIA Drivers

```bash
paru -S nvidia nvidia-utils nvidia-settings lib32-nvidia-utils
vs /boot/loader/entires/X.conf  # add `nvidia-drm.modeset=1`
vs /etc/mkinitcpio.conf
# MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
# HOOKS=(*REMOVE `kms`*)
sudo mkinitcpio -P
```

### Git

```bash
gh auth login
```

```bash
gpg --list-secret-keys --keyid-format LONG mail@liamsnow.com
git config --global user.signingKey KEY
git config --global commit.gpgsign true  #auto sign
git config --global gpg.program gpg2
```


### Network

```bash
sc enable --now tailscaled
sudo tailscale up
sudo resolvconf -u
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw enable
sudo ufw status verbose
```

### Power Management

```bash
sudo systemctl enable --now thermald
sudo ptop  # enable recommended
```

### Microcode

TOOD

### Pipewire

This should have been done by `archinstall` if you
used it.

```bash
paru -S pipewire pipewire-alsa pipewire-pulse pipewire-media-session
systemctl --user --now enable pipewire pipewire-pulse pipewire-media-session
```

### Yubikey

The propery PAM files should be copied from `arch-priv`

TODO gnome-keyring and polkit-gnome

```bash
pamu2fcfg > ~/.config/Yubico/u2f_keys
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
```

TODO SSH:
```bash
gpg-agent --daemon --enable-ssh-support --write-env-file ~/.gpg-agent-info
```
