#!/bin/bash

set -e
echo "Building make..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 15 MB"

tar -xf /sources/make-*.tar.xz -C /tmp/
mv /tmp/make-* /tmp/make

pushd /tmp/make > /dev/null

time
{
  ./configure       \
    --prefix=/usr   \
    --host=$LFS_TGT \
    --build=$(build-aux/config.guess)

  make
  make DESTDIR=$LFS install
}

popd > /dev/null
rm -rf /tmp/make
