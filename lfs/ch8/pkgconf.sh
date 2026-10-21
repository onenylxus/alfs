#!/bin/bash

echo "Building pkgconf..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 5.0 MB"

tar -xf /sources/pkgconf-*.tar.xz -C /tmp/
mv /tmp/pkgconf-* /tmp/pkgconf

pushd /tmp/pkgconf > /dev/null

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/pkgconf-2.5.1

make

make install

ln -sv pkgconf   /usr/bin/pkg-config
ln -sv pkgconf.1 /usr/share/man/man1/pkg-config.1

popd > /dev/null
rm -rf /tmp/pkgconf
