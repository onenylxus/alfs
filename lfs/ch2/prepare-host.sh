#!/bin/bash

export LFS=/mnt/lfs
umask 022

if echo $LFS | grep -q "/mnt/lfs"
then
  echo "OK:    \$LFS variable set"
else
  echo "ERROR: \$LFS variable not set"
  exit 1
fi

if umask | grep -q "022"
then
  echo "OK:    umask set to 022"
else
  echo "ERROR: umask not set to 022"
  exit 1
fi

mkdir -pv $LFS

chown root:root $LFS
chmod 755 $LFS
