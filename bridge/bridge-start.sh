#!/bin/bash

service openvpn stop

for t in $TAP_NAME; do
    openvpn --mktun --dev $t
done

brctl addbr $BRIDGE_NAME
brctl addif $BRIDGE_NAME $ETHERNET_INTERFACE_NAME

for t in $TAP_NAME; do
    brctl addif $BRIDGE_NAME $t
done

for t in $TAP_NAME; do
    ifconfig $t 0.0.0.0 promisc up
done

ifconfig $ETHERNET_INTERFACE_NAME 0.0.0.0 promisc up
ifconfig $BRIDGE_NAME $ETHERNET_INTERFACE_IP netmask $ETHERNET_INTERFACE_NETMASK broadcast $ETHERNET_INTERFACE_BROADCAST

route add default gw $ETHERNET_INTERFACE_GATEWAY

service openvpn start
