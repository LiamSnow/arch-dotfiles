source "~/.config/nushell/keybindings.nu"

alias v = nvim
alias vh = nvim .
alias vs = sudoedit
alias sc = sudo systemctl
alias cb = cd ..
alias gs = git status
alias sto = stow --dir=/home/liams/Sync/Arch --target=/home/liams .
alias bri = ddcutil setvcp 10
alias pdf = evince
alias nc = nmcli dev wifi con
alias nu = nmcli con up
alias nd = nmcli con down
alias nl = nmcli dev wifi list
alias nr = nmcli dev wifi list --rescan yes
alias s = cd ~/Sync/
alias sch = cd ~/Sync/School
alias cw = cd ~/Sync/Classwork
alias a = cd ~/Sync/Arch
alias pack = v ~/Sync/Arch/PACKAGES.md
alias setup = v ~/Sync/Arch/SETUP.md
alias c = cd ~/Sync/Code
alias d = cd ~/Downloads
alias h = cd ~
alias nvc = cd ~/.config/nvim
alias hyp = cd ~/.config/hypr
alias gpd = v -c "PyGPTNew deepseek"
alias gpp = v -c "PyGPTNew perplexity"
alias gppd = v -c "PyGPTNew perplexity_deep"
alias gpo = v -c "PyGPTNew chat"
alias gpa = v -c "PyGPTNew claude_think"
alias gpap = v -c "PyGPTNew claude_think_prompt"
alias gpab = v -c "PyGPTNew claude_basic"
alias t = todo
alias shop = t --config ~/.config/todoman/shopping.py
alias ts = t --config ~/.config/todoman/school.py
alias cal = ikhal
alias pip = env/bin/pip

def hg [pattern] {
    history | where command =~ $pattern
}

def gn [] {
    home crib off
    ddcutil setvcp d6 4
    shutdown now
}

def en [node: string] {
    sudo tailscale set --exit-node=$node
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

source ~/.config/nushell/zoxide.nu

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

$env.config.completions.external = {
    enable: true
    completer: {|spans|
        match $spans.0 {
            z => $zoxide_completer
            _ => { null }
        } | do $in $spans
    }
}
