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
    local src
    local link
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

function _githubrel {
    local exe="$1"
    local ghinfo="$2"
    local match="$3"
    local rel_ver
    local dl_url
    local tmp_json=/tmp/_ghrel.json
    if which jq >/dev/null; then
        curl -sSL -H "Accept: application/vnd.github+json" \
                  -H "X-GitHub-Api-Version: 2022-11-28" \
            "https://api.github.com/repos/$ghinfo/releases/latest" > $tmp_json
        rel_ver="$(cat $tmp_json | jq -r '.name')"
        dl_url="$(cat $tmp_json | jq -r '.assets[] | .browser_download_url' | grep "$match")"
        case $dl_url in
            *.tar.bz2|*.tbz2)
                _ghrel_untar "$exe" tbz2 "$dl_url" ;;
            *.tar.gz|*.tgz)
                _ghrel_untar "$exe" tgz "$dl_url" ;;
            *.bz2)
                _ghrel_unzip "$exe" bzip2 "$dl_url" ;;
            *.gz)
                _ghrel_unzip "$exe" gzip "$dl_url" ;;
            *) echo "unsupported file type: $dl_url"; return 1 ;;
        esac
        echo ":: $exe $rel_ver installed"
    else
        echo ":: jq not installed; skipping $exe installation"
    fi
}

# helper function to download a github release tar file and extract
function _ghrel_untar {
    local exe="$1"
    local ext="$2"
    local dl_url="$3"
    curl -sSfLo ~/.cache/_ghrel.$ext "$dl_url"
    if grep "^$exe$" <(tar tf ~/.cache/_ghrel.$ext) >/dev/null; then
        tar -C ~/.local/bin -xf ~/.cache/_ghrel.$ext "$exe"
    else
        tar -C ~/.local/bin --wildcards -xf ~/.cache/_ghrel.$ext "**/$exe" --transform='s/.*\///'
    fi
    rm ~/.cache/_ghrel.$ext
}

function _ghrel_unzip {
    local exe="$1"
    local cmd="$2"
    local dl_url="$3"
    curl -sSfLo ~/.cache/_ghrel "$dl_url"
    $cmd -d -c ~/.cache/_ghrel > ~/.local/bin/"$exe"
    chmod +x ~/.local/bin/"$exe"
    rm ~/.cache/_ghrel
}

mkdir -p $HOME/.config/vim
echo ":: Directory ~/.config/vim"

mkdir -p $HOME/.cache/vim/{swps,undos,logs}
echo ":: Directory ~/.cache/vim/{swps,undos,logs}"

_symlink config/vim/base
_symlink config/vim/colors
_symlink config/vim/autoload
_symlink "$SCR_DIR/config/vim/rc.vim" $HOME/.vimrc
_symlink $HOME/.config/vim $HOME/.vim

_symlink zshrc
_symlink config/zsh

mkdir -p $HOME/.cache/zsh
echo ":: Directory ~/.cache/zsh"
pushd $SCR_DIR
git submodule init
git submodule update
popd

mkdir -p $HOME/.config/mpv
echo ":: Directory ~/.config/mpv"

_symlink config/mpv/input.conf
_symlink config/mpv/mpv.conf

_symlink config/pystartup
_symlink gitconfig
_symlink tmux.conf

mkdir -p $HOME/.local/bin
echo ":: Directory ~/.local/bin"
_symlink local/bin/pwgen.sh

if ! [ -e $HOME/.config/machine ]; then
    cp "$SCR_DIR/config/machine.template" $HOME/.config/machine
    echo ":: Created from template: ~/.config/machine"
else
    echo ":: Path exists; ignoring ~/.config/machine"
fi

curl -sSfLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo ":: plug.vim installed"

if [ "$1" == "--minimal" ]; then
    echo $'\n:: Skipping most downloads! Done!'
    exit
fi

if ! [ -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo ":: TPM installed; Do <prefix>I within tmux to install plugins"
else
    echo ":: TPM exists; Do <prefix>I (or U) to install (or update) plugins"
fi

if [ "$(uname)" != "Linux" ]; then
    echo ":: not a Linux distribution..."

    if [[ "$(uname)" =~ ^(MSYS|MINGW) ]]; then
        _githubrel eza.exe eza-community/eza x86_64-pc-windows-gnu.tar
    fi

    exit
fi

_githubrel fzf junegunn/fzf linux_amd64

_githubrel restic restic/restic linux_amd64

_githubrel eza eza-community/eza x86_64-unknown-linux-musl.tar

if which docker >/dev/null; then
    _githubrel lazydocker jesseduffield/lazydocker Linux_x86_64
else
    echo ":: docker not installed; skipping lazydocker installation"
fi

_githubrel git-lfs git-lfs/git-lfs linux-amd64
echo "   :: also see https://packagecloud.io/github/git-lfs/install"

if ! [ -f ~/.local/bin/noisetorch ]; then
    _githubrel noisetorch noisetorch/NoiseTorch '_x64.*.tgz$'
    echo "   :: noisetorch requires CAP_SYS_RESOURCE permissions..."
    sudo setcap 'CAP_SYS_RESOURCE=+ep' ~/.local/bin/noisetorch
else
    echo ":: noisetorch exists"
fi

if [ "$1" != "--full" ]; then
    echo $'\n:: Skipping UI stuff! Done!'
    exit
fi

mkdir -p $HOME/.local/share/fonts
echo ":: Directory ~/.local/share/fonts"

#_symlink config/i3
#_symlink config/dunst

# Fonts (requires libotf)
curl -sSfLo ~/.local/share/fonts/MonacoB.otf \
    https://raw.githubusercontent.com/vjpr/monaco-bold/master/MonacoB/MonacoB.otf
curl -sSfLo ~/.local/share/fonts/MonacoB-Bold.otf \
    https://raw.githubusercontent.com/vjpr/monaco-bold/master/MonacoB/MonacoB-Bold.otf
curl -sSfLo ~/.local/share/fonts/FontAwesome.otf \
    https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/fonts/FontAwesome.otf
fc-cache -vf
echo

echo $'\n:: Done!'
