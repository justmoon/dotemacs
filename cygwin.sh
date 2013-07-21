#!/bin/bash

#
# Cygwin/X environment script
#
# This script is designed to be executed by a remote Windows SSH client running
# Cygwin/X. It sets up some GNOME daemons used by various programs.
#
# Usage:
#
# Create a shortcut on the Windows machine as follows:
#
#   C:\Path\to\Quiet.exe
#     "C:\Path\to\Xming\plink.exe"
#       -batch -i identity.ppk user@192.168.0.100
#         export DISPLAY=192.168.1.101:0 ;
#         source ~/.emacs.d/cygwin.sh ;
#         gnome-terminal
#

# Load ~/.profile
source ~/.profile

# Start gnome-settings-daemon
gnome-settings-daemon &

# Start gnome-keyring-daemon
eval $(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID
