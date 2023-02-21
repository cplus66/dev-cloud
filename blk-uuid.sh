#!/bin/bash

usage()
{
  echo "$0 <disk device>"
}

if [ x"$1" == "x" ]; then
  usage
  exit 0
fi

blkid -o value -s UUID $1
