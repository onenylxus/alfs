#!/bin/bash

echo "Building libtool..."
echo "Approximate build time: 0.6 SBU"
echo "Required disk space: 44 MB"

tar -xf /sources/libtool-*.tar.xz -C /tmp/
mv /tmp/libtool-* /tmp/libtool

pushd /tmp/libtool > /dev/null

./configure --prefix=/usr

make

make install

rm -fv /usr/lib/libltdl.a

popd > /dev/null
rm -rf /tmp/libtool
