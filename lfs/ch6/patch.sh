#!/bin/bash

set -e
echo "Building patch..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 12 MB"

tar -xf /sources/patch-*.tar.xz -C /tmp/
mv /tmp/patch-* /tmp/patch

pushd /tmp/patch > /dev/null

time
{
  ./configure       \
    --prefix=/usr   \
    --host=$LFS_TGT \
    --build=$(build-aux/config.guess)

  make
  make DESTDIR=$LFS install
}

popd > /dev/null
rm -rf /tmp/patch
