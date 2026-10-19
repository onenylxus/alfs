#!/bin/bash

echo "Building texinfo..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 152 MB"

tar -xf /sources/texinfo-*.tar.xz -C /tmp/
mv /tmp/texinfo-* /tmp/texinfo

pushd /tmp/texinfo > /dev/null

./configure --prefix=/usr

make
make install

popd > /dev/null
rm -rf /tmp/texinfo
