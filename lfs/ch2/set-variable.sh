#!/bin/bash

# export LFS=/mnt/lfs
umask 022

mkdir -pv $LFS

chown root:root $LFS
chmod 755 $LFS
