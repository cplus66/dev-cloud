#!/bin/bash -e

LIST=$(cat host-vm.conf)

SERVER_LIST=$(cat host-server.conf)

function usage()
{
  echo "Usage: {DEBUG=1} {SERVER=1} {CSV=1} {MY_LIST=list} $0 <cmd> | $0 -f <shell_script>"
}

if [ "x$DEBUG" != "x" ]; then
  LIST=yocto-0
fi

if [ "x$SERVER" != "x" ]; then
  LIST=$SERVER_LIST
fi

if [ "x$MY_LIST" != "x" ]; then
  LIST=$MY_LIST
fi

if [ $# -eq 0 ]; then
  usage
  exit 0
fi


if [ "x$1" == "x-f" ]; then
  if [ "x$2" != "x" ]; then
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
  # print header
  if [ "x$CSV" != "x" ]; then
    echo -n "$i, "
  else
    echo "[$i]"
  fi

  if [ $i == "or" ]; then
    ssh $i /bin/bash -s < util-info-or.sh
  elif [ $i == "mic-server" ]; then
    ssh $i /bin/bash -s < util-info-mic-server.sh
  else
    ssh $i /bin/bash -s < $tmpfile
  fi
done

if [ "x$REMOTE_CMD" != "x" ]; then
  rm -f $tmpfile
fi
