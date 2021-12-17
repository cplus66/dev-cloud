#!/bin/bash -e

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

function usage()
{
  echo "Usage: $0 <cmd> | $0 -f <shell_script>"
}

if [ x$DEBUG != "x" ]; then
  LIST=yocto-4
fi

if [ $# -eq 0 ]; then
  usage
  exit 0
fi


if [ x$1 == "x-f" ]; then
  if [ x$2 != "x" ]; then
    if [ -f $2 ]; then
      tmpfile=$2
    else
      echo "File $2 doesn't exist" 
    fi
  else
    echo "Usage $0 -f <shell_script>"
    exit 0
  fi
else
  tmpfile=$(mktemp /tmp/mgmt.XXX)
  REMOTE_CMD=$@

  echo $REMOTE_CMD > $tmpfile 
fi

for i in $LIST; do
  echo -n "$i, "
  ssh $i /bin/bash -s < $tmpfile
done

if [ x$REMOTE_CMD != "x" ]; then
  rm -f $tmpfile
fi
