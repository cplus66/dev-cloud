# Host List
```
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
```

# Prerequisite
```
# apt install -y bridge-utils
# apt install -y ifupdown
# apt install -y vlan
# modprobe 8021q
# git clone https://github.com/cplus66/dev-cloud.git
# cd dev-cloud
# cp fs/etc/network/interface /etc/network/
```

# VM Network Configuration
## Ubuntu
```
CPU=8 RAM=16384 NET=br1 ~cplus/virt-utils/virt-install.sh vm_name image_name


```

## CentOS
```
mv /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0.orig
cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
BOOTPROTO="none"
DEVICE="eth0"
ONBOOT="yes"
TYPE="Ethernet"
EOF

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0.1001
DEVICE=eth0.1001
BOOTPROTO=none
ONBOOT=yes
IPADDR=192.168.10.12
PREFIX=24
NETWORK=192.168.10.0
VLAN=yes
EOF

cat << EOF > /etc/sysconfig/network
NETWORKING=yes
NOZEROCONF=yes
GATEWAY=192.168.10.1
EOF

```
