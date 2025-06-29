#!/bin/bash -x

exec sudo -E -u root /bin/sh - <<EOF
chown -R root:root $LFS/tools

sync

$LFS_SH/ch5/binutils-pass-1.sh
$LFS_SH/ch5/gcc-pass-1.sh
$LFS_SH/ch5/linux-api-headers.sh
$LFS_SH/ch5/glibc.sh
$LFS_SH/ch5/libstdc++.sh
$LFS_SH/ch6/m4.sh
$LFS_SH/ch6/ncurses.sh
$LFS_SH/ch6/bash.sh
$LFS_SH/ch6/coreutils.sh
$LFS_SH/ch6/diffutils.sh
$LFS_SH/ch6/file.sh
$LFS_SH/ch6/findutils.sh
$LFS_SH/ch6/gawk.sh
$LFS_SH/ch6/grep.sh
$LFS_SH/ch6/gzip.sh
$LFS_SH/ch6/make.sh
$LFS_SH/ch6/patch.sh
$LFS_SH/ch6/sed.sh
$LFS_SH/ch6/tar.sh
$LFS_SH/ch6/xz.sh
