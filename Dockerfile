# use ubuntu as image
FROM ubuntu:24.04

# image information
LABEL name="alfs"
LABEL version="0.1.0"
LABEL author="onenylxus"
LABEL description="Automated Linux From Scratch (ALFS)"

# LFS variables
ENV LFS=/mnt/lfs
ENV LFS_SH=/opt/lfs
ENV SOURCES=/opt/sources

WORKDIR /bin

# set bash as default shell
RUN rm sh\
 && ln -sf /bin/bash /bin/sh

# install packages
RUN apt-get update\
 && apt-get install -y bison build-essential file gawk python3 sudo texinfo wget\
 && apt-get -q -y autoremove\
 && rm -rf /var/lib/apt/lists/*

WORKDIR /home/ubuntu

# copy files
COPY lfs/ $LFS_SH
COPY sources/ $SOURCES

# give permissions to scripts
RUN pushd $LFS_SH/ > /dev/null\
 && chmod +x *.sh\
 && popd > /dev/null

# perform LFS/2-3
RUN $LFS_SH/prepare.sh

# perform LFS/4.2 (Creating a Limited Directory Layout in the LFS Filesystem)
RUN mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}\
 && for i in bin lib sbin; do ln -sv usr/$i $LFS/$i; done\
 && case $(uname -m) in\
 x86_64) mkdir -pv $LFS/lib64 ;;\
 esac\
 && mkdir -pv $LFS/tools

# perform LFS/4.3 (Adding the LFS User)
RUN groupadd lfs\
 && useradd -s /bin/bash -g lfs -m -k /dev/null lfs\
 && echo "lfs:lfs" | chpasswd
RUN adduser lfs sudo
RUN chown -v lfs $LFS/{usr{,/*},var,etc,tools}\
 && case $(uname -m) in\
 x86_64) chown -v lfs $LFS/lib64 ;;\
 esac\
 && chown -v lfs $LFS_SH

COPY files/sudoers /etc/sudoers

USER lfs

# perform LFS/4.4 (Setting Up the Environment)
COPY files/.bash_profile /home/lfs/.bash_profile
COPY files/.bashrc /home/lfs/.bashrc
RUN source ~/.bash_profile

# perform the rest of LFS process
ENTRYPOINT ["/opt/lfs/build.sh"]
