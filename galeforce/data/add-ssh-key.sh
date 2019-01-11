#!/bin/bash

# Replace usernameHERE with your email address or your name
# Add the full ssh-rsa key in the last echo, make sure usernameHERE exists in the key

mkdir -p /root/.ssh 2>&1
chown -R root /root/.ssh
if awk '$3 ~ /usernameHERE/ { print }' /root/.ssh/authorized_keys; then
  echo "Key already present for usernameHERE user"
else
  echo "Key not present for usernameHERE user, adding it..."
  echo "ssh-rsa ENTIREKEYGOESHERE"  >> /root/.ssh/authorized_keys
fi
