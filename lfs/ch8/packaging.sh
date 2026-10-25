#!/bin/bash

echo "Building packaging..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 3.3 MB"

tar -xf /sources/packaging-*.tar.gz -C /tmp/
mv /tmp/packaging-* /tmp/packaging

pushd /tmp/packaging > /dev/null

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links dist packaging

popd > /dev/null
rm -rf /tmp/packaging
