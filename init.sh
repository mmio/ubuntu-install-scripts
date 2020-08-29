#!/bin/bash

USERNAME=dominik

# Switch to root
su

# Install necessary dependencies
apt install -–no-install-recommends sudo git

# Add user to the sudo group
/sbin/usermod -aG sudo $USERNAME

# Restart pc
/sbin/reboot
