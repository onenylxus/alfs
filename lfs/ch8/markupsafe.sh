#!/bin/bash

echo "Building MarkupSafe..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 500 KB"

tar -xf /sources/markupsafe-*.tar.gz -C /tmp/
mv /tmp/markupsafe-* /tmp/markupsafe

pushd /tmp/markupsafe > /dev/null

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links dist Markupsafe

popd > /dev/null
rm -rf /tmp/markupsafe
