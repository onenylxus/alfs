#!/bin/bash

echo "Building diffutils..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 35 MB"

tar -xf $LFS/sources/diffutils-*.tar.xz -C /tmp/
mv /tmp/diffutils-* /tmp/diffutils

pushd /tmp/diffutils > /dev/null

./configure                         \
  --prefix=/usr                     \
  --host=$LFS_TGT                   \
  gl_cv_func_strcasecmp_works=y     \
  --build=$(./build-aux/config.guess)

make
make DESTDIR=$LFS install

popd > /dev/null
rm -rf /tmp/diffutils

