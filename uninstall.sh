#!/bin/bash

if [ "$1" == "--help" ]; then
    echo "Usage: ./uninstall.sh [--help]"
    echo "           Remove all symlinks."
    echo "  --help   Display this message"
    exit
fi

function _unlink {
    if [ "$#" != 1 ]; then
        echo "Bad call to _unlink"
        echo "Expected exactly 1 arguments, got $#"
        echo "Exiting..."
        exit
    fi
    [ ! -L "$1" ] && echo "Not a symlink; ignoring $1" && return 0
    rm "$1" && echo "Removed symlink $1"
}

_unlink $HOME/.config/vim/base
_unlink $HOME/.config/vim/colors
_unlink $HOME/.config/vim/autoload
_unlink $HOME/.config/vim/init.vim
_unlink $HOME/.vimrc
_unlink $HOME/.vim

_unlink $HOME/.config/zsh
_unlink $HOME/.zshrc

_unlink $HOME/.config/pystartup
_unlink $HOME/.gitconfig
_unlink $HOME/.tmux.conf
_unlink $HOME/.local/bin/tmux-preswitch.sh

echo $'\n:: Done!'
