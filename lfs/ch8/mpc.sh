#!/bin/bash

echo "Building mpc..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 22 MB"

tar -xf /sources/mpc-*.tar.gz -C /tmp/
mv /tmp/mpc-* /tmp/mpc

pushd /tmp/mpc > /dev/null

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.3.1

make
make html

make install
make install-html

popd > /dev/null
rm -rf /tmp/mpc
