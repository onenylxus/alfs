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
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/flex.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/tcl.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/expect.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/dejagnu.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/pkgconf.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/binutils.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/gmp.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/mpfr.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/mpc.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/attr.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/acl.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/libcap.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/libxcrypt.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/shadow.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/gcc.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/ncurses.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/sed.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/psmisc.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/gettext.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/bison.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/grep.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/bash.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/libtool.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/gdbm.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/gperf.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/expat.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/inetutils.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/less.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/perl.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/xml-parser.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/intltool.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/autoconf.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/automake.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/openssl.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/libelf.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/libffi.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/python.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/flit-core.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/packaging.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/wheel.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/setuptools.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/ninja.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/meson.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/kmod.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/coreutils.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/diffutils.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/gawk.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/findutils.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/groff.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/grub.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/gzip.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/iproute2.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/kbd.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/libpipeline.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/make.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/patch.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/tar.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/texinfo.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/vim.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/markupsafe.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/jinja2.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/udev.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/man-db.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/procps-ng.sh"
sh $LFS_SH/ch7/enter-chroot.sh "bash /opt/lfs/ch8/util-linux.sh"

umount -v $LFS/opt/lfs
rmdir $LFS/opt/lfs

EOF
