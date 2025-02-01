#!/bin/bash

cd $LFS/sources

dlpkg()
{
  echo "Downloading source packages using wget-list from version $1"
  wget --timestamping "https://www.linuxfromscratch.org/lfs/view/$1/wget-list-sysv"
  wget --timestamping --continue --input-file=wget-list-sysv
  wget --timestamping "https://www.linuxfromscratch.org/lfs/view/$1/md5sums"
}

dlpkg stable
if md5sum -c md5sums
then
  echo "OK:    downloaded source packages"
  exit 0
fi

rm -rf wget-list-sysv md5sums *.tar.*
dlpkg development
if md5sum -c md5sums
then
  echo "OK:    downloaded source packages"
  exit 0
else
  echo "ERROR: source packages failed to verify"
  exit 1
fi
