#!/bin/bash

echo "Building Jinja2..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 2.6 MB"

tar -xf /sources/jinja2-*.tar.gz -C /tmp/
mv /tmp/jinja2-* /tmp/jinja2

pushd /tmp/jinja2 > /dev/null

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links dist Jinja2

popd > /dev/null
rm -rf /tmp/jinja2
