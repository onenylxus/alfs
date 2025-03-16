FROM ubuntu:latest

LABEL name="alfs"
LABEL version="0.1.0"
LABEL author="onenylxus"
LABEL description="Automated Linux From Scratch (ALFS)"

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
 && chmod +x **/*.sh\
 && popd > /dev/null

RUN $LFS_SH/ch2/version-check.sh
RUN $LFS_SH/ch2/set-variable.sh
RUN $LFS_SH/ch3/download-packages.sh
RUN $LFS_SH/ch4/create-layout.sh
RUN $LFS_SH/ch4/add-user.sh

USER lfs

WORKDIR /home/lfs

RUN $LFS_SH/ch4/setup-environment.sh
RUN $LFS_SH/ch5/binutils-pass-1.sh
RUN $LFS_SH/ch5/gcc-pass-1.sh
RUN $LFS_SH/ch5/linux-api-headers.sh
RUN $LFS_SH/ch5/glibc.sh
RUN $LFS_SH/ch5/libstdc++.sh
RUN $LFS_SH/ch6/m4.sh
RUN $LFS_SH/ch6/ncurses.sh
RUN $LFS_SH/ch6/bash.sh
RUN $LFS_SH/ch6/coreutils.sh
RUN $LFS_SH/ch6/diffutils.sh
RUN $LFS_SH/ch6/file.sh
RUN $LFS_SH/ch6/findutils.sh
RUN $LFS_SH/ch6/gawk.sh
RUN $LFS_SH/ch6/grep.sh
RUN $LFS_SH/ch6/gzip.sh
RUN $LFS_SH/ch6/make.sh
RUN $LFS_SH/ch6/patch.sh
RUN $LFS_SH/ch6/sed.sh
