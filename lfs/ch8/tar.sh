#!/bin/bash

echo "Building tar..."
echo "Approximate build time: 0.6 SBU"
echo "Required disk space: 43 MB"

tar -xf /sources/tar-*.tar.xz -C /tmp/
mv /tmp/tar-* /tmp/tar

pushd /tmp/tar > /dev/null

FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr

make

make install
make -C doc install-html docdir=/usr/share/doc/tar-1.35

popd > /dev/null
rm -rf /tmp/tar
