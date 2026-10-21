#!/bin/bash

echo "Building gmp..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 54 MB"

tar -xf /sources/gmp-*.tar.xz -C /tmp/
mv /tmp/gmp-* /tmp/gmp

pushd /tmp/gmp > /dev/null

sed -i '/long long t1;/,+1s/()/(...)/' configure

./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.3.0

make
make html

make install
make install-html

popd > /dev/null
rm -rf /tmp/gmp
