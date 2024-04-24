# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

CASE_SENSITIVE="false"

bindkey -e
zstyle :compinstall filename '/home/liams/.zshrc'

autoload -Uz compinit
compinit

# options
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

setopt CDABLE_VARS
setopt PROMPT_SUBST
setopt CORRECT
setopt GLOBDOTS

# dotfile alias
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# starship
eval "$(starship init zsh)"
