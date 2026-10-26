#!/bin/bash

echo "Building kmod..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.7 MB"

tar -xf /sources/kmod-*.tar.xz -C /tmp/
mv /tmp/kmod-* /tmp/kmod

pushd /tmp/kmod > /dev/null

mkdir -p build
cd       build

meson setup --prefix=/usr ..    \
            --buildtype=release \
            -D manpages=false

ninja

ninja install

popd > /dev/null
rm -rf /tmp/kmod
