#!/bin/bash

echo "Building tar..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 42 MB"

tar -xf $LFS/sources/tar-*.tar.xz -C /tmp/
mv /tmp/tar-* /tmp/tar

pushd /tmp/tar > /dev/null

# === ALFS CUSTOM CODE ===
# Chapter 6 is built as root in this project, so tar's configure needs
# FORCE_UNSAFE_CONFIGURE=1 to pass its root check.
FORCE_UNSAFE_CONFIGURE=1 ./configure \
  --prefix=/usr                      \
  --host=$LFS_TGT                    \
  --build=$(build-aux/config.guess)
# === ALFS CUSTOM CODE ===

make
make DESTDIR=$LFS install

popd > /dev/null
rm -rf /tmp/tar
