#!/bin/bash

echo "Building sysvinit..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 3.9 MB"

tar -xf /sources/sysvinit-*.tar.xz -C /tmp/
mv /tmp/sysvinit-* /tmp/sysvinit

pushd /tmp/sysvinit > /dev/null

patch -Np1 -i /sources/sysvinit-3.14-consolidated-1.patch

make

make install

popd > /dev/null
rm -rf /tmp/sysvinit
