#!/bin/bash

# id-rsa.pub from host
# Make sure $newUser exists in the key
rsaKey="ssh-rsa ENTIREKEYGOESHERE"
lastten=${rsaKey: -21}

mkdir -p /root/.ssh 2>&1
chown -R root /root/.ssh
if grep --quiet "$lastten" /root/.ssh/authorized_keys; then
  echo "Key already present for $newUser user"
else
  echo "Key not present for $newUser user, adding it..."
  echo "$rsaKey"  >> /root/.ssh/authorized_keys
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
