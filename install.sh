#!/bin/bash

set -e

SCR_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ "$1" == "--help" ]; then
    echo "Usage: ./install.sh [--help | --full]"
    echo "           Create symlinks to configuration files."
    echo "  --full   Also download fonts and vim-plug."
    echo "  --help   Display this message"
    exit
fi

function _symlink {
    if [ "$#" == 1 ]; then
        src="$SCR_DIR/$1"
        link="$HOME/.$1"
    elif [ "$#" == 2 ]; then
        src="$1"
        link="$2"
    else
        echo "Bad call to _symlink"
        echo "Expected 1 or 2 arguments, got $#"
        echo "Exiting..."
        exit
    fi
    [ -e "$link" ] && echo ":: Path exists; ignoring $link" || \
        (ln -s "$src" "$link" && echo ":: Linked $link")
}

mkdir -p $HOME/.config/vim
echo ":: Directory ~/.config/vim"

mkdir -p $HOME/.cache/vim/{swps,undos,logs}
echo ":: Directory ~/.cache/vim/{swps,undos,logs}"

_symlink config/vim/base
_symlink config/vim/colors
_symlink config/vim/autoload
_symlink config/vim/init.vim
_symlink "$SCR_DIR/config/vim/rc.vim" $HOME/.vimrc
_symlink $HOME/.config/vim $HOME/.vim

_symlink zshrc
_symlink config/zsh

mkdir -p $HOME/.cache/zsh
echo ":: Directory ~/.cache/zsh"
git submodule init
git submodule update

_symlink config/pystartup
_symlink gitconfig
_symlink tmux.conf

mkdir -p $HOME/.local/bin
echo ":: Directory ~/.local/bin"
_symlink local/bin/tmux-preswitch.sh

curl -fLo "$HOME/.config/vim/autoload/plug.vim" --create-dirs \
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo $'\n:: Done!'
