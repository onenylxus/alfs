#!/bin/bash

echo "Building setuptools..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 25 MB"

tar -xf /sources/setuptools-*.tar.gz -C /tmp/
mv /tmp/setuptools-* /tmp/setuptools

pushd /tmp/setuptools > /dev/null

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links dist setuptools

popd > /dev/null
rm -rf /tmp/setuptools
