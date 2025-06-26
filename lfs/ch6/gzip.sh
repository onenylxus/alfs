#!/bin/bash

set -e
echo "Building gzip..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 11 MB"

tar -xf $LFS/sources/gzip-*.tar.xz -C /tmp/
mv /tmp/gzip-* /tmp/gzip

pushd /tmp/gzip > /dev/null

./configure --prefix=/usr --host=$LFS_TGT

make
make DESTDIR=$LFS install

popd > /dev/null
rm -rf /tmp/gzip
