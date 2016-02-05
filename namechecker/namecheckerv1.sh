#!/bin/bash
# This checks to make sure all of the system names are the same as the assettag file.
NAME=$(more /Library/Application\ Support/caspersupport/assettag)
LOCAL=$(scutil --get ComputerName)
if [ "$NAME" != "$LOCAL" ];
then
# Change the HostName to the variable
	scutil --set HostName $NAME;
# Change the ComputerName to the variable
	scutil --set ComputerName $NAME;
# change the Bonjour name
systemsetup -setlocalsubnetname $NAME
fi
