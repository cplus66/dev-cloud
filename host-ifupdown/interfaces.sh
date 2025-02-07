#!/bin/bash -x

case "$1" in
  sync)
  scp kvm-1:/etc/network/interfaces interfaces-kvm-1
  scp kvm-2:/etc/network/interfaces interfaces-kvm-2
  scp docker-1:/etc/network/interfaces interfaces-docker-1
  scp docker-2:/etc/network/interfaces interfaces-docker-2
  ;;

  diff)
  diff -u interfaces-kvm-1 interfaces-kvm-2
  diff -u interfaces-kvm-1 interfaces-docker-1
  diff -u interfaces-kvm-1 interfaces-docker-2
  ;;
esac
