#!/bin/bash

which lsb_release > /dev/null 2>&1

if [ $? -eq 0 ]; then
  LINUX_DIST=$(lsb_release -d | awk -F ":" '{print $2}' | awk '{$1=$1;print}')
else
  LINUX_DIST=$(hostnamectl | grep "Operating System" | awk -F ":" '{print $2}'| awk '{$1=$1;print}')
fi

# CPU number 
CPU_NUM=$(cat /proc/cpuinfo  | grep "^processor" | wc | awk '{print $1}')

# Memory info
MEM_SIZE=$(cat /proc/meminfo | grep "MemTotal:" | awk -F ":" '{print $2 $3}' | awk '{print $1,$2}')

# Disk Size
DISK_SIZE=$(df -h | egrep "sdb1$" | awk '{print $2}')

# Disk Used
DISK_USED=$(df -h | egrep "sdb1$" | awk '{print $3}')

# Disk Available
DISK_AVAIL=$(df -h | egrep "sdb1$" | awk '{print $4}')

# Disk Usage
DISK_USAGE=$(df -h | egrep "sdb1$" | awk '{print $5}')

echo "$LINUX_DIST, $CPU_NUM, $MEM_SIZE, $DISK_SIZE, $DISK_USED, $DISK_AVAIL, $DISK_USAGE, "
