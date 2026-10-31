#!/bin/bash

echo "Building sysklogd..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 3.9 MB"

tar -xf /sources/sysklogd-*.tar.gz -C /tmp/
mv /tmp/sysklogd-* /tmp/sysklogd

pushd /tmp/sysklogd > /dev/null

./configure --prefix=/usr      \
            --sysconfdir=/etc  \
            --runstatedir=/run \
            --without-logger   \
            --disable-static   \
            --docdir=/usr/share/doc/sysklogd-2.7.2

make

make install

cat > /etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# Do not open any internet ports.
secure_mode 2

# End /etc/syslog.conf
EOF

popd > /dev/null
rm -rf /tmp/sysklogd
