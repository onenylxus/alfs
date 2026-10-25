#!/bin/bash

echo "Building XML::Parser..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 2.4 MB"

tar -xf /sources/XML-Parser-*.tar.gz -C /tmp/
mv /tmp/XML-Parser-* /tmp/XML-Parser

pushd /tmp/XML-Parser > /dev/null

perl Makefile.PL

make

make install

popd > /dev/null
rm -rf /tmp/XML-Parser
