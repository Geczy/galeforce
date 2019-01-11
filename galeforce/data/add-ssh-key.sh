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

if [ $(awk '/PasswordAuthentication/{var=1}END{print var+0}' /etc/ssh/sshd_config) = "1" ]; then
  sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
else
  echo "PasswordAuthentication doesn't exist, adding"
  echo "PasswordAuthentication no"  >> /etc/ssh/sshd_config
fi

if [ $(awk '/ChallengeResponseAuthentication/{var=1}END{print var+0}' /etc/ssh/sshd_config) = "1" ]; then
  sed -i -e 's/ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/g' /etc/ssh/sshd_config
else
  echo "ChallengeResponseAuthentication doesn't exist, adding"
  echo "ChallengeResponseAuthentication no"  >> /etc/ssh/sshd_config
fi

if [ $(awk '/UsePAM/{var=1}END{print var+0}' /etc/ssh/sshd_config) = "1" ]; then
	sed -i -e 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
else
  echo "UsePAM doesn't exist, adding"
  echo "UsePAM no"  >> /etc/ssh/sshd_config
fi
