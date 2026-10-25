#!/bin/bash

echo "Building ninja..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 43 MB"

tar -xf /sources/ninja-*.tar.gz -C /tmp/
mv /tmp/ninja-* /tmp/ninja

pushd /tmp/ninja > /dev/null

export NINJAJOBS=4

sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc

python3 configure.py --bootstrap --verbose

install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja

popd > /dev/null
rm -rf /tmp/ninja
