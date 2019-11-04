#!/bin/bash -x

case "$1" in
  apt-update)
  ssh kvm-1    "sudo apt-get update"
  ssh kvm-2    "sudo apt-get update"
  ssh docker-1 "sudo apt-get update"
  ssh docker-2 "sudo apt-get update"
  ;;

  kvm-install)
  sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst libguestfs-tools
  ;;

esac
