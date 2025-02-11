#!/bin/bash -x

if [ x$1 == "x" ]; then
  echo "Usage: $1 <IP>"
  exit 0
fi

IP=$1

FORWARD_PORT=$(echo $IP | awk -F "." '{print $4}')

if [ ${FORWARD_PORT} -lt 100 ]; then
  SSH_PORT=500${FORWARD_PORT}
else
  SSH_PORT=50${FORWARD_PORT}
fi

iptables -t nat -A PREROUTING -p tcp -i ens3 --dport $SSH_PORT -j DNAT \
	--to-destination $IP:22
iptables -A FORWARD -p tcp -d $IP --dport $SSH_PORT \
	-m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
