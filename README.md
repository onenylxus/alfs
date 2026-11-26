# alfs

Automated Linux From Scratch (ALFS) in Docker.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE.md)

ALFS builds a Linux From Scratch system inside a Docker container and saves the
result as a Docker image. It is a practical way to learn how LFS works, try
changes safely, and produce a repeatable build without partitioning a disk or
rebooting your machine.

## Features

- One-command build of the full LFS system.
- Runs in a privileged Docker container, so the host system stays clean.
- Saves the finished LFS tree as a reusable Docker image.
- Keeps the LFS book commands recognizable. ALFS-specific shell code is marked
  with `=== ALFS CUSTOM CODE ===` banners.
- Supports optional GRUB installation to a disk or loop device.

## Requirements

- A Linux host with Docker Engine installed.
- Permission to run `docker` commands (root or membership in the `docker`
  group).
- Support for `--privileged` containers. The build needs `mount` and `chroot`.
- At least 30 GB of free disk space for the LFS tree and Docker layers.
- Several hours of build time, depending on CPU and disk speed.
- Network access to install the build packages and fetch source tarballs. The
  source download step is skipped when `sources/` is already populated.

## Quick Start

Clone the repository and enter it:

```bash
git clone https://github.com/onenylxus/alfs.git
cd alfs
```

Build the LFS system and save it as a Docker image:

```bash
./lfs/image.sh
```

The script builds the builder image, runs the LFS build in a privileged
container, and commits the result to the image `alfs-lfs`. Enter the LFS system
with:

```bash
docker run -it --rm --privileged alfs-lfs
```

You are now in a shell inside the LFS system.

## How It Works

1. `lfs/image.sh` builds a builder image with the host tools, the LFS
   directory layout, the `lfs` user, and the source packages.
2. It then starts a privileged container from that image.
3. `lfs/build.sh` runs the LFS chapter scripts in order.
4. When the build succeeds, the script commits the stopped container to the
   `alfs-lfs` image.
5. `lfs/ch4/enter-lfs.sh` becomes the image entrypoint. It mounts the virtual
   kernel filesystems and starts a login shell in the chroot.

## Project Structure

```text
.
├── Dockerfile              # Builder image definition
├── files/                  # Shell environment and sudo configuration
├── lfs/
│   ├── image.sh            # Build the LFS image
│   ├── build.sh            # Run the LFS build inside the container
│   ├── prepare.sh          # Host checks and source preparation
│   ├── ch2/ ... ch10/      # LFS chapter scripts
│   └── ch4/enter-lfs.sh    # Entrypoint for the finished image
├── sources/                # Source tarballs and download helpers
└── LICENSE.md
```

## Configuration

`lfs/image.sh` reads these environment variables:

| Variable | Default | Purpose |
| --- | --- | --- |
| `IMAGE` | `alfs` | Builder image tag |
| `LFS_IMAGE` | `alfs-lfs` | Output LFS image tag |
| `CONTAINER` | `alfs-build` | Build container name |
| `LOG` | `alfs-build.log` | Build log path |
| `LFS_DISK` | unset | Disk or loop device for `grub-install` |

Examples:

```bash
IMAGE=my-alfs ./lfs/image.sh
LFS_IMAGE=my-lfs:latest ./lfs/image.sh
LFS_DISK=/dev/loop0 ./lfs/image.sh
```

## Source Packages

The Docker build uses the tarballs in `sources/`. If they are missing,
`lfs/ch3/download-packages.sh` downloads them automatically. To download them
ahead of time, run:

```bash
./sources/predownload.sh
```

The LFS views to try are listed in `sources/options.txt`.

## Build Logs and Troubleshooting

`lfs/image.sh` writes the build log to `alfs-build.log` in the repository root.

If a step fails, the build stops and leaves the stopped container in place so
you can inspect it:

```bash
docker logs alfs-build
```

Remove the container when you are done:

```bash
docker rm -f alfs-build
```

The script checks the container's exit status, so a failed build is not hidden
by `tee`.

## GRUB

LFS normally installs GRUB to `/dev/sda`. Inside Docker, `/dev/sda` is the host
disk, so `grub-install` is skipped unless `LFS_DISK` is set:

```bash
LFS_DISK=/dev/loop0 ./lfs/image.sh
```

`/boot/grub/grub.cfg` is always created. To make a bootable disk, install GRUB
against the target disk or loop device and copy the LFS tree to it.

## Manual Build

To build only the builder image:

```bash
docker build -t alfs .
```

To run the build without saving an image:

```bash
docker run --rm --name alfs-build --privileged alfs 2>&1 | tee alfs-build.log
```

This discards the LFS tree when the container exits.

## Docker-Specific Notes

The build follows the LFS book except where Docker makes the book's commands
impossible or unsafe:

- The kernel is configured with `make defconfig` plus the required
  `scripts/config` settings instead of the interactive `make menuconfig`.
- `grub-install` is skipped unless `LFS_DISK` is set. `/boot/grub` is created
  explicitly so `grub.cfg` can still be written.
- Package scripts run with `errexit`. `strip` errors on non-ELF files are
  ignored because the book's stripping loop also tolerates them.
- The result is committed to a Docker image instead of being installed on a
  disk. The image keeps the LFS tree at `/mnt/lfs`.
- The optional `/etc/lfs-release`, `/etc/lsb-release`, and `/etc/os-release`
  files are not created; the book marks them optional. The build ends after
  the bootable-system chapter.

## Contributing

Issues and pull requests are welcome. Please keep changes focused and describe
which LFS step or Docker behavior they affect.

## License

The ALFS code in this repository is licensed under the MIT License. See
[LICENSE.md](LICENSE.md).

The Linux From Scratch book is licensed under Creative Commons
Attribution-NonCommercial-ShareAlike 2.0. The book explicitly allows computer
instructions to be extracted under the MIT License, which is why this project
can use MIT.

## Acknowledgements

- The Linux From Scratch project and its contributors.
- The LFS book, which provides the build instructions this project automates.
