#!/bin/bash

echo "Building libcap..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 3.1 MB"

tar -xf /sources/libcap-*.tar.xz -C /tmp/
mv /tmp/libcap-* /tmp/libcap

pushd /tmp/libcap > /dev/null

sed -i '/install -m.*STA/d' libcap/Makefile

make prefix=/usr lib=lib

make prefix=/usr lib=lib install

popd > /dev/null
rm -rf /tmp/libcap
