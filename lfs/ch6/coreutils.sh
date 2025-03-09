#!/bin/bash

set -e
echo "Building coreutils..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 181 MB"

tar -xf /sources/coreutils-*.tar.gz -C /tmp/
mv /tmp/coreutils-* /tmp/coreutils

pushd /tmp/coreutils > /dev/null

time
{
  ./configure                         \
    --prefix=/usr                     \
    --host=$LFS_TGT                   \
    --build=$(build-aux/config.guess) \
    --enable-install-program=hostname \
    --enable-no-install-program=kill,uptime

  make
  make DESTDIR=$LFS install

  mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
  mkdir -pv $LFS/usr/share/man/man8
  mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
  sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8
}

popd > /dev/null
rm -rf /tmp/bash
