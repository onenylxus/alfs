#!/bin/bash

echo "Building mpfr..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 43 MB"

tar -xf /sources/mpfr-*.tar.xz -C /tmp/
mv /tmp/mpfr-* /tmp/mpfr

pushd /tmp/mpfr > /dev/null

./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.2.2

make
make html

make install
make install-html

popd > /dev/null
rm -rf /tmp/mpfr
