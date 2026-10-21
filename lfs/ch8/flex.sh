#!/bin/bash

echo "Building flex..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 33 MB"

tar -xf /sources/flex-*.tar.gz -C /tmp/
mv /tmp/flex-* /tmp/flex

pushd /tmp/flex > /dev/null

./configure --prefix=/usr \
            --docdir=/usr/share/doc/flex-2.6.4 \
            --disable-static

make

make install

ln -sv flex   /usr/bin/lex
ln -sv flex.1 /usr/share/man/man1/lex.1

popd > /dev/null
rm -rf /tmp/flex
