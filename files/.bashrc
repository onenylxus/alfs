# lfs/ch4/setup-environment.sh
# cannot run this as shell script in Dockerfile

set +h
umask 022

LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu

PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH

CONFIG_SITE=$LFS/usr/share/config.site
MAKEFLAGS=-j$(nproc)

export LFS LC_ALL LFS_TGT PATH CONFIG_SITE MAKEFLAGS
