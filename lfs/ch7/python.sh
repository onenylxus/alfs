#!/bin/bash

echo "Building python..."
echo "Approximate build time: 0.5 SBU"
echo "Required disk space: 546 MB"

tar -xf /sources/Python-*.tar.xz -C /tmp/
mv /tmp/Python-* /tmp/Python

pushd /tmp/Python > /dev/null

./configure --prefix=/usr       \
            --enable-shared     \
            --without-ensurepip \
            --without-static-libpython

make
make install

popd > /dev/null
rm -rf /tmp/Python
