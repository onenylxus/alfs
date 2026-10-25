#!/bin/bash

echo "Building gperf..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 12 MB"

tar -xf /sources/gperf-*.tar.gz -C /tmp/
mv /tmp/gperf-* /tmp/gperf

pushd /tmp/gperf > /dev/null

./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.3

make

make install

popd > /dev/null
rm -rf /tmp/gperf
