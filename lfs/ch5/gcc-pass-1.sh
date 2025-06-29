#!/bin/bash

set -e
echo "Building gcc (pass 1)..."
echo "Approximate build time: 3.2 SBU"
echo "Required disk space: 4.8 GB"

tar -xf $LFS/sources/gcc-*.tar.xz -C /tmp/
mv /tmp/gcc-* /tmp/gcc

pushd /tmp/gcc > /dev/null

tar -xf $LFS/sources/mpfr-*.tar.xz
mv -v mpfr-* mpfr
tar -xf $LFS/sources/gmp-*.tar.xz
mv -v gmp-* gmp
tar -xf $LFS/sources/mpc-*.tar.gz
mv -v mpc-* mpc

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
      -i.orig gcc/config/i386/t-linux64
  ;;
esac

mkdir -v build
cd build

../configure                \
  --target=$LFS_TGT         \
  --prefix=$LFS/tools       \
  --with-glibc-version=2.40 \
  --with-sysroot=$LFS       \
  --with-newlib             \
  --without-headers         \
  --enable-default-pie      \
  --enable-default-ssp      \
  --disable-nls             \
  --disable-shared          \
  --disable-multilib        \
  --disable-threads         \
  --disable-libatomic       \
  --disable-libgomp         \
  --disable-libquadmath     \
  --disable-libssp          \
  --disable-libvtv          \
  --disable-libstdcxx       \
  --enable-languages=c,c++

make
make install

cd ..
cat gcc/limitx.h gg/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

popd > /dev/null
rm -rf /tmp/gcc

