#!/bin/bash

function _unlink {
    if [ "$#" != 1 ]; then
        echo "Bad call to _unlink"
        echo "Expected exactly 1 arguments, got $#"
        echo "Exiting..."
        exit
    fi
    [ -L "$1" ] && rm "$1" && echo "Removed symlink $1" || echo "$1 is not a symlink; skipping..."
}

_unlink $HOME/.zshrc
_unlink $HOME/.zsh
_unlink $HOME/.gitconfig

_unlink $HOME/.nvim/colors
_unlink $HOME/.nvim/plugin
_unlink $HOME/.nvim/nvimrc
_unlink $HOME/.vimrc
_unlink $HOME/.vim

_unlink $HOME/.config/pystartup

_unlink $HOME/.Xdefaults
_unlink $HOME/.config/Xdefaults.d
