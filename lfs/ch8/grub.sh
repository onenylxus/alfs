#!/bin/bash

echo "Building grub..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 166 MB"

tar -xf /sources/grub-*.tar.xz -C /tmp/
mv /tmp/grub-* /tmp/grub

pushd /tmp/grub > /dev/null

unset {C,CPP,CXX,LD}FLAGS

echo depends bli part_gpt > grub-core/extra_deps.lst

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-efiemu  \
            --disable-werror

make

make install
mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

popd > /dev/null
rm -rf /tmp/grub
