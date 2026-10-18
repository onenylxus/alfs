#!/bin/bash

echo "Building gettext..."
echo "Approximate build time: 1.5 SBU"
echo "Required disk space: 463 MB"

tar -xf /sources/gettext-*.tar.xz -C /tmp/
mv /tmp/gettext-* /tmp/gettext

pushd /tmp/gettext > /dev/null

./configure --disable-shared

make
cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin

popd > /dev/null
rm -rf /tmp/gettext
