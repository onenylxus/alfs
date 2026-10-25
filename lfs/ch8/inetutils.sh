#!/bin/bash

echo "Building inetutils..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 36 MB"

tar -xf /sources/inetutils-*.tar.xz -C /tmp/
mv /tmp/inetutils-* /tmp/inetutils

pushd /tmp/inetutils > /dev/null

sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c

./configure --prefix=/usr        \
            --bindir=/usr/bin    \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers

make

make install

mv -v /usr/{,s}bin/ifconfig

popd > /dev/null
rm -rf /tmp/inetutils
