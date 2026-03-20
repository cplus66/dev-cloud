#!/bin/bash -xe

sudo apt-get update
sudo bash -c "DEBIAN_FRONTEND=noninteractive apt-get -y upgrade"
sudo apt-get autoremove -y
sudo apt-get clean
