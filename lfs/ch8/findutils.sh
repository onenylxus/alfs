#!/bin/bash

echo "Building findutils..."
echo "Approximate build time: 0.7 SBU"
echo "Required disk space: 61 MB"

tar -xf /sources/findutils-*.tar.xz -C /tmp/
mv /tmp/findutils-* /tmp/findutils

pushd /tmp/findutils > /dev/null

./configure --prefix=/usr --localstatedir=/var/lib/locate

make

make install

popd > /dev/null
rm -rf /tmp/findutils
