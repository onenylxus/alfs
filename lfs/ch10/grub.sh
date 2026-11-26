#!/bin/bash

set -e

echo "Setting up GRUB..."

# === ALFS CUSTOM CODE ===
# The book runs grub-install /dev/sda. Inside Docker, /dev/sda is the host
# disk, so install only when LFS_DISK selects a target disk or loop device.
# Chapter 8 only installs the i386-pc modules, and the Docker host may be
# booted via UEFI, so select the i386-pc target explicitly.
if [ -n "${LFS_DISK:-}" ]; then
  grub-install --target=i386-pc "$LFS_DISK"
else
  echo "LFS_DISK is not set; skipping grub-install."
  echo "Run grub-install --target=i386-pc <disk> for the target system."
fi
# === ALFS CUSTOM CODE ===

# === ALFS CUSTOM CODE ===
# grub-install normally creates /boot/grub; create it explicitly when the
# install step is skipped so the configuration can still be written.
install -v -m755 -d /boot/grub
# === ALFS CUSTOM CODE ===

# If LFS_DISK is not /dev/sda, adjust the GRUB root and kernel root= values.
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod part_gpt
insmod ext2
set root=(hd0,2)
set gfxpayload=1024x768x32

menuentry "GNU/Linux, Linux 6.16.1-lfs" {
        linux   /boot/vmlinuz-6.16.1-lfs root=/dev/sda2 ro
}
EOF
