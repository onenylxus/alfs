#!/bin/bash

echo "Building coreutils..."
echo "Approximate build time: 1.2 SBU"
echo "Required disk space: 180 MB"

tar -xf /sources/coreutils-*.tar.xz -C /tmp/
mv /tmp/coreutils-* /tmp/coreutils

pushd /tmp/coreutils > /dev/null

patch -Np1 -i /sources/coreutils-9.7-upstream_fix-1.patch

patch -Np1 -i /sources/coreutils-9.7-i18n-1.patch

autoreconf -fv
automake -af
FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime

make

make install

mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8

popd > /dev/null
rm -rf /tmp/coreutils
