#!/bin/bash

set -e
echo "Building libstdc++..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 850 MB"

tar -xf $LFS/sources/gcc-*.tar.xz -C /tmp/
mv /tmp/gcc-* /tmp/gcc

pushd /tmp/gcc > /dev/null

mkdir -v build
cd build

../libstdc++-v3/configure    \
  --host=$LFS_TGT            \
  --build=$(../config.guess) \
  --prefix=/usr              \
  --disable-multilib         \
  --disable-nls              \
  --disable-libstdcxx-pch    \
  --with-gxx-include-dir=$LFS/tools/$LFS_TGT/include/c++/14.2.0

make
make DESTDIR=$LFS install

rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la

popd > /dev/null
rm -rf /tmp/gcc
