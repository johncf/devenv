bindkey -e

bindkey "^M" magic-enter
bindkey '^R' zaw-history
bindkey '\e[8~' end-of-line
bindkey '\e[7~' beginning-of-line
bindkey '\e[6~' history-search-forward
bindkey '\e[5~' history-search-backward
bindkey '\e[3~' delete-char
bindkey '\ek' up-line-or-history
bindkey '\ej' down-line-or-history
bindkey '\el' forward-char
bindkey '\eh' backward-char

