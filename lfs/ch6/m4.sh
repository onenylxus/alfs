#!/bin/bash

set -e
echo "Building m4..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 32 MB"

tar -xf $LFS/sources/m4-*.tar.xz -C /tmp/
mv /tmp/m4-* /tmp/m4

pushd /tmp/m4 > /dev/null

./configure       \
  --prefix=/usr   \
  --host=$LFS_TGT \
  --build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install

popd > /dev/null
rm -rf /tmp/m4
