#!/bin/sh
# deletes the lync keychain
# Written by Matthew Bodaly
# v. 1.0.1 27 July 2015

# Variables
# Get the current user
USER=`who | grep console | awk '{print $1}'`

# Payload
# Exit Lync
sudo killall -KILL "Microsoft Lync"
# Delete the keychain
rm -rF "/Users/$USER/Library/Keychains/*@*"
# Open Lync
open -a /Applications/Microsoft\ Lync.app/
