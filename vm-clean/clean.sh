#!/bin/bash -xe

sudo rm -rf ~/workspace/*

FREE_KB=$(df | egrep "/$" | awk '{printf $4}')
FREE_MB=$(expr $FREE_KB / 1024 - 1)

dd if=/dev/zero of=zero.bin bs=1M count=$FREE_MB

rm -f zero.bin
sync
