#!/bin/bash

echo "Building expect..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 3.9 MB"

tar -xf /sources/expect5.45.4.tar.gz -C /tmp/
mv /tmp/expect5.45.4 /tmp/expect

pushd /tmp/expect > /dev/null

patch -Np1 -i /sources/expect-5.45.4-gcc15-1.patch

./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --disable-rpath         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include

make

make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib

popd > /dev/null
rm -rf /tmp/expect
