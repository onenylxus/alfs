#!/bin/bash

echo "Building bison..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 58 MB"

tar -xf /sources/bison-*.tar.xz -C /tmp/
mv /tmp/bison-* /tmp/bison

pushd /tmp/bison > /dev/null

./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2

make
make install

popd > /dev/null
rm -rf /tmp/bison
