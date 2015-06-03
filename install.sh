#!/bin/bash

set -e

SCR_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $HOME
ln -s $SCR_DIR/zshrc .zshrc
ln -s $SCR_DIR/zsh .zsh
ln -s $SCR_DIR/Xdefaults .Xdefaults
ln -s $SCR_DIR/gitconfig .gitconfig
mkdir -p .config .nvim .cache/zsh
cd .config
ln -s $SCR_DIR/config/Xdefaults.d ./
ln -s $SCR_DIR/config/pystartup ./
#cp $SCR_DIR/config/mimeapps.list ./
cd ../.nvim
ln -s $SCR_DIR/nvim/colors ./
ln -s $SCR_DIR/nvim/plugin ./
ln -s $SCR_DIR/nvim/nvimrc ./
mkdir swps undos

head -5 $SCR_DIR/nvim/nvimrc | tail -3 | cut -c 5- | bash
head -11 $SCR_DIR/config/Xdefaults.d/urxvt | tail -8 | cut -c 3- | bash
