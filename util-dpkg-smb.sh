#!/bin/bash -x
sudo apt remove --purge -y samba-common python-samba samba samba-common-bin samba-libs samba-vfs-modules
sudo apt autoremove -y
