#!/bin/bash

echo "Building kbd..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 43 MB"

tar -xf /sources/kbd-*.tar.xz -C /tmp/
mv /tmp/kbd-* /tmp/kbd

pushd /tmp/kbd > /dev/null

patch -Np1 -i /sources/kbd-2.8.0-backspace-1.patch

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure --prefix=/usr --disable-vlock

make

make install

cp -R -v docs/doc -T /usr/share/doc/kbd-2.8.0

popd > /dev/null
rm -rf /tmp/kbd
