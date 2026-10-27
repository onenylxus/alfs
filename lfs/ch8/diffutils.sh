#!/bin/bash

echo "Building diffutils..."
echo "Approximate build time: 0.5 SBU"
echo "Required disk space: 51 MB"

tar -xf /sources/diffutils-*.tar.xz -C /tmp/
mv /tmp/diffutils-* /tmp/diffutils

pushd /tmp/diffutils > /dev/null

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/diffutils
