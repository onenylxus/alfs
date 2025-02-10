FROM ubuntu:latest

LABEL name="lfs"
LABEL version="0.1.0"
LABEL author="onenylxus"
LABEL description="Linux From Scratch (LFS)"

ENV LFS_SH=/home/ubuntu/lfs

WORKDIR /bin

RUN rm sh \
 && ln -sf /bin/bash /bin/sh

RUN apt-get update           \
 && apt-get install -y       \
    bison                    \
    build-essential          \
    file                     \
    gawk                     \
    python3                  \
    sudo                     \
    texinfo                  \
    wget                     \
 && apt-get -q -y autoremove \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /home/ubuntu

RUN mkdir -pv lfs     \
 && chmod -v a+wt lfs \
 && ln -sv lfs /

COPY lfs/ lfs/

RUN bash $LFS_SH/ch2/version-check.sh
RUN bash $LFS_SH/ch2/prepare-host.sh
RUN bash $LFS_SH/ch3/download-packages.sh
RUN bash $LFS_SH/ch4/create-layout.sh
RUN bash $LFS_SH/ch4/add-user.sh

USER lfs
COPY .bash_profile .bashrc /home/lfs/
RUN source ~/.bash_profile

WORKDIR /home/lfs

RUN bash $LFS_SH/ch5/binutils-pass-1.sh
