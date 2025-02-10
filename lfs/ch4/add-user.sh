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
echo 'Defaults env_keep += "LFS LC_ALL LFS_TGT PATH MAKEFLAGS FETCH_TOOLCHAIN_MODE LFS_TEST LFS_DOCS JOB_COUNT LOOP LOOP_DIR IMAGE_SIZE INITRD_TREE IMAGE_RAM IMAGE_BZ2 IMAGE_ISO IMAGE_HDD"' >> /etc/sudoers
