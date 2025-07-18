#!/bin/bash

set -e
echo "Building ncurses..."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 53 MB"

tar -xf $LFS/sources/ncurses-*.tar.gz -C /tmp/
mv /tmp/ncurses-* /tmp/ncurses

pushd /tmp/ncurses > /dev/null

mkdir build
pushd build
  ../configure AWK=gawk
  make -C include
  make -C progs tic
popd

./configure                    \
  --prefix=/usr                \
  --host=$LFS_TGT              \
  --build=$(./config.guess)    \
  --mandir=/usr/share/man      \
  --with-manpage-format=normal \
  --with-shared                \
  --without-normal             \
  --with-cxx-shared            \
  --without-debug              \
  --without-ada                \
  --disable-stripping          \
  AWK=gawk

make
make DESTDIR=$LFS TIC_PATH=$(pwd)build/progs/tic install
ln -sv libncursesw.so $LFS/usr/lib/libncurses.so
sed -e 's/^#if.*XOPEN.*$/#if 1/' \
  -i $LFS/usr/include/curses.h

popd > /dev/null
rm -rf /tmp/ncurses
