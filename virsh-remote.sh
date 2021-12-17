#!/bin/bash
LIST="kvm-1 kvm-2 kvm-3 docker-1 docker-2"

function usage()
{
  echo "$0 <command>"
}

if [ $# -eq 0 ]; then
  usage
  exit 0
fi

for i in $LIST; do
  echo "[$i]"
  virsh -c qemu+ssh://$i/system $@
done
