#!/bin/bash

echo "Building gzip..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 21 MB"

tar -xf /sources/gzip-*.tar.xz -C /tmp/
mv /tmp/gzip-* /tmp/gzip

pushd /tmp/gzip > /dev/null

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/gzip
