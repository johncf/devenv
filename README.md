# critiq.scripts
Here's a collection of cripts and configuration files that I use.

## My system overview
* **Operating System**: [Arch Linux](https://wiki.archlinux.org/index.php/The_Arch_Way)
* **Window Manager**: [i3](https://i3wm.org) + X
* **Terminal Emulator**: [urxvt](https://wiki.archlinux.org/index.php/Rxvt-unicode)
* **Text editor**: [neovim](http://neovim.org/)
* **Shell**: bash + bash-completion
* **File system**: [btrfs](https://btrfs.wiki.kernel.org/index.php/UseCases)

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
 |  `- snaps     --                 Used to keep read-only snapshots of user's home subvolumes.
 `- snaps        --                 Used to keep read-only snapshots of root and boot subvolumes.
    |...         --
```
