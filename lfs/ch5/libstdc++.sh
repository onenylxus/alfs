#!/bin/bash

set -e
echo "Building libstdc++..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 850 MB"

tar -xf /sources/gcc-*.tar.xz -C /tmp/
mv /tmp/gcc-* /tmp/gcc

pushd /tmp/gcc > /dev/null

time {
  mkdir -v build
  cd build

  ../libstdc++-v3/configure         \
    --host=$LFS_TGT                 \
    --build=$(../config.guess)      \
    --prefix=/usr                   \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/14.2.0

  make
  make DESTDIR=$LFS install
}

popd > /dev/null
rm -rf /tmp/gcc

rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la
