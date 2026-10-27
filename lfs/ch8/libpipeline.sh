#!/bin/bash

echo "Building libpipeline..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 10 MB"

tar -xf /sources/libpipeline-*.tar.gz -C /tmp/
mv /tmp/libpipeline-* /tmp/libpipeline

pushd /tmp/libpipeline > /dev/null

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/libpipeline
