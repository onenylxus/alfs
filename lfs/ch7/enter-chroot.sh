#!/bin/bash

# 7.4 Entering the Chroot Environment
#
# With arguments, run the given command inside the chroot (used to drive the
# remaining in-chroot setup steps). Without arguments, open an interactive
# shell as described in the LFS book.

if [ $# -gt 0 ]; then
  set -- -c "$*"
fi

# LFS_DISK is a Docker-only addition: it lets grub.sh install GRUB on an
# explicitly selected disk or loop device instead of the host's /dev/sda.
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
