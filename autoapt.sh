#!/bin/bash

# This script is useful to automatically update APT packages in the background
# with Anacron.
# See https://klau.si/blog/fully-hidden-automatic-system-updates-ubuntu/

# Print output and log it at the same time.
exec > >(tee -a /var/log/autoapt.log) 2>&1
# We want to see all commands for better debugging in the logs.
set -x
# Log the current date so that we can check when any failed runs happened.
date

# Internet is slow on Austrian trains. Check the Wifi SSID and stop in that
# case.
iwgetid -r | grep -q -E '(OEBB|WESTlan)'
if [ "$?" -eq "0" ]; then
  echo "Skipping updates because of slow Wifi"
  exit 0
fi

export DEBIAN_FRONTEND=noninteractive
apt update
# By default answer all user interaction questions with yes, for example
# for debconf.
# Use the old configuration file when new config files arrive.
# Also say yes to setting up config files.
yes '' | apt \
  -o Dpkg::Options::=--force-confold \
  -o Dpkg::Options::=--force-confdef \
  -y --allow-downgrades --allow-remove-essential \
  --allow-change-held-packages \
  upgrade
# Clean up any packages that are not needed anymore.
apt autoremove -y
# Also update Snap packages. Unfortunately Snap still outputs terminal colors
# - how can we configure snap to not use terminal colors?
snap refresh --color=never --unicode=never
