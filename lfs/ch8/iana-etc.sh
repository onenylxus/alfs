#!/bin/bash

echo "Building iana-etc..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 4.8 MB"

tar -xf /sources/iana-etc-*.tar.gz -C /tmp/
mv /tmp/iana-etc-* /tmp/iana-etc

pushd /tmp/iana-etc > /dev/null

cp services protocols /etc

popd > /dev/null
rm -rf /tmp/iana-etc
