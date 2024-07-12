# Liam's Arch Dotfiles 🏄🏽

## Reasoning

I switched to Linux because I was fed up with developing
on Windows and in my opinion WSL, while an awesome tool,
is not a proper solution.
I find that a lot of people, including myself, justify
using Windows because its an easy operating system
that just works - but it really isn't. Windows
makes you jump through so many hoops to change simple
settings. Not to mention it has two complete settings
menus (Control Panel and Windows 10 Settings) that
function differently. Even as a Windows power user
for many years, I found myself having to look up
things online all the time.


I tried a few other Linux distros but really just fell
in love with Arch and it's DIY style. It took a lot of time
to setup and make just how I wanted, but now I have
an OS (almost) exactly how I want it that just works.
I can easily solve issues I come across, because I
chose and setup most of the tools/programs.
I would also argue that Arch is just worth it for
how awesome Pacman is, especially compared to other
package managers.

## Setup

Xorg + I3 (no desktop manager)

(Currently waiting for NVIDIA 560 drivers to use Wayland + Hyprland)

### Desktop [I3](.config/i3) with [I3Status-Rust](.config/i3status-rust) and [Picom](.config/picom)

- MacOS aesthetic with transparent blurred terminals
- Separate customization for Desktop & Laptop
- Audio controls, screenshot tool, emoji picker
- xsecurelock for locking (works with my Yubikey PAM auth)
- Vim keybinds + other modifications

### Editor [Neovim](https://github.com/LiamSnow/nvim-config)

- See [nvim-config](https://github.com/LiamSnow/nvim-config)

### CalDAV [khal](.config/khal) and [todoman](.config/todoman)

- My `.calendar` folder is synced to my home server which is synced to my CalDAV server (via vdirsyncer). This means I can use my contacts, reminders, and my calendars between my computers and phone.
- Todoman is a lightweight CLI tools for working with reminders/todos
- Khal is a CLI/TUI tool for working with my calendars.
  - Interactive (TUI) mode allows for regular calendar use (but with keybinds)
  - The CLI tools allows searching for events, listing events between a timespan, and more. This is awesome feature that comes in handy more than you would think.

### Terminal [kitty](.config/kitty) and [Zsh](.zshrc)

- Powerlevel10K minimal prompt
- ZInit for small extensions (tweaks & great autocomplete)
- Many aliases for productivity (ex. `sc` for `sudo systemctl`)

### File Explorer [yazi](.config/yazi)

- TUI file explorer written in Rust (similar to Ranger)
- Its fast and has good Vim-like keybinds
- I could not imagine going back to a GUI file explorer

