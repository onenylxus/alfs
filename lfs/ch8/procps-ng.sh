#!/bin/bash

echo "Building procps-ng..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 28 MB"

tar -xf /sources/procps-ng-*.tar.xz -C /tmp/
mv /tmp/procps-ng-* /tmp/procps-ng

pushd /tmp/procps-ng > /dev/null

./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/procps-ng-4.0.5 \
            --disable-static                        \
            --disable-kill                          \
            --enable-watch8bit

make

make install

popd > /dev/null
rm -rf /tmp/procps-ng
