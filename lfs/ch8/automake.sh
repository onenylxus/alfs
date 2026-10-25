#!/bin/bash

echo "Building automake..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 123 MB"

tar -xf /sources/automake-*.tar.xz -C /tmp/
mv /tmp/automake-* /tmp/automake

pushd /tmp/automake > /dev/null

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.18.1

make

make install

popd > /dev/null
rm -rf /tmp/automake
