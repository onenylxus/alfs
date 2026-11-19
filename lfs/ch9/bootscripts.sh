#!/bin/bash

echo "Building lfs-bootscripts..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 238 KB"

tar -xf /sources/lfs-bootscripts-*.tar.xz -C /tmp/
mv /tmp/lfs-bootscripts-* /tmp/lfs-bootscripts

pushd /tmp/lfs-bootscripts > /dev/null

make install

popd > /dev/null
rm -rf /tmp/lfs-bootscripts
