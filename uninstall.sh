#!/bin/bash

function _unlink {
    if [ "$#" != 1 ]; then
        echo "Bad call to _unlink"
        echo "Expected exactly 1 arguments, got $#"
        echo "Exiting..."
        exit
    fi
    [ -L "$1" ] && rm "$1" && echo "Removed symlink $1" || echo "Not a symlink; ignoring $1"
}

_unlink $HOME/.zshrc
_unlink $HOME/.zsh
_unlink $HOME/.gitconfig
_unlink $HOME/.tmux.conf
_unlink $HOME/.local/bin/tmux-preswitch.sh

_unlink $HOME/.nvim/colors
_unlink $HOME/.nvim/plugin
_unlink $HOME/.nvim/nvimrc
_unlink $HOME/.vimrc
_unlink $HOME/.vim

_unlink $HOME/.config/pystartup

_unlink $HOME/.config/Xresources.d
if [ -e $HOME/.Xresources ]; then
    printf "Remove ~/.Xresources [y/N]: "
    read rm_xres
    [ "${rm_xres/Y/y}" == "y" ] && rm $HOME/.Xresources && echo "Removed $HOME/.Xresources"
else
    echo "Path does not exist $HOME/.Xresources"
fi

_unlink $HOME/.mozilla/firefox/*.default/chrome/userChrome.css
