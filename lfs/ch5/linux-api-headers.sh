#!/bin/bash

set -e
echo "Building linux-api-headers..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 1.6 GB"

tar -xf /sources/linux-*.tar.xz -C /tmp/
mv /tmp/linux-* /tmp/linux

pushd /tmp/linux > /dev/null

time {
  make mrproper

  make headers
  find usr/include -type f ! -name '*.h' -delete
  cp -rv usr/include $LFS/usr
}

popd > /dev/null
rm -rf /tmp/linux
