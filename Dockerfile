FROM ubuntu:latest

LABEL name="lfs"
LABEL version="0.1.0"
LABEL author="onenylxus"
LABEL description="Linux From Scratch (LFS)"

ENV USER_DIR=/home/ubuntu
ENV HOST_LFS=$USER_DIR/lfs

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

RUN mkdir -pv $HOST_LFS\
 && chmod -v a+wt $HOST_LFS\
 && ln -sv $HOST_LFS /

COPY lfs/ $HOST_LFS/

RUN bash $HOST_LFS/ch2/version-check.sh
RUN bash $HOST_LFS/ch2/prepare-host.sh
RUN bash $HOST_LFS/ch3/download-packages.sh
