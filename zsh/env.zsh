alias ls='ls --color'
alias ll='ls -lAh'
alias cp="cp --reflink=auto"
alias calc='noglob calc'
[ -z "$NVIM_LISTEN_ADDRESS" ] || alias :="${HOME}/.local/bin/nvimex.py"

#export TERM=xterm-256color
export EDITOR='nvim'
export PATH=$PATH:${HOME}/.local/bin
export PYTHONSTARTUP=${HOME}/.config/pystartup
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export NVIM_PYTHON_LOG_FILE=${HOME}/.cache/nvlogs/py
export RUST_BACKTRACE=1

# shell-local
HISTSIZE=1024
SAVEHIST=2048
HISTFILE=${HOME}/.cache/zsh/history
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # doesn't include '/'

FASD_INIT_CACHE=${HOME}/.cache/zsh/fasd-init.zsh
_FASD_DATA=${HOME}/.cache/fasd
_FASD_VIMINFO="$HOME/.nviminfo"
