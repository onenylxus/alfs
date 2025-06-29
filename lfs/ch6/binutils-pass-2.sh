#!/bin/bash

set -e
echo "Building binutils..."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 549 MB"

tar -xf $LFS/sources/binutils-*.tar.xz -C /tmp/
mv /tmp/binutils-* /tmp/binutils

pushd /tmp/binutils > /dev/null

sed '6009s/$add_dir//' -i ltmain.sh

mkdir -v build
cd build

../configure                 \
  --prefix=/usr              \
  --build=$(../config.guess) \
  --host=$LFS_TGT            \
  --disable-nls              \
  --enable-shared            \
  --enable-gprofng=no        \
  --disable-werror           \
  --enable-64-bit-bfd        \
  --enable-new-dtags         \
  --enable-default-hash-style=gnu

make
make DESTDIR=$LFS install

rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}

popd > /dev/null
rm -rf /tmp/binutils
