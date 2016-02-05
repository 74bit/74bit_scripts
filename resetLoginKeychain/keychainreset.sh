#!/bin/bash

########################################################################
# Created By: Andrina Kelly, andrina.kelly@bellmedia.ca, Ext 4995
# Creation Date: July 2013
# Last Modified: Matthew Bodaly Feb 2016 - changed currentUser method
# Brief Description: Deletes the users login.keychain, and creates a new keychain
########################################################################

getpass()
{
asmsg=$(osascript -e 'tell app "System Events"
Activate
set foo to text returned of (display dialog "Enter the password you use to login:" default answer "" buttons {"Continue"} default button 1 with hidden answer)
end tell')
if [ ! "$asmsg" ]; then
getpass
else
echo $asmsg
fi
}

#Find out who's logged in
currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
echo "I know who is logged in"
#Get the name of the users keychain - some messy sed and awk to set up the correct name for security to like
KEYCHAIN=`su $currentUser -c "security list-keychains" | grep login | sed -e 's/\"//g' | sed -e 's/\// /g' | awk '{print $NF}'`
echo "I got the keychain file"
#Go delete the keychain in question...
su $currentUser -c "security delete-keychain $KEYCHAIN"
echo "I deleted the keychain"
#Ask the user for their login password to create a new keychain
PASSWORD=$(getpass)
echo "I just got a password. Now I am going to hack the planet"
#Create the new login keychain
expect <<- DONE
set timeout -1
spawn su $currentUser -c "security create-keychain login.keychain"
echo "I just created the new keychain"
# Look for prompt
expect "*?chain:*"
# send user entered password
send "$PASSWORD\n"
expect "*?chain:*"
send "$PASSWORD\r"
expect EOF
DONE

#Set the newly created login.keychain as the users default keychain
su $currentUser -c "security default-keychain -s login.keychain"
echo "this new keychain is default"

# Sync keychain enabled
defaults write com.apple.keychainaccess SyncLoginPassword -bool true
