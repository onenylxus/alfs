#!/bin/bash

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
echo "lfs:lfs" | chpasswd
adduser lfs sudo

chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools,sources}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac

echo 'Defaults secure_path="/tools/bin:/bin:/usr/bin:/sbin:/usr/sbin"' >> /etc/sudoers
echo "lfs ALL = NOPASSWD : ALL" >> /etc/sudoers
echo 'Defaults env_keep += "LFS LC_ALL LFS_TGT PATH MAKEFLAGS"' >> /etc/sudoers

[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
