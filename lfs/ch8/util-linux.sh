#!/bin/bash

echo "Building util-linux..."
echo "Approximate build time: 0.5 SBU"
echo "Required disk space: 346 MB"

tar -xf /sources/util-linux-*.tar.xz -C /tmp/
mv /tmp/util-linux-* /tmp/util-linux

pushd /tmp/util-linux > /dev/null

./configure --bindir=/usr/bin     \
            --libdir=/usr/lib     \
            --runstatedir=/run    \
            --sbindir=/usr/sbin   \
            --disable-chfn-chsh   \
            --disable-login       \
            --disable-nologin     \
            --disable-su          \
            --disable-setpriv     \
            --disable-runuser     \
            --disable-pylibmount  \
            --disable-liblastlog2 \
            --disable-static      \
            --without-python      \
            --without-systemd     \
            --without-systemdsystemunitdir        \
            ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linux-2.41.1

make

make install

popd > /dev/null
rm -rf /tmp/util-linux
