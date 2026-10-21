#!/bin/bash

echo "Building dejagnu..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.9 MB"

tar -xf /sources/dejagnu-*.tar.gz -C /tmp/
mv /tmp/dejagnu-* /tmp/dejagnu

pushd /tmp/dejagnu > /dev/null

mkdir -v build
cd       build

../configure --prefix=/usr
makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi

make install
install -v -dm755 /usr/share/doc/dejagnu-1.6.3
install -v -m644  doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3

popd > /dev/null
rm -rf /tmp/dejagnu
