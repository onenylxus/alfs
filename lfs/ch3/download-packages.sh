#!/bin/bash

mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
cd $LFS/sources

dlpkg()
{
  wget --timestamping "https://www.linuxfromscratch.org/lfs/view/$1/wget-list-sysv"
  wget --timestamping --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources
  wget --timestamping "https://www.linuxfromscratch.org/lfs/view/$1/md5sums"
}

dlpkg stable
if md5sum -c md5sums
then
  echo "OK:    downloaded source packages"
  chown root:root $LFS/sources/*
  exit 0
fi

rm -rf wget-list-sysv md5sums *.tar.*
dlpkg development
if md5sum -c md5sums
then
  echo "OK:    downloaded source packages"
  chown root:root $LFS/sources/*
  exit 0
else
  echo "ERROR: source packages failed to verify"
  exit 1
fi
