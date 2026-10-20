#!/bin/bash

echo "Building file..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 19 MB"

tar -xf /sources/file-*.tar.gz -C /tmp/
mv /tmp/file-* /tmp/file

pushd /tmp/file > /dev/null

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/file
