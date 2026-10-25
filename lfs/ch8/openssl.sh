#!/bin/bash

echo "Building openssl..."
echo "Approximate build time: 1.9 SBU"
echo "Required disk space: 1.1 GB"

tar -xf /sources/openssl-*.tar.gz -C /tmp/
mv /tmp/openssl-* /tmp/openssl

pushd /tmp/openssl > /dev/null

./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic

make

sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install

mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.5.2
cp -vfr doc/* /usr/share/doc/openssl-3.5.2

popd > /dev/null
rm -rf /tmp/openssl
