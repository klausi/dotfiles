#!/bin/bash

# This script is useful to automatically update APT packages in the background
# with Anacron.
# See https://klau.si/blog/fully-hidden-automatic-system-updates-ubuntu/

export DEBIAN_FRONTEND=noninteractive
# Log the current date so that we can check when any failed runs happened.
date >> /var/log/autoapt.log
apt update 2>&1 >> /var/log/autoapt.log
# By default answer all user interaction questions with yes, for example
# for debconf.
# Use the old configuration file when new config files arrive.
# Also say yes to setting up config files.
yes '' | apt \
  -o Dpkg::Options::=--force-confold \
  -o Dpkg::Options::=--force-confdef \
  -y --allow-downgrades --allow-remove-essential \
  --allow-change-held-packages \
  upgrade 2>&1 >> /var/log/autoapt.log
# Clean up any packages that are not needed anymore.
apt autoremove -y 2>&1 >> /var/log/autoapt.log
