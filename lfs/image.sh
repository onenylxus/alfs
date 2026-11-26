#!/bin/bash
set -euo pipefail

# Run from the repository root so the Docker build context and log path stay
# the same regardless of where this script is invoked from.
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

IMAGE="${IMAGE:-alfs}"
LFS_IMAGE="${LFS_IMAGE:-alfs-lfs:12.4}"
CONTAINER="${CONTAINER:-alfs-build}"
LOG="${LOG:-alfs-build.log}"

docker build -t "$IMAGE" .

# Remove a stale container left by an interrupted build.
docker rm -f "$CONTAINER" >/dev/null 2>&1 || true

docker_args=(--name "$CONTAINER" --privileged)
if [ -n "${LFS_DISK:-}" ]; then
  docker_args+=(-e "LFS_DISK=$LFS_DISK")
fi

# Do not use --rm: the stopped container is the build result and is committed
# to an image below.
set +e
docker run "${docker_args[@]}" "$IMAGE" 2>&1 | tee "$LOG"
status=${PIPESTATUS[0]}
set -e

if [ "$status" -ne 0 ]; then
  echo "Build failed with exit status $status." >&2
  echo "Container '$CONTAINER' left for inspection; remove it with: docker rm -f $CONTAINER" >&2
  exit "$status"
fi

docker commit \
  --change 'USER root' \
  --change 'WORKDIR /' \
  --change 'ENTRYPOINT ["/usr/local/bin/enter-lfs"]' \
  "$CONTAINER" "$LFS_IMAGE"
docker rm "$CONTAINER" >/dev/null

echo "Created Docker image: $LFS_IMAGE"
echo "Enter the LFS system with:"
echo "  docker run -it --rm --privileged $LFS_IMAGE"
