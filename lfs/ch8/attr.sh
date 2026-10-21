#!/bin/bash

echo "Building attr..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 4.1 MB"

tar -xf /sources/attr-*.tar.gz -C /tmp/
mv /tmp/attr-* /tmp/attr

pushd /tmp/attr > /dev/null

./configure --prefix=/usr     \
            --disable-static  \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-2.5.2

make

make install

popd > /dev/null
rm -rf /tmp/attr
