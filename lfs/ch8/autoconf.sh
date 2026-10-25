#!/bin/bash

echo "Building autoconf..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 25 MB"

tar -xf /sources/autoconf-*.tar.xz -C /tmp/
mv /tmp/autoconf-* /tmp/autoconf

pushd /tmp/autoconf > /dev/null

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/autoconf
