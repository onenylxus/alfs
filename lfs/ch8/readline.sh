#!/bin/bash

echo "Building readline..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 17 MB"

tar -xf /sources/readline-*.tar.gz -C /tmp/
mv /tmp/readline-* /tmp/readline

pushd /tmp/readline > /dev/null

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

sed -i 's/-Wl,-rpath,[^ ]*//' support/shobj-conf

./configure --prefix=/usr    \
            --disable-static \
            --with-curses    \
            --docdir=/usr/share/doc/readline-8.3

make SHLIB_LIBS="-lncursesw"

make install

install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.3

popd > /dev/null
rm -rf /tmp/readline
