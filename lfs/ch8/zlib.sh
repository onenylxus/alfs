#!/bin/bash

echo "Building zlib..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.4 MB"

tar -xf /sources/zlib-*.tar.gz -C /tmp/
mv /tmp/zlib-* /tmp/zlib

pushd /tmp/zlib > /dev/null

./configure --prefix=/usr

make

make install

rm -fv /usr/lib/libz.a

popd > /dev/null
rm -rf /tmp/zlib
