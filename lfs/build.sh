#!/bin/bash -x

set -euo pipefail

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
