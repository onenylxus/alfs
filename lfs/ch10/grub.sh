#!/bin/bash

set -e

echo "Setting up GRUB..."

# The book runs `grub-install /dev/sda`. Inside Docker, /dev/sda is the host
# disk (if it exists at all), so an explicit target is required. Set LFS_DISK
# to the disk or loop device containing the LFS system to install GRUB.
# Chapter 8 only installs the i386-pc modules, and the Docker host may be
# booted via UEFI, so select the i386-pc target explicitly.
if [ -n "${LFS_DISK:-}" ]; then
  grub-install --target=i386-pc "$LFS_DISK"
else
  echo "LFS_DISK is not set; skipping grub-install."
  echo "Run grub-install --target=i386-pc <disk> for the target system."
fi

# grub-install creates /boot/grub in the book. When it is skipped in Docker,
# create the directory explicitly so the configuration file can be written.
install -v -m755 -d /boot/grub

# If LFS_DISK is not /dev/sda, adjust the GRUB root and kernel root= values.
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod part_gpt
insmod ext2
set root=(hd0,2)
set gfxpayload=1024x768x32

menuentry "GNU/Linux, Linux 6.16.1-lfs-12.4" {
        linux   /boot/vmlinuz-6.16.1-lfs-12.4 root=/dev/sda2 ro
}
EOF
