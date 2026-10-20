#!/bin/bash

echo "Building zstd..."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 86 MB"

tar -xf /sources/zstd-*.tar.gz -C /tmp/
mv /tmp/zstd-* /tmp/zstd

pushd /tmp/zstd > /dev/null

make prefix=/usr

make prefix=/usr install

rm -v /usr/lib/libzstd.a

popd > /dev/null
rm -rf /tmp/zstd
