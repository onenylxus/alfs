#!/bin/bash

set -e
echo "Building m4..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 21 MB"

tar -xf $LFS/sources/sed-*.tar.xz -C /tmp/
mv /tmp/sed-* /tmp/sed

pushd /tmp/sed > /dev/null

./configure       \
  --prefix=/usr   \
  --host=$LFS_TGT \
  --build=$(./build-aux/config.guess)

make
make DESTDIR=$LFS install

popd > /dev/null
rm -rf /tmp/sed
