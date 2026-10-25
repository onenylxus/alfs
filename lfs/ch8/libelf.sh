#!/bin/bash

echo "Building libelf..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 156 MB"

tar -xf /sources/elfutils-*.tar.bz2 -C /tmp/
mv /tmp/elfutils-* /tmp/elfutils

pushd /tmp/elfutils > /dev/null

./configure --prefix=/usr        \
            --disable-debuginfod \
            --enable-libdebuginfod=dummy

make

make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a

popd > /dev/null
rm -rf /tmp/elfutils
