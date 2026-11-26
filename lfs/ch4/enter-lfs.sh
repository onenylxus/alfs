#!/bin/bash

# === ALFS CUSTOM CODE ===
# Docker-only helper: mount the virtual kernel filesystems into /mnt/lfs and
# enter the LFS chroot. The committed image does not keep those mounts, and
# the container must be run with --privileged.
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
# === ALFS CUSTOM CODE ===
