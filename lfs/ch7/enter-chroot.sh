#!/bin/bash

# 7.4 Entering the Chroot Environment
#
# With arguments, run the given command inside the chroot (used to drive the
# remaining in-chroot setup steps). Without arguments, open an interactive
# shell as described in the LFS book.

if [ $# -gt 0 ]; then
  set -- -c "$*"
fi

chroot "$LFS" /usr/bin/env -i \
  HOME=/root                  \
  TERM="$TERM"                \
  PS1='(lfs chroot) \u:\w\$ ' \
  PATH=/usr/bin:/usr/sbin     \
  MAKEFLAGS="-j$(nproc)"      \
  TESTSUITEFLAGS="-j$(nproc)" \
  /bin/bash --login "$@"
