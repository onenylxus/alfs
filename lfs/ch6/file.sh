#!/bin/bash

set -e
echo "Building file..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 42 MB"

tar -xf /sources/file-*.tar.xz -C /tmp/
mv /tmp/file-* /tmp/file

pushd /tmp/file > /dev/null

time
{
  mkdir build
  pushd build
    ../configure           \
      --disable-bzilb      \
      --disable-libseccomp \
      --disable-xzlib      \
      --disable-zlib
    make
  popd

  ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)

  make FILE_COMPILE=$(pwd)/build/src/file
  make DESTDIR=$LFS install

  rm -v $LFS/usr/lib/libmagic.la
}

popd > /dev/null
rm -rf /tmp/file
