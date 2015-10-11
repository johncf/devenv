#
# ~/.bashrc
#

export EDITOR=nvim

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Install package bash-completion

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lAh'
alias cp="cp --reflink=auto"
alias vim='nvim'

export PS1='\[\e[38;5;203m\]\u\[\e[m\]@\[\e[38;5;38m\]\h \[\e[38;5;71m\]\w \n\[\e[38;5;185m\]\@ \[\e[38;5;9m\]\$\[\e[m\] '
export HISTCONTROL=erasedups:ignorespace
export HISTSIZE=768
export HISTFILESIZE=2048
shopt -s histappend

[ -z "$NVIM_LISTEN_ADDRESS" ] || alias :="${HOME}/.local/bin/nvimex.py"
alias uhist='nl ${HISTFILE} | sort -k2 -k1nr | uniq -f1 | sort -n | cut -f2'
alias uhist_w='uhist > /tmp/${USER}_uhist; mv /tmp/${USER}_uhist ${HISTFILE}'

