#!/bin/bash

echo "Cleaning up and saving the temporary system..."

rm -rf /usr/share/{info,man,doc}/*

find /usr/{lib,libexec} -name \*.la -delete

rm -rf /tools
