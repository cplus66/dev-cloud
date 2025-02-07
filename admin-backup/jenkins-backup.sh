#!/bin/bash -xe

if [ $# -ne 1 ]; then
  echo "$0 backup_filename"  
  exit 1
fi

tar czvf $1 /var/lib/jenkins/jobs/
scp $1 cplus@172.17.5.195:/home/backup/gw
