# Liam's Arch Setup Instructions

## 1\. Install

### Increase Font (Optional)

1. `setfont iso01-12x22.psfu.gz`

### Connect to WiFi (Optional)

1. `iwctl`
2. `device list`
3. `station YOURDEVICE connect YOURSSID`
4. `quit`

### Internet

1. Verify: `ping cloudflare.com`

### Installer
#plzdontcallmeasoydev

Alternatives see [Manual Instructions](SETUP_MANUAL.md)

1. Run `archinstall`
```
Mirros: United States
Disk Config: btrfs, defaults
Disk Encryption: of course
Bootloader: Systemd-boot :)
Root PW: none (disables)
Profile: ?
Audio: ?
Additional Packages: neovim base-devel...
Network Config: NetworkManager
Timezone: New_York
Optional Repos: multilib
Select Nvidia Prop drivers (wherever it is)
```
2. Exit and reboot

### Reconnect to WiFi (Optional)

1. Enable `sudo systemctl enable --now NetworkManager.service`
2. Connect `sudo nmcli con up "ssid" --ask`

### Enable Pacman Parallel Downloads

1. Edit `/etc/pacman.conf` and uncomment `ParallelDownloads`

## 2\. Setup

### Packages, Dotfiles, and GUI

1. Install Paru:
```
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```
2. Install PACKAGES.md

### Syncthing

1. Start `sudo systemctl enable --now syncthing@liams.service`
2. Open `https://localhost:8384`
3. Add Server Code
4. Open Server `ssh -L 8384:localhost:8384 username@server_ip`, then `https://localhost:8385`, then share default folder
4. Run Stow
5. Set Shell to Zsh: `chsh -s /bin/zsh`
6. Run `linker.sh`
7. Start `startx`

### NVIDIA Drivers

1. Install `nvidia nvidia-utils nvidia-settings lib32-nvidia-utils`
2. Edit `/boot/loader/entires/X.conf` add `nvidia-drm.modeset=1`
3. Edit `/etc/mkinitcpio.conf`
```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
HOOKS=(*REMOVE `kms`*)
```
4. Regenerate Initramsfs `mkinitcpio -P`

### GitHub Authentication

1. `gh auth login`


### Network
```
sc enable --now tailscaled
sudo tailscale up
sudo resolvconf -u
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw enable
sudo ufw status --verbose
```

### Power Management

1. Enable: `sudo systemctl enable --now thermald`
2. Enable Recs in Powertop

### Microcode

TOOD

### Pipewire

TODO
```
systemctl --user --now enable pipewire pipewire-pulse wireplumber
```

### Yubikey

```
pamu2fcfg > ~/.config/Yubico/u2f_keys
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
```

