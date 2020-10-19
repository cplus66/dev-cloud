#!/bin/bash -xe

HOST_LIST="atca-9113-wr8-2 bcn-ipv6-0 dio-yocto-2 esp-3000-ubu14-0 esp-9010-deb8-0 esp-9010-deb10-1 esp-9010b-1 yocto-0"

if [ $# -ne 1 ]; then
  echo "Usage: $0 <file>"
  exit
fi

for i in $HOST_LIST; do
  rsync -av $1 $i:
done

exit  0
