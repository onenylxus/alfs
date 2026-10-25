#!/bin/bash

echo "Building gdbm..."
echo "Approximate build time: less than 0.2 SBU"
echo "Required disk space: 13 MB"

tar -xf /sources/gdbm-*.tar.gz -C /tmp/
mv /tmp/gdbm-* /tmp/gdbm

pushd /tmp/gdbm > /dev/null

./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat

make

make install

popd > /dev/null
rm -rf /tmp/gdbm
