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

# snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# load completions
autoload -U compinit && compinit
zinit cdreplay -q

# keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# fzf
eval "$(fzf --zsh)"

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

# path
path+=('/home/liams/.cargo/bin')
export PATH

# enviornment
export EDITOR=nvim
export BROWSER=brave-beta

# alias
alias v='nvim'
alias vs='sudoedit'
alias y='yazi'
alias sc='sudo systemctl'
alias s='y ~/Sync/'
alias a='y ~/Sync/Arch'
alias hg='history 0 | rg'
alias ls='lsd'
alias nvc='v ~/.config/nvim'
alias zshrc='v ~/.zshrc'
alias sto='stow --dir=/home/liams/Sync/Arch --target=/home/liams .'
alias pack='v ~/Sync/Arch/PACKAGES.md'
alias setup='v ~/Sync/Arch/SETUP.md'
alias shop='todo --config ~/.config/todoman/shopping.py'
alias cal='khal interactive'

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

# 1password-cli
eval "$(op completion zsh)"; compdef _op op

# To customize prompt, run `p10k configure` or edit ~/Sync/Arch/.p10k.zsh.
[[ ! -f ~/Sync/Arch/.p10k.zsh ]] || source ~/Sync/Arch/.p10k.zsh
