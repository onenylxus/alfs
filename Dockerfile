FROM ubuntu:latest

LABEL name="lfs"
LABEL version="0.1.0"
LABEL author="onenylxus"
LABEL description="Linux From Scratch (LFS)"

ENV USER_DIR=/home/ubuntu
ENV LFS_DIR=/home/lfs
ENV SH_LFS=$USER_DIR/lfs

WORKDIR /bin

RUN rm sh\
 && ln -sf /bin/bash /bin/sh

RUN apt-get update\
 && apt-get install -y\
 bison\
 build-essential\
 file\
 gawk\
 python3\
 sudo\
 texinfo\
 wget\
 && apt-get -q -y autoremove\
 && rm -rf /var/lib/apt/lists/*

WORKDIR $USER_DIR

RUN mkdir -pv $SH_LFS\
 && chmod -v a+wt $SH_LFS\
 && ln -sv $SH_LFS /

COPY lfs/ $SH_LFS/

RUN bash $SH_LFS/ch2/version-check.sh
RUN bash $SH_LFS/ch2/prepare-host.sh
RUN bash $SH_LFS/ch3/download-packages.sh
RUN bash $SH_LFS/ch4/create-layout.sh
RUN bash $SH_LFS/ch4/add-user.sh

USER lfs
COPY .bash_profile .bashrc $LFS_DIR/
RUN source ~/.bash_profile

WORKDIR $LFS_DIR

