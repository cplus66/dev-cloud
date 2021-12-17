#!/bin/bash -x
LIST="atca-9113-wr8-2 \
bcn-ipv6-0 \
bcn-ipv6-1 \
dio-yocto-2 \
esp-3000-ubu14-0 \
esp-9010-deb10-1 \
esp-9010b-1 \
jetpack-0 \
jetpack-1 \
jetpack-2 \
jetpack-3 \
jetpack-4 \
vega-3500-sc-0 \
yocto-0 \
yocto-1 \
yocto-2 \
yocto-3 \
yocto-4 \
"

if [ $# -eq 0 ]; then
  echo "Usage: $0 <cmd>"
  exit 0
fi

for i in $LIST; do
  ssh $i $@
done
