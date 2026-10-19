#!/bin/bash

echo "Building util-linux..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 192 MB"

tar -xf /sources/util-linux-*.tar.xz -C /tmp/
mv /tmp/util-linux-* /tmp/util-linux

pushd /tmp/util-linux > /dev/null

mkdir -pv /var/lib/hwclock

./configure --libdir=/usr/lib     \
            --runstatedir=/run    \
            --disable-chfn-chsh   \
            --disable-login       \
            --disable-nologin     \
            --disable-su          \
            --disable-setpriv     \
            --disable-runuser     \
            --disable-pylibmount  \
            --disable-static      \
            --disable-liblastlog2 \
            --without-python      \
            ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linux-2.41.1

make
make install

popd > /dev/null
rm -rf /tmp/util-linux
