#!/bin/bash

IF_NAME=br0

function rx_packet_count() {
  /sbin/ifconfig $IF_NAME | grep "RX packets" | awk '{print $3}' 
}

function tx_packet_count() {
  /sbin/ifconfig $IF_NAME | grep "TX packets" | awk '{print $3}'
}

while true; do
  PRE_RX=$(rx_packet_count)
  PRE_TX=$(tx_packet_count)
  sleep 1
  NOW_RX=$(rx_packet_count)
  NOW_TX=$(tx_packet_count)
  echo RX,$(expr $NOW_RX - $PRE_RX),TX,$(expr $NOW_TX - $PRE_TX)
done
