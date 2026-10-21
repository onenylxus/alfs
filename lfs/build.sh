#!/bin/bash -x

set -euo pipefail

# The Docker ENTRYPOINT runs as a non-login shell, so ~/.bashrc is not sourced
# automatically. Load it here to provide LFS_TGT, LC_ALL, CONFIG_SITE,
# MAKEFLAGS and the $LFS/tools/bin PATH required by the chapter 5/6 scripts.
. "$HOME/.bashrc"

exec sudo -E -u root /bin/sh - <<EOF
chown -R root:root $LFS/tools
sync

sh $LFS_SH/ch5/binutils-pass-1.sh
sh $LFS_SH/ch5/gcc-pass-1.sh
sh $LFS_SH/ch5/linux-api-headers.sh
sh $LFS_SH/ch5/glibc.sh
sh $LFS_SH/ch5/libstdc++.sh

sh $LFS_SH/ch6/m4.sh
sh $LFS_SH/ch6/ncurses.sh
sh $LFS_SH/ch6/bash.sh
sh $LFS_SH/ch6/coreutils.sh
sh $LFS_SH/ch6/diffutils.sh
sh $LFS_SH/ch6/file.sh
sh $LFS_SH/ch6/findutils.sh
sh $LFS_SH/ch6/gawk.sh
sh $LFS_SH/ch6/grep.sh
sh $LFS_SH/ch6/gzip.sh
sh $LFS_SH/ch6/make.sh
sh $LFS_SH/ch6/patch.sh
sh $LFS_SH/ch6/sed.sh
sh $LFS_SH/ch6/tar.sh
sh $LFS_SH/ch6/xz.sh
sh $LFS_SH/ch6/binutils-pass-2.sh
sh $LFS_SH/ch6/gcc-pass-2.sh

sh $LFS_SH/ch7/change-ownership.sh
sh $LFS_SH/ch7/prepare-virtual-kernel.sh

mkdir -pv $LFS/opt/lfs
mount -v --bind $LFS_SH $LFS/opt/lfs
if [ ! -e $LFS/opt/lfs/ch7/create-directories.sh ]; then
  echo "ERROR: failed to bind mount $LFS_SH into the chroot"
  echo "ERROR: rebuild the image and run the container with --privileged"
  exit 1
fi

sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch7/create-directories.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch7/create-essential-files.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch7/gettext.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch7/bison.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch7/perl.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch7/python.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch7/texinfo.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch7/util-linux.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch7/cleanup.sh"

sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/man-pages.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/iana-etc.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/glibc.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/zlib.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/bzip2.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/xz.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/lz4.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/zstd.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/file.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/readline.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/m4.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/bc.sh"

umount -v $LFS/opt/lfs
rmdir $LFS/opt/lfs

EOF
