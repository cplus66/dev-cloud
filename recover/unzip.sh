#!/bin/bash
# Date: Nov 04, 2019
# Author: cplus.shen
# Description: Usage LIST="" ./unzip.sh
# User: root

if [ "x$LIST" == "x" ]; then
  LIST="atca-9113_2019-1004.tgz  dio-yocto_2019-1004.tgz  esp-9400-terry_2019-1004.tgz esp-3000_2019-1004.tgz"
fi

for i in $LIST; do
  time tar xzvf $i -C /var/lib/libvirt/images/
done
