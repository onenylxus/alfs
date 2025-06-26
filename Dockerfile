FROM ubuntu:latest

LABEL name="alfs"
LABEL version="0.1.0"
LABEL author="onenylxus"
LABEL description="Automated Linux From Scratch (ALFS)"

ENV LFS=/mnt/lfs
ENV LFS_SH=/opt/lfs
ENV SOURCES=/opt/sources

WORKDIR /bin

RUN rm sh\
 && ln -sf /bin/bash /bin/sh

RUN apt-get update\
 && apt-get install -y bison build-essential file gawk python3 sudo texinfo wget\
 && apt-get -q -y autoremove\
 && rm -rf /var/lib/apt/lists/*

WORKDIR /home/ubuntu

COPY lfs/ $LFS_SH
COPY sources/ $SOURCES

RUN pushd $LFS_SH/ > /dev/null\
 && chmod +x *.sh\
 && chmod +x **/*.sh\
 && popd > /dev/null

RUN $LFS_SH/prepare.sh

# lfs/ch4/create-layout.sh
RUN mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}\
 && for i in bin lib sbin; do ln -sv usr/$i $LFS/$i; done\
 && case $(uname -m) in\
 x86_64) mkdir -pv $LFS/lib64 ;;\
 esac\
 && mkdir -pv $LFS/tools

# lfs/ch4/add-user.sh
RUN groupadd lfs\
 && useradd -s /bin/bash -g lfs -m -k /dev/null lfs\
 && echo "lfs:lfs" | chpasswd
RUN adduser lfs sudo
RUN chown -v lfs $LFS/{usr{,/*},var,etc,tools}\
 && case $(uname -m) in\
 x86_64) chown -v lfs $LFS/lib64 ;;\
 esac

COPY files/sudoers /etc/sudoers

USER lfs

# lfs/ch4/setup-environment.sh
COPY files/.bash_profile /home/lfs/.bash_profile
COPY files/.bashrc /home/lfs/.bashrc

RUN source ~/.bash_profile

WORKDIR /home/lfs

RUN $LFS_SH/build.sh
