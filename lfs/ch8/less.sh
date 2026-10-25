#!/bin/bash

echo "Building less..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 16 MB"

tar -xf /sources/less-*.tar.gz -C /tmp/
mv /tmp/less-* /tmp/less

pushd /tmp/less > /dev/null

./configure --prefix=/usr --sysconfdir=/etc

make

make install

popd > /dev/null
rm -rf /tmp/less
