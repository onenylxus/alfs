#!/bin/bash

echo "Building libxcrypt..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 12 MB"

tar -xf /sources/libxcrypt-*.tar.xz -C /tmp/
mv /tmp/libxcrypt-* /tmp/libxcrypt

pushd /tmp/libxcrypt > /dev/null

./configure --prefix=/usr                \
            --enable-hashes=strong,glibc \
            --enable-obsolete-api=no     \
            --disable-static             \
            --disable-failure-tokens

make

make install

make distclean
./configure --prefix=/usr                \
            --enable-hashes=strong,glibc \
            --enable-obsolete-api=glibc  \
            --disable-static             \
            --disable-failure-tokens
make
cp -av --remove-destination .libs/libcrypt.so.1* /usr/lib

popd > /dev/null
rm -rf /tmp/libxcrypt
