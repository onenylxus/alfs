#!/bin/bash -x

# === ALFS CUSTOM CODE ===
# Run the host checks, prepare the LFS tree, and fetch sources while the
# builder image is created.
set -euo pipefail

sh $LFS_SH/ch2/version-check.sh
sh $LFS_SH/ch2/set-variable.sh

sh $LFS_SH/ch3/download-packages.sh

[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
# === ALFS CUSTOM CODE ===
