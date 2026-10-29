#!/bin/bash

echo "Building vim..."
echo "Approximate build time: 3.7 SBU"
echo "Required disk space: 259 MB"

tar -xf /sources/vim-*.tar.gz -C /tmp/
mv /tmp/vim-* /tmp/vim

pushd /tmp/vim > /dev/null

echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

./configure --prefix=/usr

make

make install

ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done

ln -sv ../vim/vim91/doc /usr/share/doc/vim-9.1.1629

cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF

popd > /dev/null
rm -rf /tmp/vim
