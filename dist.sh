#!/bin/bash

which lsb_release > /dev/null 2>&1

if [ $? -eq 0 ]; then
  lsb_release -d | awk -F ":" '{print $2}' | awk '{$1=$1;print}'
else
  hostnamectl | grep "Operating System" | awk -F ":" '{print $2}'| awk '{$1=$1;print}'
fi
