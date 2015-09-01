#!/bin/bash

set -e

function _symlink {
    if [ "$#" != 2 ]; then
        echo "Bad call to _symlink"
        echo "Expected exactly 2 arguments, got $#"
        echo "Exiting..."
        exit
    fi
    [ -e "$2" ] && echo "Path exists; ignoring $2" || (ln -s "$1" "$2" && echo "Linked $2")
}

if [ "$1" == "--help" ]; then
    echo "Usage: ./install.sh [--no-x]"
    echo "  --no-x   Ignore X related configuration"
    echo "           Note: Fonts are not downloaded."
    exit
fi

SCR_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p $HOME/{.config,.nvim}
echo "dirs ~/{.config,.nvim}"

mkdir -p $HOME/.nvim/{swps,undos}
echo "dirs ~/.nvim/{swps,undos}"

mkdir -p $HOME/.cache/zsh
echo "dirs ~/.cache/zsh"

_symlink $SCR_DIR/zshrc $HOME/.zshrc
_symlink $SCR_DIR/zsh $HOME/.zsh
_symlink $SCR_DIR/gitconfig $HOME/.gitconfig

_symlink $SCR_DIR/nvim/colors $HOME/.nvim/colors
_symlink $SCR_DIR/nvim/plugin $HOME/.nvim/plugin
_symlink $SCR_DIR/nvim/nvimrc $HOME/.nvim/nvimrc
_symlink $SCR_DIR/nvim/fallback_vimrc $HOME/.vimrc
_symlink $HOME/.nvim $HOME/.vim

_symlink $SCR_DIR/config/pystartup $HOME/.config/pystartup

plug=$(sed -n '/^" # vim-plug.*{{{$/,/^" # }}}/p' $SCR_DIR/nvim/nvimrc | cut -c 3-)
echo -e "\n$plug\n"
bash <<<$plug

if [ "$1" != "--no-x" ]; then
    _symlink $SCR_DIR/config/Xresources.d $HOME/.config/Xresources.d
    if ! [ -e $HOME/.Xresources ]; then
        sed "s:\${HOME}:$HOME:" $SCR_DIR/Xresources > $HOME/.Xresources
        echo "Created $HOME/.Xresources"
    else
        echo "Path exists; ignoring $HOME/.Xresources"
    fi

    font=$(sed -n '/^! # Fonts.*{{{$/,/^! # }}}/p' $SCR_DIR/config/Xresources.d/urxvt | cut -c 3-)
    echo -e "\n$font\n"
    bash <<<$font
fi

echo $'\n# Completed!'
