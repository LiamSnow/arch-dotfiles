source "~/.config/nushell/keybindings.nu"
source ~/.config/nushell/zoxide.nu
use '/home/liams/.config/broot/launcher/nushell/br' *

alias v = nvim
alias h = helix
# alias hx = helix
alias vh = nvim .
alias hh = helix .
alias vs = sudoedit

alias sc = sudo systemctl
alias gs = git status
alias sto = stow --dir=/home/liams/Sync/Arch --target=/home/liams .
alias bri = ddcutil setvcp 10
alias pip = env/bin/pip

alias wc = nmcli dev wifi con
alias wu = nmcli con up
alias wd = nmcli con down
alias wl = nmcli dev wifi list
alias wr = nmcli dev wifi list --rescan yes

alias s = cd ~/Sync/
alias sch = cd ~/Sync/School
alias cw = cd ~/Sync/Classwork
alias a = cd ~/Sync/Arch
alias pack = v ~/Sync/Arch/PACKAGES.md
alias setup = v ~/Sync/Arch/SETUP.md
alias c = cd ~/Sync/Code
alias d = cd ~/Downloads
alias nvc = cd ~/.config/nvim
alias hyp = cd ~/.config/hypr

def hg [pattern] {
    history | where command =~ $pattern
}

def gn [] {
    home crib off
    ddcutil setvcp d6 4
    shutdown now
}

def en [node = ""] {
    sudo tailscale set $"--exit-node=($node)"
}

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}
