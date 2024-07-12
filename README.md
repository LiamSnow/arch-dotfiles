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

Xorg + I3
(waiting for NVIDIA 560 drivers to use Wayland + Hyprland)

### Desktop [I3](.config/i3) with [I3Status-Rust](.config/i3status-rust) and [Picom](.config/picom)

- MacOS aesthetic with transparent blurred terminals
- Separate customization for Desktop & Laptop
- Audio controls, screenshot tool, emoji picker
- xsecurelock for locking (works with my Yubikey PAM auth)
- Vim keybinds + other modifications

### Editor [Neovim](https://github.com/LiamSnow/nvim-config)

See README in [nvim-config](https://github.com/LiamSnow/nvim-config) repo.

### CalDAV [khal](.config/khal) and [todoman](.config/todoman)

I run Radicale CalDAV on my home server that syncs files to
`.calendars` (via `vdirsyncer` which allows khal and todoman
to view/edit them) over my Tailnet.
This allows me to sync contacts, reminders, and my calendars
between my computers and iPhone.

Todoman is nice lightweight CLI tool
that lets me easily view and edit my reminders. Nothing
too special, but basically exactly what I needed.

Khal is an awesome CLI/TUI tool for working with my
calendars. It has
an interactive/TUI mode to use a calendar just like
any other but with a keyboard forward design. But the
best part is the CLI tool. I can easily search through
all my events, list events for a certain timespan, and
more. Khal has made me love using my calendar, which
means I use it a lot more.

### Terminal [kitty](.config/kitty) and [Zsh](.zshrc)

- Powerlevel10K minimal prompt
- ZInit for small extensions (tweaks & great autocomplete)
- Many aliases for productivity (ex. `sc` for `sudo systemctl`)

### File Explorer [yazi](.config/yazi)

After using yazi I could not imagine
going back to a GUI file explorer, its the best thing ever.
(Similar to ranger, but written in the best language)

