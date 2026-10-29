#!/bin/bash

echo "Building patch..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 13 MB"

tar -xf /sources/patch-*.tar.xz -C /tmp/
mv /tmp/patch-* /tmp/patch

pushd /tmp/patch > /dev/null

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/patch
