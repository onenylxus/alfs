#!/bin/bash

# === ALFS CUSTOM CODE ===
# Run build commands inside the chroot when arguments are provided, or open
# an interactive shell as described in the book. LFS_DISK is forwarded so
# grub.sh can target a selected disk or loop device instead of the host's
# /dev/sda.
if [ $# -gt 0 ]; then
  set -- -c "$*"
fi

if [ -n "${LFS_DISK:-}" ]; then
  LFS_DISK_ENV="LFS_DISK=$LFS_DISK"
else
  LFS_DISK_ENV=""
fi

chroot "$LFS" /usr/bin/env -i \
  HOME=/root                  \
  TERM="$TERM"                \
  PS1='(lfs chroot) \u:\w\$ ' \
  PATH=/usr/bin:/usr/sbin     \
  MAKEFLAGS="-j$(nproc)"      \
  TESTSUITEFLAGS="-j$(nproc)" \
  $LFS_DISK_ENV               \
  /bin/bash --login "$@"
# === ALFS CUSTOM CODE ===
