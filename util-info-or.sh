#!/bin/bash
# Ubuntu 20.04.4 LTS, 40, 65739740 kB, 1.8T, 1011G, 729G, 59%, 

linux_dist()
{
  cat /etc/issue | head -n 1 | awk '{print $1 " " $2 " " $3}'
}

cpu()
{
  cat /proc/cpuinfo | grep processor | wc | awk '{print $1}'
}

mem()
{
  free -h | egrep "^Mem:" | awk '{print $2}'
}

#/dev/sdb1                                               3.6T  2.8T  660G  82% /opt
disk_total()
{
  df -h | egrep "/opt$" | awk '{print $2}'
}

disk_used()
{
  df -h | egrep "/opt$" | awk '{print $3}'
}

disk_available()
{
  df -h | egrep "/opt$" | awk '{print $4}'
}

disk_used_percent()
{
  df -h | egrep "/opt$" | awk '{print $5}'
}

LINUX_DIST=$(linux_dist)
CPU=$(cpu)
MEM=$(mem)
DISK_TOTAL=$(disk_total)
DISK_USED=$(disk_used)
DISK_AVAILABLE=$(disk_available)
DISK_USED_PERCENT=$(disk_used_percent)

echo "$LINUX_DIST, $CPU, $MEM, $DISK_TOTAL, $DISK_USED, $DISK_AVAILABLE, $DISK_USED_PERCENT",
