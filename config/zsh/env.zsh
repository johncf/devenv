alias agg="ag -g"
alias calc='noglob calc'
alias cp="cp --reflink=auto"
alias ll='ls -lAh'
alias ls='ls --color'
alias pac=pacman
alias spac="sudo pacman"
alias saur="aurget"
alias tm='tmux'

#export TERM=xterm-256color
export CARGO_HOME=${HOME}/.cache/cargo
export EDITOR='nvim'
export PATH=$PATH:${HOME}/.local/bin:${CARGO_HOME}/bin
export PYTHONSTARTUP=${HOME}/.config/pystartup
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export NVIM_PYTHON_LOG_FILE=${HOME}/.cache/nvim/logs/py
export RUST_NEW_ERROR_FORMAT=true
export RUSTUP_HOME=${HOME}/.cache/rustup
export RXVT_SOCKET=${HOME}/.local/urxvtd.sock

# shell-local
HISTSIZE=2048
SAVEHIST=32768
HISTFILE=${HOME}/.cache/zsh/history
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # doesn't include '/'

FASD_INIT_CACHE=${HOME}/.cache/zsh/fasd-init.zsh
_FASD_DATA=${HOME}/.cache/fasd
_FASD_VIMINFO="$HOME/.nviminfo"
