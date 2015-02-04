#!/bin/sh

if [ $# -lt 1 ];then
  echo "Usage: spawn.sh <private_key>"
  exit 1
fi

terraform apply && (
  export ANSIBLE_HOST_KEY_CHECKING=False
  node terraform2ansible.js terraform.tfstate private/inventory
  ansible-playbook -i private/inventory --private-key=$1 docker.playbook
)
