#!/bin/bash
service openvpn stop

ifconfig $BRIDGE_NAME down
brctl delbr $BRIDGE_NAME

for t in $TAP_NAME; do
    openvpn --rmtun --dev $t
done
