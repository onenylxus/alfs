#!/bin/bash

LC_ALL=C
PATH=/usr/bin:/bin

bail()
{
  echo "FATAL: $1"
  exit 1
}

grep --version > /dev/null 2> /dev/null || bail "grep not working"
sed '' /dev/null || bail "sed not working"
sort /dev/null || bail "sort not working"

pkgver()
{
  if ! type -p $2 &>/dev/null
  then
    echo "ERROR: $2 not found ($1)"
    return 1
  fi

  v=$($2 --version 2>&1 | grep -E -o '[0-9]+\.[0-9\.]+[a-z]*' | head -n 1)

  if printf '%s\n' $3 $v | sort --version-sort --check &>/dev/null
  then
    printf "OK:    %-9s %-8s >= $3\n" "$1" "$v"
    return 0
  else
    printf "ERROR: %-9s is outdated, $3 or later required\n" "$1"
    return 1
  fi
}

pkgver coreutils sort 8.1 || bail "coreutils is outdated"
pkgver bash bash 3.2
pkgver binutils ld 2.13.1
pkgver bison bison 2.7
pkgver diffutils diff 2.8.1
pkgver findutils find 4.2.31
pkgver gawk gawk 4.0.1
pkgver gcc gcc 5.2
pkgver g++ g++ 5.2
pkgver grep grep 2.5.1a
pkgver gzip gzip 1.3.12
pkgver m4 m4 1.4.10
pkgver make make 4.0
pkgver patch patch 2.5.4
pkgver perl perl 5.8.8
pkgver python python3 3.4
pkgver sed sed 4.1.5
pkgver tar tar 1.22
pkgver texinfo texi2any 5.0
pkgver xz xz 5.0.0

krnver()
{
  v=$(uname -r | grep -E -o '^[0-9\.]+')

  if printf '%s\n' $1 $v | sort --version-sort --check &>/dev/null
  then
    printf "OK:    %-9s %-8s >= $1\n" kernel "$v"
    return 0
  else
    printf "ERROR: kernel is outdated, $1 or later required\n" "$v"
    return 1
  fi
}

krnver 4.19

if mount | grep -q 'devpts on /dev/pts' && [ -e /dev/ptmx ]
then
  echo "OK:    kernel supports unix98 pty"
else
  echo "ERROR: kernel does not support unix98 pty"
fi

alschk()
{
  if $1 --version 2>&1 | grep -qi $2
  then
    printf "OK:    %-4s is alias of $2\n" "$1"
  else
    printf "ERROR: %-4s is not alias of $2\n" "$1"
  fi
}

alschk awk gnu
alschk yacc bison
alschk sh bash

if printf "int main(){}" | g++ -x c++ -
then
  echo "OK:    g++ working"
else
  echo "ERROR: g++ not working"
fi
rm -f a.out

if [ "$(nproc)" = "" ]
then
  echo "ERROR: nproc not available or produces empty output"
else
  echo "OK:    nproc reports $(nproc) cores are available"
fi
