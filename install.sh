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
    echo "Usage: ./install.sh [--no-x | --no-ff | --help]"
    echo "  --no-x   Ignore X related configurations"
    echo "           Note: Skips fonts download and firefox config too."
    echo "  --no-ff  Ignore Firefox configurations"
    echo "  --help   Display this message"
    exit
fi

SCR_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p $HOME/{.config,.nvim}
echo "Directory ~/{.config,.nvim}"

mkdir -p $HOME/.nvim/{swps,undos}
echo "Directory ~/.nvim/{swps,undos}"

mkdir -p $HOME/.cache/zsh
echo "Directory ~/.cache/zsh"

mkdir -p $HOME/.local/bin
echo "Directory ~/.local/bin"

_symlink $SCR_DIR/zshrc $HOME/.zshrc
_symlink $SCR_DIR/zsh $HOME/.zsh
_symlink $SCR_DIR/gitconfig $HOME/.gitconfig
_symlink $SCR_DIR/tmux.conf $HOME/.tmux.conf
_symlink $SCR_DIR/local/bin/tmux-preswitch.sh $HOME/.local/bin/tmux-preswitch.sh

_symlink $SCR_DIR/nvim/colors $HOME/.nvim/colors
_symlink $SCR_DIR/nvim/plugin $HOME/.nvim/plugin
_symlink $SCR_DIR/nvim/nvimrc $HOME/.nvim/nvimrc
_symlink $SCR_DIR/nvim/fallback_vimrc $HOME/.vimrc
_symlink $HOME/.nvim $HOME/.vim

_symlink $SCR_DIR/config/pystartup $HOME/.config/pystartup

plug=$(sed -n '/^" # vim-plug.*{{{$/,/^" # }}}/p' $SCR_DIR/nvim/nvimrc | cut -c 3-)
echo -e "\n$plug\n"
bash <<<"$plug"
echo

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
    bash <<<"$font"
    echo

    if [ "$1" != "--no-ff" ]; then
        ffpath=`echo $HOME/.mozilla/firefox/*.default`
        mkdir -p $ffpath/chrome
        echo "Directory $ffpath/chrome"
        _symlink $SCR_DIR/mozilla/firefox/_.default/chrome/userChrome.css $ffpath/chrome/userChrome.css
    fi
fi

echo $'\n# Completed!'
