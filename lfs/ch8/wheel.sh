#!/bin/bash

echo "Building wheel..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 608 KB"

tar -xf /sources/wheel-*.tar.gz -C /tmp/
mv /tmp/wheel-* /tmp/wheel

pushd /tmp/wheel > /dev/null

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links dist wheel

popd > /dev/null
rm -rf /tmp/wheel
