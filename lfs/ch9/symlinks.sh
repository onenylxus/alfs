#!/bin/bash

echo "Managing devices..."

# 9.4.1.2 Creating Custom Udev Rules
#
# This writes /etc/udev/rules.d/70-persistent-net.rules. When LFS is built in
# Docker, /sys describes the container's network interfaces, so the generated
# rule reflects the build environment rather than the target hardware.
bash /usr/lib/udev/init-net-rules.sh
