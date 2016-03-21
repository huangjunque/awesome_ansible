#!/bin/bas
SNS_VIP=
SNS_VIP2=
. /etc/rc.d/init.d/functions
case "$1" in
start)
   ifconfig lo:0 $SNS_VIP netmask 255.255.255.255 broadcast $SNS_VIP
   ifconfig lo:1 $SNS_VIP2 netmask 255.255.255.255 broadcast $SNS_VIP2
   /sbin/route add -host $SNS_VIP dev lo:0
   /sbin/route add -host $SNS_VIP2 dev lo:1
   echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
   echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
   echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
   echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce
   sysctl -p >/dev/null 2>&1
   echo "RealServer Start OK"
   ;;
stop)
   ifconfig lo:0 down
   ifconfig lo:1 down
   route del $SNS_VIP >/dev/null 2>&1
   echo "0" >/proc/sys/net/ipv4/conf/lo/arp_ignore
   echo "0" >/proc/sys/net/ipv4/conf/lo/arp_announce
   echo "0" >/proc/sys/net/ipv4/conf/all/arp_ignore
   echo "0" >/proc/sys/net/ipv4/conf/all/arp_announce
   echo "RealServer Stoped"
   ;;
*)
   echo "Usage: $0 {start|stop}"
   exit 1
esac
exit 0
