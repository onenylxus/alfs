#!/bin/bash

set -e
echo "Building findutils..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 48 MB"

tar -xf $LFS/sources/findutils-*.tar.xz -C /tmp/
mv /tmp/findutils-* /tmp/findutils

pushd /tmp/findutils > /dev/null

time
{
  ./configure                       \
    --prefix=/usr                   \
    --localstatedir=/var/lib/locate \
    --host=$LFS_TGT                 \
    --build=$(build-aux/config.guess)

  make
  make DESTDIR=$LFS install
}

popd > /dev/null
rm -rf /tmp/findutils
