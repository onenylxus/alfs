#!/bin/bash

echo "Building python..."
echo "Approximate build time: 2.0 SBU"
echo "Required disk space: 453 MB"

tar -xf /sources/Python-*.tar.xz -C /tmp/
mv /tmp/Python-* /tmp/Python

pushd /tmp/Python > /dev/null

./configure --prefix=/usr          \
            --enable-shared        \
            --with-system-expat    \
            --enable-optimizations \
            --without-static-libpython

make

make install

cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF

install -v -dm755 /usr/share/doc/python-3.13.7/html

tar --strip-components=1  \
    --no-same-owner       \
    --no-same-permissions \
    -C /usr/share/doc/python-3.13.7/html \
    -xvf /sources/python-3.13.7-docs-html.tar.bz2

popd > /dev/null
rm -rf /tmp/Python
