#!/bin/bash

echo "Building sed..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 30 MB"

tar -xf /sources/sed-*.tar.xz -C /tmp/
mv /tmp/sed-* /tmp/sed

pushd /tmp/sed > /dev/null

./configure --prefix=/usr

make
make html

make install
install -d -m755           /usr/share/doc/sed-4.9
install -m644 doc/sed.html /usr/share/doc/sed-4.9

popd > /dev/null
rm -rf /tmp/sed
