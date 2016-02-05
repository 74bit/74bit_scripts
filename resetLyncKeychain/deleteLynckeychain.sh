#!/bin/sh
# deletes the lync keychain
# Written by Matthew Bodaly
# v. 1.0.1 27 July 2015
# v. 1.1 4 Feb 2016 - changed currentUser method

# Variables
# Get the current user
currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# Payload
# Exit Lync
sudo killall -KILL "Microsoft Lync"
# Delete the keychain
rm -rF "/Users/$currentUser/Library/Keychains/*@*"
# Open Lync
open -a /Applications/Microsoft\ Lync.app/
