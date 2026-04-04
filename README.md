# alfs

Automated Linux From Scratch (ALFS)

## Build Docker Image

From the repository root:

```bash
docker build -t alfs .
```

## Run Container

The image `ENTRYPOINT` runs `/opt/lfs/build.sh`, which executes the ALFS build steps automatically.

```bash
docker run --rm --name alfs-build alfs
```

### (Optional) Save Build Logs

```bash
docker run --rm --name alfs-build alfs | tee alfs-build.log
```

### (Optional) Interactive Debug Shell

To inspect the image without running the default `ENTRYPOINT`:

```bash
docker run --rm -it --entrypoint /bin/bash alfs
```

## Notes

- The build can take a long time depending on host resources.
- Re-run with `docker build --no-cache -t alfs .` if you need a clean image build.
