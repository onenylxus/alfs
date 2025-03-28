#!/bin/bash

set -e
echo "Building grep..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 27 MB"

tar -xf $LFS/sources/grep-*.tar.xz -C /tmp/
mv /tmp/grep-* /tmp/grep

pushd /tmp/grep > /dev/null

time
{
  ./configure       \
    --prefix=/usr   \
    --host=$LFS_TGT \
    --build=$(./build-aux/config.guess)

  make
  make DESTDIR=$LFS install
}

popd > /dev/null
rm -rf /tmp/grep
