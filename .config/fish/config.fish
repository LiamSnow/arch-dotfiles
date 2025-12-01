if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vs sudoedit
alias sc 'sudo systemctl'
alias gs 'git status'
alias sto 'stow --dir=/home/liams/Sync/Arch --target=/home/liams .'
alias bri 'ddcutil setvcp 10'
alias pip './env/bin/pip'

alias wc 'nmcli dev wifi con'
alias wu 'nmcli con up'
alias wd 'nmcli con down'
alias wl 'nmcli dev wifi list'
alias wr 'nmcli dev wifi list --rescan yes'

alias s 'cd ~/Sync/'
alias sch 'cd ~/Sync/School'
alias cw 'cd ~/Sync/Classwork'
alias a 'cd ~/Sync/Arch'
alias pack 'v ~/Sync/Arch/PACKAGES.md'
alias setup 'v ~/Sync/Arch/SETUP.md'
alias c 'cd ~/Sync/Code'
alias d 'cd ~/Downloads'
alias nvc 'cd ~/.config/nvim'
alias hyp 'cd ~/.config/hypr'

set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"
set -gx EDITOR hx
set -gx BROWSER zen
set -gx HOSTNAME (uname -n)
set -gx TERM xterm-256color

fish_add_path ~/.cargo/bin
fish_add_path /opt/cuda/bin
fish_add_path ~/.local/bin

zoxide init fish | source
