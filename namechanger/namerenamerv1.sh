#!/bin/bash
# this takes the name that the computer has in JAMF and then renames 
# all computer variables to that name AND adds a flat text file at
# /Library/Application\ Support/assettag
# Make a folder to store resource files. Commenting this out since this line isn't needed
# when the script is deployed via Casper. Uncomment to enable.
mkdir /Library/Application\ Support/caspersupport
# Get for the name of the computer from Casper and write it to a file
jamf -getComputerName | cut -c 16-24 > /Library/Application\ Support/caspersupport/assettag
# Set entry as a variable
BELUS=$(more /Library/Application\ Support/caspersupport/assettag)
# Backup the file that will be changed
cp /etc/hostconfig /Library/Application\ Support/caspersupport/hostconfig.bak
# Change the HostName to the variable
scutil --set HostName $BELUS
# Change the ComputerName to the variable
scutil --set ComputerName $BELUS
# Write the variable to the end of /etc/hostconfig. This uses the FQDN. If you have a FQDN... you should change this.
echo HOSTNAME=$BELUS.apptio.lan >> /etc/hostconfig
# change the Bonjour name
systemsetup -setlocalsubnetname $BELUS
