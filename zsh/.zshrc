export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="passion"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# fzf history search — exact match, chronological order
FZF_CTRL_R_OPTS="--exact --extended --no-sort"
fzf-history-widget() {
  BUFFER=$(fc -rl 1 | fzf +s | sed 's/ *[0-9]* *//')
  CURSOR=${#BUFFER}
  zle reset-prompt
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
