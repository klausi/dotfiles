#!/bin/bash

# Make sure ansible is installed.
if ! which ansible > /dev/null; then
  sudo add-apt-repository universe -y
  sudo apt install ansible python3-setuptools -y
  ansible-galaxy collection install community.general
fi

# Run our playbook now.
ansible-playbook ansible-setup.yml -i hosts --ask-become-pass
