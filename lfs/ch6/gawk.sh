#!/bin/bash

set -e
echo "Building gawk..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 47 MB"

tar -xf $LFS/sources/gawk-*.tar.xz -C /tmp/
mv /tmp/gawk-* /tmp/gawk

pushd /tmp/gawk > /dev/null

sed -i 's/extras//' Makefile.in

./configure       \
  --prefix=/usr   \
  --host=$LFS_TGT \
  --build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install

popd > /dev/null
rm -rf /tmp/gawk
