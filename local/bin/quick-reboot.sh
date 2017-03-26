#!/bin/bash

set -e

sudo kexec -l /boot/vmlinuz-linux --initrd=/boot/initramfs-linux.img --reuse-cmdline
sudo systemctl kexec
