#!/bin/bash -x
(dpkg -l | grep nfs) || true
sudo apt remove --purge -y libnfsidmap2
sudo apt remove --purge -y nfs-common
sudo apt remove --purge -y nfs-kernel-server
sudo apt autoremove -y
