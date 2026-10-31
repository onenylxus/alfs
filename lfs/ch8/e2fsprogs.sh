#!/bin/bash

echo "Building e2fsprogs..."
echo "Approximate build time: 2.4 SBU on a spinning disk, 0.5 SBU on an SSD"
echo "Required disk space: 100 MB"

tar -xf /sources/e2fsprogs-*.tar.gz -C /tmp/
mv /tmp/e2fsprogs-* /tmp/e2fsprogs

pushd /tmp/e2fsprogs > /dev/null

mkdir -v build
cd       build

../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-elf-shlibs \
             --disable-libblkid  \
             --disable-libuuid   \
             --disable-uuidd     \
             --disable-fsck

make

make install

rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
install -v -m644 doc/com_err.info /usr/share/info
install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info

sed 's/metadata_csum_seed,//' -i /etc/mke2fs.conf

popd > /dev/null
rm -rf /tmp/e2fsprogs
