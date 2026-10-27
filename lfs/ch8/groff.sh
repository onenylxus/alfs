#!/bin/bash

echo "Building groff..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 108 MB"

tar -xf /sources/groff-*.tar.gz -C /tmp/
mv /tmp/groff-* /tmp/groff

pushd /tmp/groff > /dev/null

PAGE=letter ./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/groff
