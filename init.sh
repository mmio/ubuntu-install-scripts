#!/bin/bash

USERNAME=dominik

# Switch to root
su

# Add user to the sudo group
/sbin/usermod -aG sudo $USERNAME

# Restart pc
/sbin/reboot
