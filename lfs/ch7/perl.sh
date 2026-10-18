#!/bin/bash

echo "Building perl..."
echo "Approximate build time: 0.6 SBU"
echo "Required disk space: 295 MB"

tar -xf /sources/perl-*.tar.xz -C /tmp/
mv /tmp/perl-* /tmp/perl

pushd /tmp/perl > /dev/null

sh Configure -des                                         \
             -D prefix=/usr                               \
             -D vendorprefix=/usr                         \
             -D useshrplib                                \
             -D privlib=/usr/lib/perl5/5.42/core_perl     \
             -D archlib=/usr/lib/perl5/5.42/core_perl     \
             -D sitelib=/usr/lib/perl5/5.42/site_perl     \
             -D sitearch=/usr/lib/perl5/5.42/site_perl    \
             -D vendorlib=/usr/lib/perl5/5.42/vendor_perl \
             -D vendorarch=/usr/lib/perl5/5.42/vendor_perl

make
make install

popd > /dev/null
rm -rf /tmp/perl
