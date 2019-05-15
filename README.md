# devenv

This is a collection of scripts and config files that make up my development environment.

## Environment
* **Operating System**: [Arch Linux](https://wiki.archlinux.org/index.php/The_Arch_Way)
* **Window Manager**: [i3](https://i3wm.org)
* **Terminal**: [rxvt-unicode][] + [tmux][]
* **Text editor**: [vim](https://vim.org/)
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

![screenshot](https://user-images.githubusercontent.com/21051830/40007162-b17bf712-57b9-11e8-98d7-ef5881e16a12.png)

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

## Rants (out of frustration?)

Until recently, my preferred choice of graphical file manager was PCManFM. Even though it
had a few pesky bugs that caused occasional crashes, I liked it and hoped that some day the
developers are gonna clean it right up! However, after waiting many years, I am giving up
on it especially after it caused multiple freezes due to bad memory leaks (and creeping up
on swap). So dear reader, **please avoid using PCManFM** if you value your time and unsaved
works! (Unless, it has been several years from the time of writing this, meanwhile someone
rewrote it from scratch or something.)
