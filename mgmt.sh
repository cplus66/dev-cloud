#!/bin/bash -x

case "$1" in
  apt-update)
  ssh kvm-1    "sudo apt-get update"
  ssh kvm-2    "sudo apt-get update"
  ssh docker-1 "sudo apt-get update"
  ssh docker-2 "sudo apt-get update"
  ;;
  hosts)
  ssh kvm-1    'sudo bash -c "echo \"172.17.5.235 ga\" >> /etc/hosts"'

esac
