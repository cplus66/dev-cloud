#!/bin/bash -x

which netstat
if [ $? -ne 0 ]; then
  sudo apt install -y net-tools
fi

sudo netstat -nlptu
