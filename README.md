# Liam's Arch Dotfiles 🏄🏽

I use Arch btw. Yes I suck at writing, sorry if this is hard to read.

## Backstory/Reasoning

TL;DR MacOS sucks, Windows is worse, most Linux distros are better,
but operating systems are better in the terminal so just use Arch
without a desktop enviornment. Use a tiling window manager
and replace VSCode/JetBrains with Neovim so you look like a cool
hacker man and maybe increase productivity.

 > "Linux isn't hard, operating systems are"

I grew up using MacOS (~2010-2017) and was genuinely pretty
happy with - although I didn't do much besides use a web
browser. I was always very frustrated with how little I could customize
and the fact that most games couldn't run on it.
Eventually I made a PC which meant I was using Windows 10.
Initially I kinda hated it, but over time I learned how
do everything and honestly really enjoyed it (after
removing all the Microsoft bloat -- Why is it actually
so difficult to uninstall Edge and Cortana?).

I would commonly run into issues trying to code on Windows.
I honestly thought this was an issues with programs themselves
and not Windows - but its just Windows. Setting up Java
on a new system was stupidly hard for no reason. In no other operating
system is that common to run another OS inside
it. Like I respect WSL and once I learned how to use it
I loved it, but how did it get the point that coding in Windows
sucks so much that they just accepted defeat and made WSL?

After using Linux enough, I just figured why
not just completely switch to Linux. I think a big turning point
for me was when I having a conversation with a friend and we
debated Windows vs. Linux as a desktop, and I don't remember
exactly how it came but basically he said that Windows isn't
easy or intuitive to use - you've just used it for so long
that is obvious what to do, but why the hell do you have
to open 5 different settings menu to change a Network Setting?
How are we on Windows 11 now and they still havn't managed
to put everything from Windows 7 Control Panel into their
Windows 10 settings menu?? What other operator system
has 2 completely different settings menus that mostly
cover the same features?

Another major factor that brought me to Linux was Vim. I have
always envied people who were good at Vim. It so fast
and just looks awesome. I had had two big attempts to learn
Vim, but the steep learning curve always turned me away.
After watching enough of the ThePrimagen, I knew I just had
to it. So, I turned Vim mode on in VSCode and Obsidian and
started to get the hang of it. After a about 2 weeks I got
fed up with both of them and decided to start using Neovim
in the terminal. Long story short, it made me start to hate
Windows and I just wanted to use the terminal for everything
and have all my files in Linux. So, I finally made the jump.

I researched some distros and eventually decides to install
Fedora. Installing Fedora was honestly an amazing and a seamless
experience. For new users, I would highly recommend. It launched
me into Gnome - something I totally unfamiliar with. I really
wasn't a fan. I mean it looked good, but the settings menu
was so lacking and didn't really like the controls (why
can you not set hotkeys for desktops?).
I installed I3 in Fedora but was
frustrated enough with Gnome and decided to install Debian with KDE and I3.
It was better, but I just soon realized I really hated all
the bloat these desktop enviornments came with. All I wanted
was I3 with a terminal and browser. So, I installed Debian
with XFCE4 and I3. It was a lot better, but honestly I was
just poking a dead horse at this point and just was looking
for an excuse to install Arch. There's just something that
was so appealing to me about Arch. You're system is exactly what
you tell it to be, and nothing more. Its your operating system.

Now, I wouldn't go so far to recommend Arch to most people.
It took a significant
amount of time to learn and setup. For me, that was fun, I loved
the process of scouring the Arch wiki learning about how to
setup firewalls and disk encryption. If that doesn't sound found
don't use Arch.

Now after using Arch for a
significant amount of time on 3 machines, I can confidently say
it is my favorite OS. Everything I want to do is with a few
key presses. You want to edit DNS? Ok, `vs /etc/resolvconf.conf`.
You want to edit a file? Ok, `v FILENAME`. Everything is
snappy and instant too. No waiting for my massive JetBrains IDE
to launch, Neovim launches nearly instantly. Not only
that, tiling window managers are actually just amazing and have
increased my productivity and desktop experience significantly.
I really don't have to use a mouse for anything except the web
browser (I don't really like Vim browser extensions and sadly
qutebrowser and nyxt do not have the extension support I need).

Using Arch, I feel in tune with my operating system. I know
how to manage nearly everything on it, because it installed
nearly everything on it. Also, pacman (& paru) is just an
amazing package manager. Come from Windows without a package
manager it is a breath of fresh air (& not more 20 minute
Updates every other night :)). I learned so much from
setting up Arch, that I was able to easily spin up a home
server running many services.


## My Setup

Currently running Xorg + I3, but once NVIDIA 560
drivers come out I will promptly switch to Wayland + Hyprland.

__Window Manager [I3](.config/i3)__
Basic semi-decent looking I3 config. Automatically
changes config depending on machine hostname (for
different configs between Laptop and PC).

Added audio controls, screenshot tool, emoji picker,
and xsecurelock lock screen (soo good). Keybinds
are heavily modified for usability/my preferences
(vim keybinds especially), and many added shortcuts.
Dmenu ($mod+D) is used as a backup, most apps can
be launched with a simple mod keybind.

__Editor [Neovim](https://github.com/LiamSnow/nvim-config)__
See README.md in [nvim-config](https://github.com/LiamSnow/nvim-config) repo.

__Status Bar [I3Status-Rust](.config/i3status-rust)__
Lightweight, high performance status bar written in the
best language.

__CalDAV [khal](.config/khal) and [todoman](.config/todoman)__
I run Radicale CalDAV on my home server that syncs files
to `.calendars` over my Tailnet. This allows me to sync
contacts, reminders, and my calendars between my computers
and iPhone (💀).

Then, I use todoman which is nice lightweight CLI tool
that lets me easily view and edit my reminders. I use
Khal which is an awesome CLI tool for working with my
calendars. Honestly, just using Khal has made me use
and like using my calendars so much more.

__Terminal [kitty](.config/kitty) and Shell [Zsh](.zshrc)__
Kitty is an awesome GPU based terminal emulator and lets
me do psuedo transparency.

For Zsh I will Powerlevel10K setup to be minimal
and out of the way. I use Zinit for the package manager
and only have a few extensions mostly just to have
great autocomplete functionality which improves
my terminal speed massively. I also configure a ton
of aliases, so for most common tasks I only need to use
one or two characters (no more typing out `sudo systemctl` :)).

__File Explorer [yazi](.config/yazi)__
Similar to ranger, but written in the best language (making it
blazingly fast!). After using yazi I could not imagine
going back to a GUI file explorer, its the best thing ever.

