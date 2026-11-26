#!/bin/bash -x

set -euo pipefail

# The Docker ENTRYPOINT runs as a non-login shell, so ~/.bashrc is not sourced
# automatically. Load it here to provide LFS_TGT, LC_ALL, CONFIG_SITE,
# MAKEFLAGS and the $LFS/tools/bin PATH required by the chapter 5/6 scripts.
. "$HOME/.bashrc"

exec sudo -E -u root /bin/sh - <<EOF
set -e

# If a step fails, unmount the bind mount before exiting so the container
# can be inspected or removed cleanly.
trap 'umount -v $LFS/opt/lfs 2>/dev/null || true; rmdir $LFS/opt/lfs 2>/dev/null || true' EXIT

chown -R root:root $LFS/tools
sync

sh -e $LFS_SH/ch5/binutils-pass-1.sh
sh -e $LFS_SH/ch5/gcc-pass-1.sh
sh -e $LFS_SH/ch5/linux-api-headers.sh
sh -e $LFS_SH/ch5/glibc.sh
sh -e $LFS_SH/ch5/libstdc++.sh

sh -e $LFS_SH/ch6/m4.sh
sh -e $LFS_SH/ch6/ncurses.sh
sh -e $LFS_SH/ch6/bash.sh
sh -e $LFS_SH/ch6/coreutils.sh
sh -e $LFS_SH/ch6/diffutils.sh
sh -e $LFS_SH/ch6/file.sh
sh -e $LFS_SH/ch6/findutils.sh
sh -e $LFS_SH/ch6/gawk.sh
sh -e $LFS_SH/ch6/grep.sh
sh -e $LFS_SH/ch6/gzip.sh
sh -e $LFS_SH/ch6/make.sh
sh -e $LFS_SH/ch6/patch.sh
sh -e $LFS_SH/ch6/sed.sh
sh -e $LFS_SH/ch6/tar.sh
sh -e $LFS_SH/ch6/xz.sh
sh -e $LFS_SH/ch6/binutils-pass-2.sh
sh -e $LFS_SH/ch6/gcc-pass-2.sh

sh -e $LFS_SH/ch7/change-ownership.sh
sh -e $LFS_SH/ch7/prepare-virtual-kernel.sh

mkdir -pv $LFS/opt/lfs
mount -v --bind $LFS_SH $LFS/opt/lfs
if [ ! -e $LFS/opt/lfs/ch7/create-directories.sh ]; then
  echo "ERROR: failed to bind mount $LFS_SH into the chroot"
  echo "ERROR: rebuild the image and run the container with --privileged"
  exit 1
fi

sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch7/create-directories.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch7/create-essential-files.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch7/gettext.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch7/bison.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch7/perl.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch7/python.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch7/texinfo.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch7/util-linux.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch7/cleanup.sh"

sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/man-pages.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/iana-etc.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/glibc.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/zlib.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/bzip2.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/xz.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/lz4.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/zstd.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/file.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/readline.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/m4.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/bc.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/flex.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/tcl.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/expect.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/dejagnu.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/pkgconf.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/binutils.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/gmp.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/mpfr.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/mpc.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/attr.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/acl.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/libcap.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/libxcrypt.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/shadow.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/gcc.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/ncurses.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/sed.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/psmisc.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/gettext.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/bison.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/grep.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/bash.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/libtool.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/gdbm.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/gperf.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/expat.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/inetutils.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/less.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/perl.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/xml-parser.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/intltool.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/autoconf.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/automake.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/openssl.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/libelf.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/libffi.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/python.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/flit-core.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/packaging.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/wheel.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/setuptools.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/ninja.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/meson.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/kmod.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/coreutils.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/diffutils.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/gawk.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/findutils.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/groff.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/grub.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/gzip.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/iproute2.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/kbd.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/libpipeline.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/make.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/patch.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/tar.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/texinfo.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/vim.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/markupsafe.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/jinja2.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/udev.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/man-db.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/procps-ng.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/util-linux.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/e2fsprogs.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/sysklogd.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/sysvinit.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/stripping.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch8/cleanup.sh"

sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch9/bootscripts.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch9/symlinks.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch9/network.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch9/usage.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch9/locale.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch9/inputrc.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch9/etcshells.sh"

sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch10/fstab.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch10/kernel.sh"
sh -e $LFS_SH/ch7/enter-chroot.sh "bash -e /opt/lfs/ch10/grub.sh"

umount -v $LFS/opt/lfs
rmdir $LFS/opt/lfs
trap - EXIT

EOF
