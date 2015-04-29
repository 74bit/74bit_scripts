#!/bin/bash
sshStatus=$(sudo systemsetup -getremotelogin | awk '{print $3}')
if [ "$sshStatus" == "On" ]; then
  systemsetup -f -setremotelogin off
  printf "Disabled SSH!"
elif [ "$sshStatus" == "Off" ]; then
  systemsetup -f -setremotelogin on
  printf "Enabled SSH!"
else
  printf "Error, SSH Status was: %s" "$sshStatus"
fi
