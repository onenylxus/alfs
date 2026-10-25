#!/bin/bash

echo "Building grep..."
echo "Approximate build time: 0.6 SBU"
echo "Required disk space: 48 MB"

tar -xf /sources/grep-*.tar.xz -C /tmp/
mv /tmp/grep-* /tmp/grep

pushd /tmp/grep > /dev/null

sed -i "s/echo/#echo/" src/egrep.sh

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/grep
