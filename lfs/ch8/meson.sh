#!/bin/bash

echo "Building meson..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 45 MB"

tar -xf /sources/meson-*.tar.gz -C /tmp/
mv /tmp/meson-* /tmp/meson

pushd /tmp/meson > /dev/null

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links dist meson
install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson

popd > /dev/null
rm -rf /tmp/meson
