#!/bin/bash

set -e
echo "Building xz..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 21 MB"

tar -xf $LFS/sources/xz-*.tar.xz -C /tmp/
mv /tmp/xz-* /tmp/xz

pushd /tmp/xz > /dev/null

time
{
  ./configure                         \
    --prefix=/usr                     \
    --host=$LFS_TGT                   \
    --build=$(build-aux/config.guess) \
    --disable-static                  \
    --docdir=/usr/share/doc/xz-5.6.4

  make
  make DESTDIR=$LFS install

  rm -v $LFS/usr/lib/liblzma.la
}

popd > /dev/null
rm -rf /tmp/xz
