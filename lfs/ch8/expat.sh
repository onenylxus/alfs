#!/bin/bash

echo "Building expat..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 14 MB"

tar -xf /sources/expat-*.tar.xz -C /tmp/
mv /tmp/expat-* /tmp/expat

pushd /tmp/expat > /dev/null

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/expat-2.7.1

make

make install
install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.7.1

popd > /dev/null
rm -rf /tmp/expat
