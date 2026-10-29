#!/bin/bash

echo "Building make..."
echo "Approximate build time: 0.7 SBU"
echo "Required disk space: 13 MB"

tar -xf /sources/make-*.tar.gz -C /tmp/
mv /tmp/make-* /tmp/make

pushd /tmp/make > /dev/null

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/make
