# Host Configuration

## KVM-1
```
root@kvm-1:~# efibootmgr 
BootCurrent: 0001
Timeout: 1 seconds
BootOrder: 0001,0002,0003,0004
Boot0001* ubuntu
Boot0002* UEFI OS
Boot0003* Hard Drive
Boot0004* UEFI: Built-in EFI Shell
root@kvm-1:~# ip addr s dev br0
33: br0: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 74:fe:48:09:16:53 brd ff:ff:ff:ff:ff:ff
    inet 172.17.5.203/23 brd 172.17.5.255 scope global br0
       valid_lft forever preferred_lft forever
root@kvm-1:~# ip addr s dev br1.1001
8: br1.1001@br1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:0b:ab:f3:50:20 brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.242/24 brd 192.168.10.255 scope global br1.1001
       valid_lft forever preferred_lft forever
    inet6 fe80::20b:abff:fef3:5020/64 scope link 
       valid_lft forever preferred_lft forever
```

```
2: enp5s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000                                         
    link/ether 74:fe:48:09:16:52 brd ff:ff:ff:ff:ff:ff                                                                          
3: enp6s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq master br0 state DOWN group default qlen 1000                  
    link/ether 74:fe:48:09:16:53 brd ff:ff:ff:ff:ff:ff                                                                          
4: ens5f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br1 state UP group default qlen 1000                      
    link/ether 00:0b:ab:f3:50:20 brd ff:ff:ff:ff:ff:ff                                                                          
5: ens5f1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000                                         
    link/ether 00:0b:ab:f3:50:21 brd ff:ff:ff:ff:ff:ff
```

## KVM-2

```
root@kvm-2:~# efibootmgr 
BootCurrent: 0001
Timeout: 1 seconds
BootOrder: 0001,0002,0003,0004
Boot0001* ubuntu
Boot0002* UEFI OS
Boot0003* Hard Drive
Boot0004* UEFI: Built-in EFI Shell
root@kvm-2:~# ip addr s dev br1.1001
8: br1.1001@br1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:0b:ab:f3:50:28 brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.243/24 brd 192.168.10.255 scope global br1.1001
       valid_lft forever preferred_lft forever
    inet6 fe80::20b:abff:fef3:5028/64 scope link 
       valid_lft forever preferred_lft forever
```

```
2: enp5s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000                                         
    link/ether 74:fe:48:08:f0:38 brd ff:ff:ff:ff:ff:ff                                                                          
3: enp6s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000                             
    link/ether 74:fe:48:08:f0:39 brd ff:ff:ff:ff:ff:ff                                                                          
4: ens5f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br1 state UP group default qlen 1000
    link/ether 00:0b:ab:f3:50:28 brd ff:ff:ff:ff:ff:ff
5: ens5f1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:0b:ab:f3:50:29 brd ff:ff:ff:ff:ff:ff
```

## KVM-3

```
root@kvm-3:~# efibootmgr 
EFI variables are not supported on this system.
root@kvm-3:~# ip addr s dev br1.1001
8: br1.1001@br1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:0b:ab:f1:e9:64 brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.244/24 brd 192.168.10.255 scope global br1.1001
       valid_lft forever preferred_lft forever
    inet6 fe80::20b:abff:fef1:e964/64 scope link 
       valid_lft forever preferred_lft forever
```

```
2: enp5s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 74:fe:48:08:57:c9 brd ff:ff:ff:ff:ff:ff
3: enp6s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 74:fe:48:08:57:ca brd ff:ff:ff:ff:ff:ff
4: ens5f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br1 state UP group default qlen 1000
    link/ether 00:0b:ab:f1:e9:64 brd ff:ff:ff:ff:ff:ff
5: ens5f1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:0b:ab:f1:e9:65 brd ff:ff:ff:ff:ff:ff
```

## docker-1

```
root@docker-1:~# efibootmgr 
BootCurrent: 0000
Timeout: 5 seconds
BootOrder: 0000,0005,0008,0009,000A,000B,000C,000E,0007
Boot0000* ubuntu
Boot0005  UEFI: Built-in EFI Shell
Boot0007  Hard Drive
Boot0008  UEFI: IP4 Intel(R) I210 Gigabit  Network Connection
Boot0009  UEFI: IP6 Intel(R) I210 Gigabit  Network Connection
Boot000A  UEFI: IP4 Intel(R) I210 Gigabit  Network Connection
Boot000B  UEFI: IP6 Intel(R) I210 Gigabit  Network Connection
Boot000C  Network Card
Boot000E  UEFI OS
root@docker-1:~# ip addr s dev br1.1001
8: br1.1001@br1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:0b:ab:f4:f6:6e brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.245/24 brd 192.168.10.255 scope global br1.1001
       valid_lft forever preferred_lft forever
    inet6 fe80::20b:abff:fef4:f66e/64 scope link 
       valid_lft forever preferred_lft forever
```

```
2: enp5s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000                                         
    link/ether 74:fe:48:18:b6:1e brd ff:ff:ff:ff:ff:ff                                                                          
3: ens5f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br1 state UP group default qlen 1000                      
    link/ether 00:0b:ab:f4:f6:6e brd ff:ff:ff:ff:ff:ff                                                                          
4: enp6s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000                             
    link/ether 74:fe:48:18:b6:1f brd ff:ff:ff:ff:ff:ff                                                                          
5: ens5f1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000                                         
    link/ether 00:0b:ab:f4:f6:6f brd ff:ff:ff:ff:ff:ff 
```

## docker-2

```
root@docker-2:~# efibootmgr 
BootCurrent: 0006
Timeout: 5 seconds
BootOrder: 0006,000A,0004,000C,0005
Boot0004* Hard Drive
Boot0005  UEFI: Built-in EFI Shell
Boot0006* ubuntu
Boot0009  Hard Drive
Boot000A* UEFI: Built-in EFI Shell
Boot000C* UEFI OS
root@docker-2:~# ip addr s dev br1.1001
8: br1.1001@br1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:0b:ab:f4:f6:9d brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.246/24 brd 192.168.10.255 scope global br1.1001
       valid_lft forever preferred_lft forever
    inet6 fe80::20b:abff:fef4:f69d/64 scope link 
       valid_lft forever preferred_lft forever
```

```
2: enp5s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000                                         
    link/ether 74:fe:48:18:b6:2b brd ff:ff:ff:ff:ff:ff                                                                          
3: enp6s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP group default qlen 1000                      
    link/ether 74:fe:48:18:b6:2c brd ff:ff:ff:ff:ff:ff                                                                          
    inet6 fe80::76fe:48ff:fe18:b62c/64 scope link                                                                               
       valid_lft forever preferred_lft forever                                                                                  
4: ens5f0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000                                         
    link/ether 00:0b:ab:f4:f6:9c brd ff:ff:ff:ff:ff:ff                                                                          
5: ens5f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br1 state UP group default qlen 1000                      
    link/ether 00:0b:ab:f4:f6:9d brd ff:ff:ff:ff:ff:ff 
```

## Snoopy

```
snoopy:~# ip addr 
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:0c:29:45:f2:9c brd ff:ff:ff:ff:ff:ff
    inet 172.17.5.238/23 brd 172.17.5.255 scope global eth0
    inet 172.17.22.238/22 brd 172.17.23.255 scope global eth0:0
    inet6 fe80::20c:29ff:fe45:f29c/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:0c:29:45:f2:a6 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.238/16 brd 10.0.255.255 scope global eth1
    inet6 fd07:a448:f616:0:20c:29ff:fe45:f2a6/64 scope global dynamic 
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe45:f2a6/64 scope link 
       valid_lft forever preferred_lft forever
```

## Orochimaru

```
root@Orochimaru:~# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
    link/ether c4:7d:4f:7b:07:aa brd ff:ff:ff:ff:ff:ff
    inet 172.17.5.195/23 brd 172.17.5.255 scope global eth0
    inet 172.17.22.195/22 brd 172.17.23.255 scope global eth0:0
    inet6 fe80::c67d:4fff:fe7b:7aa/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
    link/ether c4:7d:4f:7b:07:ab brd ff:ff:ff:ff:ff:ff
    inet 10.0.6.195/16 brd 10.0.255.255 scope global eth1
    inet 10.0.0.195/16 brd 10.0.255.255 scope global secondary eth1:0
    inet6 fd07:a448:f616:0:c67d:4fff:fe7b:7ab/64 scope global dynamic 
       valid_lft forever preferred_lft forever
    inet6 fe80::c67d:4fff:fe7b:7ab/64 scope link 
       valid_lft forever preferred_lft forever
```

## MIC-Server

```
root@mic-server:~# efibootmgr 
BootCurrent: 0003
Timeout: 1 seconds
BootOrder: 0002,0001,0003,0004
Boot0001* Hard Drive    BBS(HD,,0x0)0000474f00004e4fa9000000010000006f005300540038003000300030004e004d0030003000300041002d0032004b00450031003000310000000501090002000000007fff040002010c00d041030a0000000001010600021f03120a000100ffff00007fff040001043e00ef47642dc93ba041ac194d51d01b4ce62000200020002000200020002000200020002000200020004b00570030004400480037005100500000007fff04000000424f00004e4fa9000000010000006f005300540031003600300030003000560045003000300030002d0032004c00320031003000330000000501090002000000007fff040002010c00d041030a0000000001010600021f03120a000000ffff00007fff040001043e00ef47642dc93ba041ac194d51d01b4ce62000200020002000200020002000200020002000200020004c005a00370032005900300047004c0000007fff04000000424f
Boot0002* CD/DVD 驅動器         BBS(CDROM,,0x0)0000474f00004e4fa5000000010000006f00410053005500530020002000200020002000530048002d003200320034004400420000000501090003000000007fff040002010c00d041030a0000000001010600021f03120a000500ffff00007fff040001043e00ef47642dc93ba041ac194d51d01b4ce63100530045003100380036004600440030004100320030003900340020002000200020002000200000007fff04000000424f
Boot0003* ubuntu        HD(1,GPT,19b7c173-5b7f-4413-bb78-c8d17772bbf1,0x800,0x219800)/File(\EFI\Ubuntu\grubx64.efi)
Boot0004* UEFI OS       HD(1,GPT,19b7c173-5b7f-4413-bb78-c8d17772bbf1,0x800,0x219800)/File(\EFI\BOOT\BOOTX64.EFI)
root@mic-server:~# ip addr s dev br0
3: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 46:f6:5f:f0:db:f0 brd ff:ff:ff:ff:ff:ff
    inet 172.17.4.253/23 brd 172.17.5.255 scope global br0
       valid_lft forever preferred_lft forever
    inet6 fe80::44f6:5fff:fef0:dbf0/64 scope link 
       valid_lft forever preferred_lft forever
```

## IPv6 access

```
kvm-1:
ssh cplus@fe80::20b:abff:fef3:5020%br1.1001

kvm-2:
ssh cplus@fe80::20b:abff:fef3:5028%br1.1001

kvm-3:
ssh cplus@fe80::20b:abff:fef1:e964%br1.1001

docker-1:
ssh cplus@fe80::20b:abff:fef4:f66e%br1.1001

docker-2:
ssh cplus@fe80::20b:abff:fef4:f69d%br1.1001

snoopy:
ssh cplus@fe80::20c:29ff:fe45:f29c%eth0

or:
ssh cplus@fe80::c67d:4fff:fe7b:7aa%eth0

mic-server:
ssh cplus@fe80::44f6:5fff:fef0:dbf0%br0
```
