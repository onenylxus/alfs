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

sed '/thread_header =/s/@.*@/gthr-posix.h/' \
  -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir -v build
cd build

../configure                                \
  --build=$(../config.guess)                \
  --host=$LFS_TGT                           \
  --target=$LFS_TGT                         \
  LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc \
  --prefix=/usr                             \
  --with-build-sysroot=$LFS                 \
  --enable-default-pie                      \
  --enable-default-ssp                      \
  --disable-nls                             \
  --disable-multilib                        \
  --disable-libatomic                       \
  --disable-libgomp                         \
  --disable-libquadmath                     \
  --disable-libsanitizer                    \
  --disable-libssp                          \
  --disable-libvtv                          \
  --enable-languages=c,c++

make
make DESTDIR=$LFS install

ln -sv gcc $LFS/usr/bin/cc

popd > /dev/null
rm -rf /tmp/gcc

