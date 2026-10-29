#!/bin/bash

echo "Building texinfo..."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 160 MB"

tar -xf /sources/texinfo-*.tar.xz -C /tmp/
mv /tmp/texinfo-* /tmp/texinfo

pushd /tmp/texinfo > /dev/null

sed 's/! $output_file eq/$output_file ne/' -i tp/Texinfo/Convert/*.pm

./configure --prefix=/usr

make

make install
make TEXMF=/usr/share/texmf install-tex

pushd /usr/share/info
  rm -v dir
  for f in *
    do install-info $f dir 2>/dev/null
  done
popd

popd > /dev/null
rm -rf /tmp/texinfo
