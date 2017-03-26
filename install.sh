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

mkdir -p $HOME/.config/nvim
echo ":: Directory ~/.config/nvim"

mkdir -p $HOME/.cache/nvim/{swps,undos,logs}
echo ":: Directory ~/.cache/nvim/{swps,undos,logs}"

_symlink config/nvim/base
_symlink config/nvim/colors
_symlink config/nvim/autoload
_symlink config/nvim/init.vim
_symlink "$SCR_DIR/config/nvim/fallback.vim" $HOME/.vimrc
_symlink $HOME/.config/nvim $HOME/.vim

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
_symlink local/bin/rand-wall.sh # requires feh

_symlink config/i3
_symlink config/dunst

if ! [ -e $HOME/.config/machine ]; then
    cp "$SCR_DIR/config/machine.template" $HOME/.config/machine
    echo ":: Created from template: ~/.config/machine"
else
    echo ":: Path exists; ignoring ~/.config/machine"
fi

# ~/.Xresources
if ! [ -e $HOME/.Xresources ]; then
    sed "s:\${HOME}:$HOME:" "$SCR_DIR/Xresources.template" > $HOME/.Xresources
    echo ":: Created from template: ~/.Xresources"
else
    echo ":: Path exists; ignoring ~/.Xresources"
fi
_symlink config/Xresources.d

mkdir -p $HOME/.local/share/applications
mkdir -p $HOME/.local/share/fonts
mkdir -p $HOME/.local/share/icons/hicolor/scalable/apps
echo ":: Directory ~/.local/share/{applications,fonts,icons/...}"

if [ "$1" != "--full" ]; then
    echo $'\n:: Skipping downloads! Done!'
    exit
fi

curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs \
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Fonts (requires libotf)
curl -fLo ~/.local/share/fonts/MonacoB.otf \
    https://raw.githubusercontent.com/vjpr/monaco-bold/master/MonacoB/MonacoB.otf
curl -fLo ~/.local/share/fonts/MonacoB-Bold.otf \
    https://raw.githubusercontent.com/vjpr/monaco-bold/master/MonacoB/MonacoB-Bold.otf
curl -fLo ~/.local/share/fonts/FontAwesome.otf \
    https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/fonts/FontAwesome.otf
fc-cache -vf
echo

echo $'\n:: Done!'
