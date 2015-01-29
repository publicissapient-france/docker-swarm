#!/bin/sh

if [ $# -lt 1 ];then
  echo "Usage: spawn.sh <private_key>"
  exit 1
fi
CWD=$(pwd $(dirname $0))

# Create keys
cd $CWD/private
rm docker-temp*
ssh-keygen -f docker-temp -N "" -q -C "docker-temp@xebia"
mv docker-temp.pub $CWD/public_keys
mkdir -p $CWD/private_keys
mv docker-temp $CWD/private_keys/docker-temp.pem
puttygen $CWD/private_keys/docker-temp.pem -o $CWD/private_keys/docker-temp.ppk -O private

# Apply
cd $CWD
export ANSIBLE_HOST_KEY_CHECKING=False
node terraform2ansible.js
ansible-playbook -i private/inventory --private-key=$1 reset-ssh.playbook
