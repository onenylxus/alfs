#!/bin/bash

set -e
echo "Building tar..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 42 MB"

tar -xf $LFS/sources/tar-*.tar.xz -C /tmp/
mv /tmp/tar-* /tmp/tar

pushd /tmp/tar > /dev/null

./configure       \
  --prefix=/usr   \
  --host=$LFS_TGT \
  --build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install

popd > /dev/null
rm -rf /tmp/tar
