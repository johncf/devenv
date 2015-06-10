#!/bin/bash

set -e

SCR_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $HOME
ln -s $SCR_DIR/zshrc .zshrc
echo "linked $(pwd)/.zshrc"
ln -s $SCR_DIR/zsh .zsh
echo "linked $(pwd)/.zsh"
ln -s $SCR_DIR/Xdefaults .Xdefaults
echo "linked $(pwd)/.Xdefaults"
ln -s $SCR_DIR/gitconfig .gitconfig
echo "linked $(pwd)/.gitconfig"
mkdir -p .config .nvim .cache/zsh
echo "dirs $(pwd)/.{config,nvim,cache/zsh}"

cd .config
ln -s $SCR_DIR/config/Xdefaults.d ./
echo "linked $(pwd)/Xdefaults.d"
ln -s $SCR_DIR/config/pystartup ./
echo "linked $(pwd)/pystartup"
#cp $SCR_DIR/config/mimeapps.list ./

cd ../.nvim
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

echo $'\n# Get fonts'
font=$(head -11 $SCR_DIR/config/Xdefaults.d/urxvt | tail -8 | cut -c 3-)
echo "$font"$'\n'
echo "$font" | bash

echo $'\n Completed!\nInstall libotf manually.'
