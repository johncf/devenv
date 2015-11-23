# critiq.scripts
Here's a collection of scripts and configuration files that I use.

## Favorites
* **Operating System**: [Arch Linux](https://wiki.archlinux.org/index.php/The_Arch_Way)
* **Window Manager**: [i3](https://i3wm.org)
* **Terminal Emulator**: [rxvt-unicode](https://wiki.archlinux.org/index.php/Rxvt-unicode)
* **Text editor**: [Neovim](http://neovim.org/)
* **Shell**: [Zsh](https://wiki.archlinux.org/index.php/Zsh)
* **File system**: [Btrfs](https://btrfs.wiki.kernel.org/index.php/UseCases)

## Major files and directories
* **config**: `~/.config` files
  * **nvim**: neovim configuration files
    * **autoload**: short scripts, mostly stolen from various sources (see respective files).
    * **colors/desertEx-v2.vim**: Modified version of [desertEx.vim](https://github.com/mbbill/desertEx) colorscheme.
  * **pystartup**: for autocompletion and persistent history in python REPL.
* **local/bin**: tiny scripts that make my life easier
* **zsh**: zsh config files, contains stolen code from various sources (see respective files):
  * **prompt.zsh**: for asynchronously updating prompt with git info ([stolen from](https://github.com/anishathalye/dotfiles/blob/master/zsh/prompt.zsh))
  * [fasd](https://github.com/clvv/fasd): for fast directory switching, and [vim integration](https://github.com/critiqjo/unite-fasd.vim)

## Installation and removal
Just run `install.sh` to create relevant directories and links... By default, configures only (Neo)vim. See `install.sh --help`.
Run `uninstall.sh` to remove all (and only) symbolic links created by `install.sh`.

## My filesystem layout
There is a single "Linux" partition which is btrfs formatted; containing the following subvolumes:
```
Subvolume       Mount point         Description
<0>              --                 The root subvolume of a btrfs partition
 |- boot        /boot
 |- root        /
 |- home        /home               Note: All the child subvolumes will appear as directories in /home
 |  |- shared    --                 Shared files between users
 |  |- user1     --
 |  |- user2     --
 |  `- snaps     --                 Used to keep snapshots of user's home subvolumes.
 `- snaps        --                 Used to keep snapshots of root and boot subvolumes.
    |...         --
```

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
