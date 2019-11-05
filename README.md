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

# Ubuntu 18.04 Net Install with Console

## PXE Configuration
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
-
+include ubuntu-installer/amd64/boot-screens/gtk.cfg
+menu begin advanced
+       menu title Advanced options
+       include ubuntu-installer/amd64/boot-screens/stdmenu.cfg
+       label mainmenu
+               menu label ^Back..
+               menu exit
+       include ubuntu-installer/amd64/boot-screens/adtxt.cfg
+       include ubuntu-installer/amd64/boot-screens/adgtk.cfg
+menu end
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
