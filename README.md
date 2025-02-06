# Dev Cloud

## Security
- Root password hard to hack.
- Disable root ssh login.
- Disable ssh password login.
- Reset Jenkins admin password.

## Host List
```
SWITCH

JUMP-HOST

HOST-0
  #ERR: SAS

HOST-1
  Name: kvm-1
  IP: 172.17.5.203
  Description: KVM Development

HOST-2
  Name: kvm-2
  IP: 172.17.5.204
  Description: KVM Development

HOST-3
  Name: kvm-3
  IP: DHCP
  Description: KVM Development
  #ERR: VGA

HOST-4
  Name: docker-1
  IP: 172.17.5.116 
  Description: KVM or Docker Development

HOST-5
  Name: docker-2
  IP: 172.17.5.117
  Description: KVM or Docker Development
```

## Host OS Prerequisite
OS Distribution: Ubuntu Server 18.04.3 LTS or newer.

### Network
```
iptables -A FORWARD -p all -i br0 -j ACCEPT
virsh net-destroy default
```

## VM Prerequisite

```
# apt install -y bridge-utils
# apt install -y ifupdown
# apt install -y vlan
# apt install -y resolvconf
# modprobe 8021q
# git clone https://github.com/cplus66/dev-cloud.git
# cd dev-cloud
# cp fs/etc/network/interface /etc/network/
```

## VM Launch 
### Ubuntu
```
CPU=8 RAM=16384 NET=br1 ~cplus/virt-utils/virt-install.sh vm_name image_name
```

### CentOS
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

## Router VM 

### NAT
```
echo 1 > /proc/sys/net/ipv4/ip_forward
/sbin/iptables -t nat -A POSTROUTING -j MASQUERADE
```

### VRRP
- keepalived : Failover and monitoring daemon for LVS clusters
TBD


## Administration

### Launch VM Configuration
- OS Type: CentOS 7, Ubuntu 14.04 LTS, Ubuntu 16.04 LTS, Ubuntu 18.04 LTS
- CPU: 1,2,4,8
- Memory: 2048,4096, 8192, 18384 (MB)
- Storage: 64,128, 256, 512 (GB)
- Network: br0 (external bridge), br1 (internal bridge)
- Security: credential

## CI/CD / Jenkins

- OpenJDK 17.0.3
- Enable HTTPS
- https://stackoverflow.com/questions/40126736/enable-https-in-jenkins

## Backup 
TBD

## Restore
TBD

## Others

### Ubuntu 18.04 Net Install with Console
- Use PUTTY for installation
- Connect box to intranet

### TFTP Server Configuration
- Change disable from 'yes' to 'no'
- tftproot is '/var/lib/tftpboot'

```
# cat /etc/xinetd.d/tftp 
# default: off
# description: The tftp server serves files using the trivial file transfer \
#       protocol.  The tftp protocol is often used to boot diskless \
#       workstations, download configuration files to network-aware printers, \
#       and to start the installation process for some operating systems.
service tftp
{
        socket_type             = dgram
        protocol                = udp
        wait                    = yes
        user                    = root
        server                  = /usr/sbin/in.tftpd
        server_args             = -s /var/lib/tftpboot
        disable                 = no
        per_source              = 11
        cps                     = 100 2
        flags                   = IPv4
}

```


### DHCP Server Configuration
- domain-name-servers (TBC)
- hardware ethernet 74:FE:48:08:57:C9 and bootfile is  "pxelinux.0"

```
[root@localhost dhcp]# cat /etc/dhcp/dhcpd.conf 
#
# DHCP Server Configuration file.
#   see /usr/share/doc/dhcp*/dhcpd.conf.example
#   see dhcpd.conf(5) man page
#
option domain-name "example.com";

default-lease-time 600;
max-lease-time 7200;

allow booting;
allow bootp;

subnet 192.0.2.0 netmask 255.255.255.0 {
        range   192.0.2.100   192.0.2.200;
        option broadcast-address 192.168.2.255;
        option routers                  192.0.2.253;
        option domain-name-servers      172.20.1.100;
        option subnet-mask              255.255.255.0;
}

group {
  next-server 192.0.2.253;
  host tftpclient {
  hardware ethernet 74:FE:48:08:57:C9;
  filename "pxelinux.0";
 }
}
```

- br-cp2 is DHCP server binding interface
```
[root@localhost dhcp]# cat /etc/systemd/system/dhcpd.service 
[Unit]
Description=DHCPv4 Server Daemon
Documentation=man:dhcpd(8) man:dhcpd.conf(5)
Wants=network-online.target
After=network-online.target
After=time-sync.target

[Service]
Type=notify
ExecStart=/usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid br-cp2

[Install]
WantedBy=multi-user.target
[root@localhost dhcp]#

```

### PXE Configuration

```
[root@localhost tftpboot]# diff -ru ubuntu-installer.orig ubuntu-installer
diff -ru ubuntu-installer.orig/amd64/boot-screens/menu.cfg ubuntu-installer/amd64/boot-screens/menu.cfg
--- ubuntu-installer.orig/amd64/boot-screens/menu.cfg   2019-11-05 12:00:37.506922272 +0800
+++ ubuntu-installer/amd64/boot-screens/menu.cfg        2019-11-05 13:28:02.819121309 +0800
@@ -1,4 +1,3 @@
-serial 0 115200
 menu hshift 13
 menu width 49
 menu margin 8
@@ -6,7 +5,16 @@
 menu title Installer boot menu
 include ubuntu-installer/amd64/boot-screens/stdmenu.cfg
 include ubuntu-installer/amd64/boot-screens/txt.cfg
 label help
        menu label ^Help
        text help
Only in ubuntu-installer.orig/amd64/boot-screens: menu.cfg.orig
diff -ru ubuntu-installer.orig/amd64/boot-screens/prompt.cfg ubuntu-installer/amd64/boot-screens/prompt.cfg
--- ubuntu-installer.orig/amd64/boot-screens/prompt.cfg 2019-11-05 12:01:07.376878342 +0800
+++ ubuntu-installer/amd64/boot-screens/prompt.cfg      2019-09-26 06:37:34.000000000 +0800
@@ -1,6 +1,6 @@
 prompt 1
 display ubuntu-installer/amd64/boot-screens/f1.txt
-timeout 10
+timeout 0
 include ubuntu-installer/amd64/boot-screens/menu.cfg
 include ubuntu-installer/amd64/boot-screens/exithelp.cfg
 
diff -ru ubuntu-installer.orig/amd64/boot-screens/syslinux.cfg ubuntu-installer/amd64/boot-screens/syslinux.cfg
--- ubuntu-installer.orig/amd64/boot-screens/syslinux.cfg       2019-09-26 06:37:34.000000000 +0800
+++ ubuntu-installer/amd64/boot-screens/syslinux.cfg    2019-11-05 13:58:17.801395117 +0800
@@ -1,7 +1,8 @@
 # D-I config version 2.0
 # search path for the c32 support libraries (libcom32, libutil etc.)
+CONSOLE 0
+SERIAL 0 115200 0
 path ubuntu-installer/amd64/boot-screens/
 include ubuntu-installer/amd64/boot-screens/menu.cfg
-default ubuntu-installer/amd64/boot-screens/vesamenu.c32
 prompt 0
-timeout 0
+timeout 100
diff -ru ubuntu-installer.orig/amd64/boot-screens/txt.cfg ubuntu-installer/amd64/boot-screens/txt.cfg
--- ubuntu-installer.orig/amd64/boot-screens/txt.cfg    2019-11-05 13:23:29.812530457 +0800
+++ ubuntu-installer/amd64/boot-screens/txt.cfg 2019-11-05 13:27:46.996145016 +0800
@@ -3,4 +3,8 @@
        menu label ^Install
        menu default
        kernel ubuntu-installer/amd64/linux
-       append vga=off initrd=ubuntu-installer/amd64/initrd.gz -- quiet console=ttyS0,115200n8
+       append vga=off initrd=ubuntu-installer/amd64/initrd.gz --- quiet console=ttyS0,115200n8
+label cli
+       menu label ^Command-line install
+       kernel ubuntu-installer/amd64/linux
+       append tasks=standard pkgsel/language-pack-patterns= pkgsel/install-language-support=false vga=788 initrd=ubuntu-installer/amd64/initrd.gz --- quiet 
Only in ubuntu-installer.orig/amd64/boot-screens: txt.cfg.orig
diff -ru ubuntu-installer.orig/amd64/pxelinux.cfg/default ubuntu-installer/amd64/pxelinux.cfg/default
--- ubuntu-installer.orig/amd64/pxelinux.cfg/default    2019-09-26 06:37:34.000000000 +0800
+++ ubuntu-installer/amd64/pxelinux.cfg/default 2019-11-05 13:58:17.801395117 +0800
@@ -1,7 +1,8 @@
 # D-I config version 2.0
 # search path for the c32 support libraries (libcom32, libutil etc.)
+CONSOLE 0
+SERIAL 0 115200 0
 path ubuntu-installer/amd64/boot-screens/
 include ubuntu-installer/amd64/boot-screens/menu.cfg
-default ubuntu-installer/amd64/boot-screens/vesamenu.c32
 prompt 0
-timeout 0
+timeout 100
```

## Reference
- https://a.custura.eu/post/debian-via-serial-console/
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/index

## ToDo
- Enlarge gw memory size from 2GB to 8GB
- Backup DevCloud v0.2
- Install Local DHCP Server
- Install Local DNS Server
- Install NTP Server
- Configure Timezone with command "timedatectl set-timezone Asia/Taipei"
