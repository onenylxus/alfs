#!/bin/bash

echo "Building gawk..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 45 MB"

tar -xf /sources/gawk-*.tar.xz -C /tmp/
mv /tmp/gawk-* /tmp/gawk

pushd /tmp/gawk > /dev/null

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr

make

rm -f /usr/bin/gawk-5.3.2
make install

ln -sv gawk.1 /usr/share/man/man1/awk.1

install -vDm644 doc/{awkforai.txt,*.{eps,pdf,jpg}} -t /usr/share/doc/gawk-5.3.2

popd > /dev/null
rm -rf /tmp/gawk
