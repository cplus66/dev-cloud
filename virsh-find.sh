#!/bin/bash
LIST=$(cat host-server.conf | grep -v or)

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
  virsh -c qemu+ssh://$i/system domblklist $1 | grep "\S"
  if [ $? -eq 0 ]; then
    break
  fi
done
