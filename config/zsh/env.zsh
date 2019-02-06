alias aur='aurget'
alias calc='noglob _calc'
alias cp='cp --reflink=auto'
alias ll='exa -l --git'
#alias ll='ls -lAh'
alias ls='exa'
#alias ls='ls --color'
alias pac='pacman'
alias rg='rg --sort-files'
alias spac='sudo pacman'
alias tm='tmux'
alias tree='exa -lTL2'
alias tree3='exa -lTL3'

#export TERM=xterm-256color
export CARGO_HOME=${HOME}/.cache/cargo
export EDITOR='vim'
export PATH=$PATH:${HOME}/.local/bin:${CARGO_HOME}/bin
export PYTHONSTARTUP=${HOME}/.config/pystartup
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
VIRTUAL_ENV_DISABLE_PROMPT=1
