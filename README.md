# critiq.scripts
Here's a collection of scripts and configuration files that I use.

## My system overview
* **Operating System**: [Arch Linux](https://wiki.archlinux.org/index.php/The_Arch_Way)
* **Window Manager**: [i3](https://i3wm.org) + X
* **Terminal Emulator**: [urxvt](https://wiki.archlinux.org/index.php/Rxvt-unicode)
* **Text editor**: [neovim](http://neovim.org/)
* **Shell**: bash, zsh
* **File system**: [btrfs](https://btrfs.wiki.kernel.org/index.php/UseCases)

## Repo directories
* **AUR**: custom PKGBUILDs that I use
* **config**: `$HOME/.config` files
* **local**: `$HOME/.local` files
  * **bin**: tiny scripts that make my life easier
* **nvim**: neovim configuration files. After copying it as `$HOME/.nvim`, follow the instructions in `nvimrc` file.
  * **plugin**: short scripts, mostly borrowed from various sources (see respective files).
  * **colors/desertEx-v2.vim**: Modified version of [desertEx.vim](https://github.com/mbbill/desertEx) colorscheme.

## My filesystem layout
There is only a single "Linux" partition which is formatted with btrfs. This contains the following subvolumes and the corresponding mount points:
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
