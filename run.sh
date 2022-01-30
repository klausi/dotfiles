#!/bin/bash

# Make sure ansible is installed.
if ! which ansible > /dev/null; then
  sudo add-apt-repository universe -y
  sudo apt install ansible -y
fi

# Run our playbook now.
ansible-playbook ansible-setup.yml -i hosts
