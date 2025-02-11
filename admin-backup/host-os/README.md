# Host OS

## KVM-1

- /etc/network/interfaces

```
auto lo br0 br1 br1.1001

iface enp6s0 inet manual
iface ens5f0 inet manual

iface br0 inet static
    address 172.17.5.203
    netmask 255.255.254.0
    gateway 172.17.5.254
    bridge_ports enp6s0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0

iface br1 inet manual
    bridge_ports ens5f0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0

iface br1.1001 inet static
    address 192.168.10.242
    netmask 255.255.255.0
    vlan-raw-device br1
```

- /etc/rc.local

```
#!/bin/bash
virsh net-destroy default
exit 0
```

## KVM-2

- /etc/network/interfaces

```
auto lo br0 br1 br1.1001

iface enp6s0 inet manual
iface ens5f0 inet manual

iface br0 inet static
    address 172.17.5.204
    netmask 255.255.254.0
    gateway 172.17.5.254
    bridge_ports enp6s0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0

iface br1 inet manual
    bridge_ports ens5f0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0

iface br1.1001 inet static
    address 192.168.10.243
    netmask 255.255.255.0
    vlan-raw-device br1
```

- /etc/rc.local

```
#!/bin/bash
virsh net-destroy default
exit 0
```

## KVM-3

- /etc/network/interfaces

```
auto lo br0 br1 br1.1001

iface enp6s0 inet manual
iface ens5f0 inet manual

iface br0 inet dhcp
    hwaddress ether 74:fe:48:08:57:cc
    bridge_ports enp6s0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0

iface br1 inet manual
    bridge_ports ens5f0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0

iface br1.1001 inet static
    address 192.168.10.244
    netmask 255.255.255.0
    vlan-raw-device br1
```

- /etc/rc.local
```
#!/bin/bash
virsh net-destroy default
exit 0
```

## Docker-1

- /etc/network/interfaces

```
auto lo br0 br1 br1.1001

iface enp6s0 inet manual
iface ens5f0 inet manual

iface br0 inet static
    address 172.17.5.116
    netmask 255.255.254.0
    gateway 172.17.5.254
    bridge_ports enp6s0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0

iface br1 inet manual
    bridge_ports ens5f0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0

iface br1.1001 inet static
    address 192.168.10.245
    netmask 255.255.255.0
    vlan-raw-device br1
```

- /etc/rc.local

```
#!/bin/bash
virsh net-destroy default
exit 0
```

## Docker-2

- /etc/network/interfaces

```
auto lo br0 br1 br1.1001

iface enp6s0 inet manual
iface ens5f1 inet manual

iface br0 inet static
    address 172.17.5.117
    netmask 255.255.254.0
    gateway 172.17.5.254
    bridge_ports enp6s0
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0
    dns-nameservers 8.8.8.8

iface br1 inet manual
    bridge_ports ens5f1
    bridge_stp off
    bridge_maxwait 0
    bridge_fd 0

iface br1.1001 inet static
    address 192.168.10.246
    netmask 255.255.255.0
    vlan-raw-device br1
```

- /etc/rc.local

```
#!/bin/bash 
virsh net-destroy default

iptables -A FORWARD -p all -i br0 -j ACCEPT
exit 0
```
