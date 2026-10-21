#!/bin/bash

echo "Building bc..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 7.8 MB"

tar -xf /sources/bc-*.tar.xz -C /tmp/
mv /tmp/bc-* /tmp/bc

pushd /tmp/bc > /dev/null

CC='gcc -std=c99' ./configure --prefix=/usr -G -O3 -r

make

make install

popd > /dev/null
rm -rf /tmp/bc
