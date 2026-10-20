#!/bin/bash

echo "Building m4..."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 60 MB"

tar -xf /sources/m4-*.tar.xz -C /tmp/
mv /tmp/m4-* /tmp/m4

pushd /tmp/m4 > /dev/null

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/m4
