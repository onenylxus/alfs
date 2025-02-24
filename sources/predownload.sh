#!/bin/bash

clean() {
  rm -rf wget-list-sysv md5sums *.tar.* *.patch
}

dlpkg() {
  clean
  wget --timestamping "https://www.linuxfromscratch.org/lfs/view/$1/wget-list-sysv"
  wget --timestamping --input-file=wget-list-sysv --continue
  wget --timestamping "https://www.linuxfromscratch.org/lfs/view/$1/md5sums"
  check
}

check() {
  if md5sum -c md5sums
  then
    echo "OK:    predownloaded source packages"
    exit 0
  fi
}

check
while IFS= read -r option
do
  dlpkg "$option"
done < options.txt

echo "ERROR: source packages failed to verify"
exit 1
