#!/bin/bash

echo "Building man-pages..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 52 MB"

tar -xf /sources/man-pages-*.tar.xz -C /tmp/
mv /tmp/man-pages-* /tmp/man-pages

pushd /tmp/man-pages > /dev/null

rm -v man3/crypt*

make -R GIT=false prefix=/usr install

popd > /dev/null
rm -rf /tmp/man-pages
