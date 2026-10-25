#!/bin/bash

echo "Building libffi..."
echo "Approximate build time: 1.7 SBU"
echo "Required disk space: 10 MB"

tar -xf /sources/libffi-*.tar.gz -C /tmp/
mv /tmp/libffi-* /tmp/libffi

pushd /tmp/libffi > /dev/null

./configure --prefix=/usr    \
            --disable-static \
            --with-gcc-arch=native

make

make install

popd > /dev/null
rm -rf /tmp/libffi
