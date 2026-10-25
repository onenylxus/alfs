#!/bin/bash

echo "Building psmisc..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.7 MB"

tar -xf /sources/psmisc-*.tar.xz -C /tmp/
mv /tmp/psmisc-* /tmp/psmisc

pushd /tmp/psmisc > /dev/null

./configure --prefix=/usr

make

make install

popd > /dev/null
rm -rf /tmp/psmisc
