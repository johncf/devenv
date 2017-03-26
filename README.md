# devenv
This is a collection of scripts and config files that make up my development environment.

## Environment
* **Operating System**: [Arch Linux](https://wiki.archlinux.org/index.php/The_Arch_Way)
* **Window Manager**: [i3](https://i3wm.org)
* **Terminal**: [rxvt-unicode] + [tmux]
* **Text editor**: [Neovim](http://neovim.org/)
* **Shell**: [Zsh](https://wiki.archlinux.org/index.php/Zsh)

[rxvt-unicode]: https://wiki.archlinux.org/index.php/Rxvt-unicode
[tmux]: https://tmux.github.io/

## Major files and directories
* **config**: `~/.config` files
  * **nvim**: neovim configuration files
    * **colors/desertEx-v2.vim**: Modified [desertEx.vim] colorscheme.
  * **pystartup**: for autocompletion and persistent history in python REPL.
  * **zsh**: zsh config files, contains stolen code from various sources (see respective files):
    * **prompt.zsh**: for asynchronously updating prompt with git info ([stolen])
    * **[fasd]**: for fast directory switching
* **local/bin**: tiny scripts that make my life easier

[desertEx.vim]: https://github.com/mbbill/desertEx
[stolen]: https://github.com/anishathalye/dotfiles/blob/master/zsh/prompt.zsh
[fasd]: https://github.com/clvv/fasd

## Installation and removal
Just run `install.sh` to create relevant directories and links... See `install.sh --help`.
Run `uninstall.sh` to remove all symbolic links created by `install.sh`.

## Screenshot

![screenshot](https://cloud.githubusercontent.com/assets/1436441/11402385/a2c0e8c6-93bd-11e5-9956-36b417c424c9.png)

## License
Many files in this repo were originally written by various authors including:

* [anishathalye](https://github.com/anishathalye/dotfiles/blob/master/zsh)
* [Doug Black](http://dougblack.io/words/zsh-vi-mode.html)
* [mattjj](https://github.com/mattjj/my-oh-my-zsh)
* [mbbill](https://github.com/mbbill)
* [nelstrom](http://stackoverflow.com/a/3180886/2849934)
* [spicycode](https://github.com/spicycode/ze-best-zsh-config/blob/master/.zsh)
* [sykora](http://github.com/sykora/etc/blob/master/zsh/functions/spectrum)
* [tpope](https://github.com/tpope/vim-unimpaired)

The rest (authored by me) are released under [MIT License](http://opensource.org/licenses/MIT).
