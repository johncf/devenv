#!/bin/bash

set -e

if [ "$1" == "--help" ]; then
    echo "Usage: ./install.sh [--no-x]"
    echo "  --no-x   Ignore X related configuration"
    echo "           Note: Fonts are not downloaded."
    exit
fi

SCR_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $HOME
ln -s $SCR_DIR/zshrc .zshrc
echo "linked ~/.zshrc"
ln -s $SCR_DIR/zsh .zsh
echo "linked ~/.zsh"
ln -s $SCR_DIR/gitconfig .gitconfig
echo "linked ~/.gitconfig"
mkdir -p .config .nvim
echo "dirs ~/.{config,nvim}"

ln -s $SCR_DIR/nvim/fallback_vimrc .vimrc
echo "linked ~/.vimrc"
ln -s .nvim .vim
echo "linked ~/.vim to ~/.nvim"

cd $HOME/.config
ln -s $SCR_DIR/config/pystartup ./
echo "linked $(pwd)/pystartup"

cd $HOME/.nvim
ln -s $SCR_DIR/nvim/colors ./
echo "linked $(pwd)/colors"
ln -s $SCR_DIR/nvim/plugin ./
echo "linked $(pwd)/plugin"
ln -s $SCR_DIR/nvim/nvimrc ./
echo "linked $(pwd)/nvimrc"
mkdir -p swps undos
echo "dirs $(pwd)/{swps,undos}"

echo $'\n# Get vim-plug'
plug=$(head -5 $SCR_DIR/nvim/nvimrc | tail -3 | cut -c 5-)
echo "$plug"$'\n'
echo "$plug" | bash

if [ "$1" != "--no-x" ]; then
    ln -s $SCR_DIR/Xdefaults $HOME/.Xdefaults
    echo "linked $HOME/.Xdefaults"
    ln -s $SCR_DIR/config/Xdefaults.d $HOME/.config/Xdefaults.d
    echo "linked $HOME/.config/Xdefaults.d"

    echo $'\n# Get fonts'
    font=$(head -11 $SCR_DIR/config/Xdefaults.d/urxvt | tail -8 | cut -c 3-)
    echo "$font"$'\n'
    echo "$font" | bash
fi

echo $'\n Completed!\nDon't forget to install libotf'
