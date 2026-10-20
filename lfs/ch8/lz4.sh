#!/bin/bash

echo "Building lz4..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 4.2 MB"

tar -xf /sources/lz4-*.tar.gz -C /tmp/
mv /tmp/lz4-* /tmp/lz4

pushd /tmp/lz4 > /dev/null

make BUILD_STATIC=no PREFIX=/usr

make BUILD_STATIC=no PREFIX=/usr install

popd > /dev/null
rm -rf /tmp/lz4
