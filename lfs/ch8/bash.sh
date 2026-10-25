#!/bin/bash

echo "Building bash..."
echo "Approximate build time: 1.5 SBU"
echo "Required disk space: 56 MB"

tar -xf /sources/bash-*.tar.gz -C /tmp/
mv /tmp/bash-* /tmp/bash

pushd /tmp/bash > /dev/null

./configure --prefix=/usr             \
            --without-bash-malloc     \
            --with-installed-readline \
            --docdir=/usr/share/doc/bash-5.3

make

make install

popd > /dev/null
rm -rf /tmp/bash
