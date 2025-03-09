#!/bin/bash

set -e
echo "Building bash..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 68 MB"

tar -xf /sources/bash-*.tar.gz -C /tmp/
mv /tmp/bash-* /tmp/bash

pushd /tmp/bash > /dev/null

time
{
  ./configure                          \
    --prefix=/usr                      \
    --build=$(sh support/config.guess) \
    --host=$LFS_TGT                    \
    --without-bash-malloc

  make
  make DESTDIR=$LFS install

  ln -sv bash $LFS/bin/sh
}

popd > /dev/null
rm -rf /tmp/bash
