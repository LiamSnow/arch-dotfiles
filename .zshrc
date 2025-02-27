# gpg
export GPG_TTY="$(tty)"
export PINENTRY_USER_DATA=USE_TTY=1
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
# echo UPDATESTARTUPTTY | gpg-connect-agent > /dev/null


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit
ZINIT_ZSH="/usr/share/zinit/zinit.zsh"
if [[ -r "$ZINIT_ZSH" ]]; then
  source "$ZINIT_ZSH"
fi

# plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

# snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# load completions
autoload -U compinit && compinit
zinit cdreplay -q

# keybindings
bindkey -v
bindkey '^F' autosuggest-accept
bindkey '^[f' forward-word
KEYTIMEOUT=1
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward

#
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
alias zi="__zoxide_zi"

# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# options
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
setopt cdable_vars
setopt prompt_subst
setopt globdots

# completions
eval "$(_KHAL_COMPLETE=zsh_source khal)"

# path
path+=('/home/liams/.cargo/bin')
export PATH

# enviornment
export EDITOR=nvim
export BROWSER=firefox
alias pdf='evince'
export HOSTNAME=$(uname -n)

# alias
alias v='nvim'
alias vh='nvim .'
alias vs='sudoedit'
alias sc='sudo systemctl'
alias ls='lsd'
alias cb='cd ..'
alias gs='git status'
alias hg='history 0 | rg'
alias sto='stow --dir=/home/liams/Sync/Arch --target=/home/liams .'
alias bri='ddcutil setvcp 10'
alias gn='home crib off && ddcutil setvcp d6 4 && shutdown now'
en() {
    sudo tailscale set --exit-node="$1"
}

alias s='cd ~/Sync/'
alias sch='cd ~/Sync/School'
alias cw='cd ~/Sync/Classwork'
alias a='cd ~/Sync/Arch'
alias pack='v ~/Sync/Arch/PACKAGES.md'
alias setup='v ~/Sync/Arch/SETUP.md'
alias c='cd ~/Sync/Code'
alias d='cd ~/Downloads'
alias nvc='cd ~/.config/nvim'
alias hyp='cd ~/.config/hypr'
alias gpd='v -c "PyGPTNew deepseek"'
alias gpp='v -c "PyGPTNew perplexity"'
alias gppd='v -c "PyGPTNew perplexity_deep"'
alias gpo='v -c "PyGPTNew chat"'
alias gpa='v -c "PyGPTNew claude_think"'
alias gpap='v -c "PyGPTNew claude_think_prompt"'
alias gpab='v -c "PyGPTNew claude_basic"'

alias t='todo'
alias shop='t --config ~/.config/todoman/shopping.py'
alias ts='t --config ~/.config/todoman/school.py'
alias cal='ikhal'

alias f1='talosctl -n 192.168.5.101 -e 192.168.5.101'
alias f2='talosctl -n 192.168.5.102 -e 192.168.5.102'
alias f3='talosctl -n 192.168.5.103 -e 192.168.5.101'
alias fa='talosctl -n 192.168.5.101,192.168.5.102,192.168.5.103 -e 192.168.5.101'
alias kc='kubectl'
alias kcg='kubectl get'
alias kcl='kubectl logs'
alias kcd='kubectl delete'

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# pip alias (for virtual enviornments)
alias pip='env/bin/pip'

# To customize prompt, run `p10k configure` or edit ~/Sync/Arch/.p10k.zsh.
[[ ! -f ~/Sync/Arch/.p10k.zsh ]] || source ~/Sync/Arch/.p10k.zsh

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/liams/.dart-cli-completion/zsh-config.zsh ]] && . /home/liams/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

