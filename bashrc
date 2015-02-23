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
export PS1='\u@\h \[\e[38;5;191m\]\w\n\[\e[38;5;208;1m\]\@ \[\e[1;30m\]\$\[\e[m\] '

export HISTCONTROL=erasedups:ignorespace
export HISTSIZE=768
export HISTFILESIZE=1536
shopt -s histappend

alias uhist='nl ~/.bash_history | sort -k2 -k1nr | uniq -f1 | sort -n | cut -f2'
alias uhist_w='uhist > ~/.bash_uhist; mv ~/.bash_uhist ~/.bash_history'

