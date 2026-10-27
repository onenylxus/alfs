#!/bin/bash

echo "Building iproute2..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 17 MB"

tar -xf /sources/iproute2-*.tar.xz -C /tmp/
mv /tmp/iproute2-* /tmp/iproute2

pushd /tmp/iproute2 > /dev/null

sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

make NETNS_RUN_DIR=/run/netns

make SBINDIR=/usr/sbin install

install -vDm644 COPYING README* -t /usr/share/doc/iproute2-6.16.0

popd > /dev/null
rm -rf /tmp/iproute2
