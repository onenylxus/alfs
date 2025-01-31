FROM ubuntu:latest

LABEL name="lfs"
LABEL version="0.1.0"
LABEL author="onenylxus"
LABEL description="Linux From Scratch (LFS)"

ENV LFS=/lfs
ENV LC_ALL=POSIX
ENV PATH=/tools/bin:/bin:/usr/bin

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

RUN mkdir -pv $LFS/repo\
 && chmod -v a+wt $LFS/repo\
 && ln -sv $LFS/repo /

COPY repo/ $LFS/repo/

RUN bash $LFS/repo/ch2/version-check.sh
