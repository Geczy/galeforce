#!/bin/bash

# Replace 192.168.86.xx with the IP address of your pi-hole
# See https://github.com/marcosscriven/galeforce/issues/33

file="/etc/init/dnsmasq.conf"
ip="192.168.86.xx"

sed -i -e "s/dhcp-option=\${LAN_BRIDGE},6,\${SETTING_BRIDGE_ADDRESS}/dhcp-option=\${LAN_BRIDGE},6,$ip/g" "$file"
sed -i -e "s/dhcp-option=\${GUEST_BRIDGE},6,\${SETTING_GUEST_BRIDGE_ADDRESS}/dhcp-option=\${GUEST_BRIDGE},6,$ip/g" "$file"
sed -i -e "s/dhcp-option=\${SETUP_LAN_BRIDGE},6,\${SETTING_SETUP_LAN_ADDRESS}/dhcp-option=\${SETUP_LAN_BRIDGE},6,$ip/g" "$file"
