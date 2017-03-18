#!/bin/bash

set -e

kexec -l /boot/vmlinuz-linux --initrd=/boot/initramfs-linux.img --reuse-cmdline
systemctl kexec
