#!/bin/bash

echo "Building acl..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.5 MB"

tar -xf /sources/acl-*.tar.xz -C /tmp/
mv /tmp/acl-* /tmp/acl

pushd /tmp/acl > /dev/null

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/acl-2.3.2

make

make install

popd > /dev/null
rm -rf /tmp/acl
