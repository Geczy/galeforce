#!/bin/bash

# Replace 192.168.86.xx with the IP address of your pi-hole
# See https://github.com/marcosscriven/galeforce/issues/33

sed -i -e 's/dhcp-option=${LAN_BRIDGE},6,${SETTING_BRIDGE_ADDRESS}/dhcp-option=${LAN_BRIDGE},6,192.168.86.xx/g' /etc/ssh/sshd_config
sed -i -e 's/dhcp-option=${GUEST_BRIDGE},6,${SETTING_GUEST_BRIDGE_ADDRESS}/dhcp-option=${GUEST_BRIDGE},6,192.168.86.xx/g' /etc/ssh/sshd_config
sed -i -e 's/dhcp-option=${SETUP_LAN_BRIDGE},6,${SETTING_SETUP_LAN_ADDRESS}/dhcp-option=${SETUP_LAN_BRIDGE},6,192.168.86.xx/g' /etc/ssh/sshd_config
