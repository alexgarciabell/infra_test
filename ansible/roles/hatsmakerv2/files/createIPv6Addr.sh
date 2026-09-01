#!/bin/bash

echo "Creating IPv6 address from IPv4..."

APPDS_EAST="2001:558:fe15:80:7:0:"
APPDS_WEST="2001:558:fe15:81:7:0:"
DO_EAST="2001:558:fe15:80:1:0:"
DO_WEST="2001:558:fe15:81:1:0:"
DVR_EAST="2001:558:fe15:80:8:0:"
DVR_WEST="2001:558:fe15:81:8:0:"
AP_EAST="2001:558:fe15:80:2:0:"
LPIN_EAST="2600:1f18:1c6:8000:"
LPIN_WEST="2600:1f14:514:cb00:"

AVAILABILITY_ZONE=$(echo $1 | awk '{print toupper($0)}')
echo "Given availability zone: $AVAILABILITY_ZONE"

#IP=`ifconfig eth0 | grep inet | sed 's/.*inet addr: *//; s/ .*//'`
IP=`ifconfig eth0 | grep "inet\s" | sed 's/.*inet\s *//; s/ .*//'`
echo "IP Address is: $IP"

oct1=$(echo ${IP} | tr "." " " | awk '{ print $1 }')
oct2=$(echo ${IP} | tr "." " " | awk '{ print $2 }')
oct3=$(echo ${IP} | tr "." " " | awk '{ print $3 }')
oct4=$(echo ${IP} | tr "." " " | awk '{ print $4 }')

v6oct=(0 1 2 3 4 5 6 7 8 9 a b c d e f)
v6oct1=$(($oct1/16))
v6oct2=$(($oct1%16))
v6oct3=$(($oct2/16))
v6oct4=$(($oct2%16))
v6oct5=$(($oct3/16))
v6oct6=$(($oct3%16))
v6oct7=$(($oct4/16))
v6oct8=$(($oct4%16))

for i in 1
do
convertedV6oct=${v6oct[$v6oct1]}${v6oct[$v6oct2]}${v6oct[$v6oct3]}${v6oct[$v6oct4]}:${v6oct[$v6oct5]}${v6oct[$v6oct6]}${v6oct[$v6oct7]}${v6oct[$v6oct8]}
echo "Converted octet: $convertedV6oct"

zone=$(
  case $AVAILABILITY_ZONE in
    (*EAST*)  echo "EAST" ;;
    (*WEST*)  echo "WEST" ;;
  esac)
if [ "$zone" = "" ]; then
    echo "No Zone information available!"
    break;
fi
account=$(
  case "$AVAILABILITY_ZONE" in
    (*APPDS*) echo "APPDS" ;;
    (*DO*) echo "DO" ;;
    (*DVR*) echo "DVR" ;;
    (*LPIN*) echo "LPIN" ;;
    (*AP_*) echo "AP" ;;
  esac)
if [ "$account" = "" ]; then
    echo "No Account information available!"
    break;
fi
accountzone=$(echo $account"_"$zone)
echo "Account and Zone: $accountzone"
zoneV6_prefix=$(
  case $accountzone in
    (*APPDS_EAST*)  echo "$APPDS_EAST" ;;
    (*APPDS_WEST*)  echo "$APPDS_WEST" ;;
    (*DO_EAST*)  echo "$DO_EAST" ;;
    (*DO_WEST*)  echo "$DO_WEST" ;;
    (*DVR_EAST*)  echo "$DVR_EAST" ;;
    (*DVR_WEST*)  echo "$DVR_WEST" ;;
    (*LPIN_EAST*)  echo "$LPIN_EAST" ;;
    (*LPIN_WEST*)  echo "$LPIN_WEST" ;;
    (*AP_EAST*)  echo "$AP_EAST" ;;
  esac)
if [ "$zoneV6_prefix" = "" ]; then
    echo "No V6 range available for this availability zone! $1"
    break;
fi
convertedV6_ip=$(echo $zoneV6_prefix$convertedV6oct/96)
v6len=${#convertedV6_ip}
echo $v6len
if [ "$v6len" -le 22 ];then
    echo "Invalid Ipv6 address - $convertedV6_ip"
    echo "Ipv6 address NOT enabled on this host!"
    break;
fi
echo "Converted V6 addr: $convertedV6_ip"
echo "DEVICE=eth0" > ifcfg-eth0
echo "BOOTPROTO=dhcp" >> ifcfg-eth0
echo "ONBOOT=yes" >> ifcfg-eth0
echo "TYPE=Ethernet" >> ifcfg-eth0
echo "USERCTL=yes" >> ifcfg-eth0
echo "PEERDNS=yes" >> ifcfg-eth0
echo "IPV6INIT=yes" >> ifcfg-eth0
echo "IPV6ADDR=$convertedV6_ip" >> ifcfg-eth0
echo "PERSISTENT_DHCLIENT=yes" >> ifcfg-eth0
sudo mv ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0
sudo service network restart
echo "Enabled V6 on this host!"
done
echo "Done!"