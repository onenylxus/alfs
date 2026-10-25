#!/bin/bash

echo "Building flit-core..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 1.3 MB"

tar -xf /sources/flit_core-*.tar.gz -C /tmp/
mv /tmp/flit_core-* /tmp/flit-core

pushd /tmp/flit-core > /dev/null

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links dist flit_core

popd > /dev/null
rm -rf /tmp/flit-core
