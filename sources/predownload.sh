#!/bin/bash

rm -rf wget-list-sysv md5sums *.tar.* *.patch

wget --timestamping "https://www.linuxfromscratch.org/lfs/view/development/wget-list-sysv"
wget --timestamping --input-file=wget-list-sysv --continue
wget --timestamping "https://www.linuxfromscratch.org/lfs/view/development/md5sums"

if md5sum -c md5sums
then
  echo "OK:    predownloaded source packages"
  exit 0
else
  echo "ERROR: source packages failed to verify"
  exit 1
fi
