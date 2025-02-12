#!/bin/bash

mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

clean()
{
  rm -rf wget-list-sysv md5sums *.tar.* *.patch
}

pdlchk()
{
  local result=1
  pushd $SOURCES > /dev/null

  if md5sum -c md5sums
  then
    result=0
    mv * $LFS/sources
    clean
  fi

  popd > /dev/null
  return $result
}

dlpkg()
{
  clean
  wget --timestamping "https://www.linuxfromscratch.org/lfs/view/$1/wget-list-sysv"
  wget --timestamping --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources
  wget --timestamping "https://www.linuxfromscratch.org/lfs/view/$1/md5sums"
}

if pdlchk
then
  echo "OK:    predownload source packages found"
  chown root:root $LFS/sources/*
  exit 0
fi

dlpkg stable
if md5sum -c md5sums
then
  echo "OK:    downloaded source packages"
  chown root:root $LFS/sources/*
  exit 0
fi

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
