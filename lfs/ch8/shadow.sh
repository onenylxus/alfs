#!/bin/bash

echo "Building shadow..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 115 MB"

tar -xf /sources/shadow-*.tar.xz -C /tmp/
mv /tmp/shadow-* /tmp/shadow

pushd /tmp/shadow > /dev/null

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;

sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' \
    -e 's:/var/spool/mail:/var/mail:'                   \
    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                  \
    -i etc/login.defs

touch /usr/bin/passwd
./configure --sysconfdir=/etc   \
            --disable-static    \
            --with-{b,yes}crypt \
            --without-libbsd    \
            --with-group-name-max-length=32

make

make exec_prefix=/usr install
make -C man install-man

pwconv

grpconv

mkdir -p /etc/default
useradd -D --gid 999

sed -i '/MAIL/s/yes/no/' /etc/default/useradd

# === ALFS CUSTOM CODE ===
# The book sets the root password interactively; set it non-interactively so
# the image build can run unattended.
echo "root:root" | chpasswd
# === ALFS CUSTOM CODE ===

popd > /dev/null
rm -rf /tmp/shadow
