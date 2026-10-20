#!/bin/bash

echo "Building xz..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 24 MB"

tar -xf /sources/xz-*.tar.xz -C /tmp/
mv /tmp/xz-* /tmp/xz

pushd /tmp/xz > /dev/null

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.8.1

make

make install

popd > /dev/null
rm -rf /tmp/xz
