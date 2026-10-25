#!/bin/bash

echo "Building gettext..."
echo "Approximate build time: 2.1 SBU"
echo "Required disk space: 395 MB"

tar -xf /sources/gettext-*.tar.xz -C /tmp/
mv /tmp/gettext-* /tmp/gettext

pushd /tmp/gettext > /dev/null

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.26

make

make install
chmod -v 0755 /usr/lib/preloadable_libintl.so

popd > /dev/null
rm -rf /tmp/gettext
