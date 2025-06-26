#!/bin/bash -x

set -e

$LFS_SH/ch2/version-check.sh
$LFS_SH/ch2/set-variable.sh
$LFS_SH/ch3/download-packages.sh

[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
