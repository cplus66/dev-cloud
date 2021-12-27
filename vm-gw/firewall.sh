#!/bin/bash -xe
# This is a more complex setup, for a home firewall: 
# * One interface plug to the ISP conection (eth0). Using DHCP.
# * One interface plug to the local LAN switch (eth1). Using 192.168.10.0/24.
# * Traffic open from the LAN to the SSH in the firewall.
# * Traffic open and translated, from the local LAN to internet.
# * Traffic open from internet, to a local web server.
# * Logging of dropped traffic, using a specific ''log level'' to configure a separate file in syslog/rsyslog.

PATH='/sbin'

## INIT

# Flush previous rules, delete chains and reset counters
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Default policies
iptables -P INPUT   ACCEPT
iptables -P OUTPUT  ACCEPT
iptables -P FORWARD ACCEPT

echo -n '1' > /proc/sys/net/ipv4/ip_forward
echo -n '1' > /proc/sys/net/ipv4/conf/all/accept_source_route
echo -n '1' > /proc/sys/net/ipv4/conf/all/accept_redirects
echo -n '1' > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
echo -n '1' > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses

# Enable loopback traffic
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Enable statefull rules (after that, only need to allow NEW conections)
iptables -A INPUT   -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT  -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Drop invalid state packets
iptables -A INPUT   -m conntrack --ctstate INVALID -j DROP
iptables -A OUTPUT  -m conntrack --ctstate INVALID -j DROP
iptables -A FORWARD -m conntrack --ctstate INVALID -j DROP


## OUTPUT

# Enable al outgoing traffic to internet
iptables -A OUTPUT -o eth0 -d 0.0.0.0/0      -j ACCEPT 

# Enable access traffic, from the firewall to the LAN network
iptables -A OUTPUT -o eth1.1001 -d 192.168.10.0/24 -j ACCEPT


## FORWARD

# We have dynamic IP (DHCP), so we've to masquerade 
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables        -A FORWARD     -o eth0 -i eth1.1001 -s 192.168.10.0/24 \
                               -m conntrack --ctstate NEW -j ACCEPT

