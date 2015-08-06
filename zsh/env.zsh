alias ls='ls --color'
alias ll='ls -lAh'
alias cp="cp --reflink=auto"
[ -z "$NVIM_LISTEN_ADDRESS" ] || alias :="${HOME}/.local/bin/nvimex.py"

#export TERM=xterm-256color
export EDITOR='nvim'
export PATH=$PATH:${HOME}/.local/bin
export PYTHONSTARTUP=${HOME}/.config/pystartup
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export NVIM_PYTHON_LOG_FILE=${HOME}/.cache/nvlogs/py

# shell-local
HISTSIZE=1024
SAVEHIST=2048
HISTFILE=${HOME}/.cache/zsh/history
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # doesn't include '/'
_Z_DATA=${HOME}/.cache/z
