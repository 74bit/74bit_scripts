#!/bin/bash
# This checks to make sure all of the system names are the same as the assettag file.
BELUS=$(more /Library/Application\ Support/caspersupport/assettag)
LOCAL=$(scutil --get ComputerName)
if [ "$BELUS" != "$LOCAL" ];
then
# Change the HostName to the variable
	scutil --set HostName $BELUS;
# Change the ComputerName to the variable
	scutil --set ComputerName $BELUS;
# change the Bonjour name
systemsetup -setlocalsubnetname $BELUS
fi
