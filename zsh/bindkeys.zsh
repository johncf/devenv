# Ideas from http://dougblack.io/words/zsh-vi-mode.html
bindkey -v
export KEYTIMEOUT=5 #0.05 seconds

function zle-line-init zle-keymap-select {
    local VIM_STAT VIM_NORMAL PREV_RPROMPT
    VIM_STAT="${KEYMAP/main/}"
    VIM_NORMAL="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%} "
    PREV_RPROMPT="$RPROMPT"
    RPROMPT="${VIM_STAT/vicmd/$VIM_NORMAL}"'$(PR_ERROR)'
    [[ "$RPROMPT" != "$PREV_RPROMPT" ]] && zle && zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

bindkey '\e[3~' delete-char
bindkey '\e[5~' history-search-backward
bindkey '\e[6~' history-search-forward
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Meta+[hjkl]
bindkey '\ej' backward-char
bindkey '\ek' history-beginning-search-forward
bindkey '\eh' history-beginning-search-backward
bindkey '\el' forward-char

bindkey '^?' backward-delete-char
bindkey '^_' undo
bindkey '^H' backward-delete-char
bindkey '^K' kill-line
bindkey "^M" magic-enter
bindkey '^N' down-line-or-history
bindkey '^P' up-line-or-history
bindkey '^R' history-incremental-search-backward
bindkey '^W' backward-kill-word

bindkey -ar 'k'
bindkey -ar 'h'
bindkey -a 'j' backward-char
bindkey -a 'l' forward-char
bindkey -a 'u' undo
bindkey -a '^R' redo
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history
bindkey -a 'g~' vi-oper-swap-case
