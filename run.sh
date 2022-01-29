#!/bin/bash

# Make sure ansible is installed.
if ! which ansible > /dev/null; then
  sudo apt install ansible
fi

# Run our playbook now.
ansible-playbook ansible-setup.yml -i hosts
