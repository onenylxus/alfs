#!/bin/bash

set -e
echo "Building binutils..."
echo "Approximate build time: 1 SBU"
echo "Required disk space: 677 MB"

tar -xf $LFS/sources/binutils-*.tar.xz -C /tmp/
mv /tmp/binutils-* /tmp/binutils

pushd /tmp/binutils > /dev/null

mkdir -v build
cd build

../configure          \
  --prefix=$LFS/tools \
  --with-sysroot=$LFS \
  --target=$LFS_TGT   \
  --disable-nls       \
  --enable-gprofng=no \
  --disable-werror    \
  --enable-new-dtags  \
  --enable-default-hash-style=gnu

make
make install

popd > /dev/null
rm -rf /tmp/binutils
