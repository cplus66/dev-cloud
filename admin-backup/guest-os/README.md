# Guest OS

## Gateway (Jump Host)

- /etc/netplan/01-networkd-all.yaml
```
network:
  version: 2
  renderer: networkd
  ethernets:
    ens3:
      addresses:
        - 172.17.5.219/23
      routes:
        - to: default
          via: 172.17.5.254
      nameservers:
        addresses: [ 8.8.8.8 ]
    ens4:
      dhcp4: false 
  vlans:
    ens4.1001:
      id: 1001
      link: ens4
      addresses: [ "192.168.10.1/24" ]
```

- /etc/rc.local
```
#!/bin/bash

echo 1 > /proc/sys/net/ipv4/ip_forward
/sbin/iptables -t nat -A POSTROUTING -j MASQUERADE

# Port Forward to Jenkins:8080
iptables -t nat -A PREROUTING -p tcp -i ens3 --dport 8080 -j DNAT \
	--to-destination 192.168.10.2:8080
iptables -A FORWARD -p tcp -d 192.168.10.2 --dport 8080 \
	-m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

exit 0
```

## Jenkins

- /etc/network/interface

```
# The loopback network interface
auto lo eth0.1001

iface lo inet loopback

iface eth0.1001 inet static
    address 192.168.10.2
    netmask 255.255.255.0
    gateway 192.168.10.1
    dns-nameservers 168.95.1.1 8.8.8.8 172.20.1.100 172.20.1.99
    dns-search advantech.corp
    vlan-raw-device eth0
```

## JetPack Development Host

- /etc/network/interface.d/ens3

```
auto lo
iface lo inet loopback

auto ens3.1001
iface ens3.1001 inet static
    address 192.168.10.46
    netmask 255.255.255.0
    gateway 192.168.10.1
    vlan-raw-device ens3

```

- /etc/docker/daemon.json
```
{ 
  "default-address-pools": [ {"base":"10.10.0.0/16","size":24} ] 
} 
```
