#!/bin/bash

echo "Building man-db..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 44 MB"

tar -xf /sources/man-db-*.tar.xz -C /tmp/
mv /tmp/man-db-* /tmp/man-db

pushd /tmp/man-db > /dev/null

./configure --prefix=/usr                         \
            --docdir=/usr/share/doc/man-db-2.13.1 \
            --sysconfdir=/etc                     \
            --disable-setuid                      \
            --enable-cache-owner=bin              \
            --with-browser=/usr/bin/lynx          \
            --with-vgrind=/usr/bin/vgrind         \
            --with-grap=/usr/bin/grap             \
            --with-systemdtmpfilesdir=            \
            --with-systemdsystemunitdir=

make

make install

popd > /dev/null
rm -rf /tmp/man-db
