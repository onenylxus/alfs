#!/bin/bash

echo "Building perl..."
echo "Approximate build time: 1.3 SBU"
echo "Required disk space: 257 MB"

tar -xf /sources/perl-*.tar.xz -C /tmp/
mv /tmp/perl-* /tmp/perl

pushd /tmp/perl > /dev/null

export BUILD_ZLIB=False
export BUILD_BZIP2=0

sh Configure -des                                          \
             -D prefix=/usr                                \
             -D vendorprefix=/usr                          \
             -D privlib=/usr/lib/perl5/5.42/core_perl      \
             -D archlib=/usr/lib/perl5/5.42/core_perl      \
             -D sitelib=/usr/lib/perl5/5.42/site_perl      \
             -D sitearch=/usr/lib/perl5/5.42/site_perl     \
             -D vendorlib=/usr/lib/perl5/5.42/vendor_perl  \
             -D vendorarch=/usr/lib/perl5/5.42/vendor_perl \
             -D man1dir=/usr/share/man/man1                \
             -D man3dir=/usr/share/man/man3                \
             -D pager="/usr/bin/less -isR"                 \
             -D useshrplib                                 \
             -D usethreads

make

make install
unset BUILD_ZLIB BUILD_BZIP2

popd > /dev/null
rm -rf /tmp/perl
