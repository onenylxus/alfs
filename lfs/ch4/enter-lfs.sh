#!/bin/bash
#
# Enter the LFS system built into /mnt/lfs by this image.
#
# This is a Docker-only helper: the LFS book mounts the virtual kernel
# filesystems before entering the chroot. The committed image does not keep
# those mounts, so mount them here. The container must be run with
# --privileged.

set -e

for fs in dev proc sys run; do
  install -d "/mnt/lfs/$fs"
  if ! mountpoint -q "/mnt/lfs/$fs"; then
    if ! mount --rbind "/$fs" "/mnt/lfs/$fs"; then
      echo "error: cannot mount /$fs into /mnt/lfs/$fs" >&2
      echo "error: run the container with --privileged" >&2
      exit 1
    fi
  fi
done

# The builder image's WORKDIR does not exist inside the LFS tree. Move to a
# directory that does before chrooting so the login shell starts cleanly.
cd /

exec chroot /mnt/lfs /bin/bash --login "$@"
