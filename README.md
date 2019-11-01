= Host List
SWITCH

JUMP-HOST

HOST-0
  #ERR: SAS

HOST-1
  Name: kvm-1
  IP: 172.17.4.254
  Description: KVM Development

HOST-2
  Name: kvm-2
  IP: 172.17.4.11
  Description: KVM Development

HOST-3
  #ERR: VGA

HOST-4
  Name: docker-1
  IP: 172.17.5.1 
  Description: Docker Development

HOST-5
  Name: docker-2
  IP: 172.17.5.39
  Description: Docker Development


= Prerequisite
```
# apt install -y bridge-utils
# apt install -y ifupdown
# apt install -y vlan
# modprobe 8021q
# git clone https://github.com/cplus66/dev-cloud.git
# cd dev-cloud
# cp fs/etc/network/interface /etc/network/
```
