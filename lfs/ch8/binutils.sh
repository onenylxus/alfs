#!/bin/bash

echo "Building binutils..."
echo "Approximate build time: 1.6 SBU"
echo "Required disk space: 832 MB"

tar -xf /sources/binutils-*.tar.xz -C /tmp/
mv /tmp/binutils-* /tmp/binutils

pushd /tmp/binutils > /dev/null

mkdir -v build
cd       build

../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --enable-new-dtags  \
             --with-system-zlib  \
             --enable-default-hash-style=gnu

make tooldir=/usr

make tooldir=/usr install

rm -rfv /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a \
        /usr/share/doc/gprofng/

popd > /dev/null
rm -rf /tmp/binutils
