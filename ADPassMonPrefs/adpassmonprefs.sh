#!/bin/bash

#Check for ADPassMon.app and exit if not found
if [ ! -d /Applications/ADPassMon.app ]; then
    echo "ADPassMon not found"
    exit 0
fi
#Check for existing launch agent
if [ -f /Users/$3/Library/LaunchAgents/AD.ADPassMon.plist ]; then
    echo "LaunchAgent for ADPassMon already exists. Removing..."
    rm /Users/$3/Library/LaunchAgents/AD.ADPassMon.plist
fi
#Write out a LaunchAgent to launch ADPassMon on login
defaults write /Users/$3/Library/LaunchAgents/AD.ADPassMon.plist Label AD.ADPassMon
defaults write /Users/$3/Library/LaunchAgents/AD.ADPassMon.plist ProgramArguments -array
defaults write /Users/$3/Library/LaunchAgents/AD.ADPassMon.plist RunAtLoad -bool YES
/usr/libexec/PlistBuddy -c "Add ProgramArguments: string /Applications/ADPassMon.app/Contents/MacOS/ADPassMon" /Users/$3/Library/LaunchAgents/AD.ADPassMon.plist
chown -R $3 /Users/$3/Library/LaunchAgents
chmod 644 /Users/$3/Library/LaunchAgents/AD.ADPassMon.plist
echo "Created LaunchAgent to launch ADPassMon on login"
#Check for org.pmbuko.ADPassMon.plist and exit if found
if [ -f /Users/$3/Library/Preferences/org.pmbuko.ADPassMon.plist ]; then
    echo "org.pmbuko.ADPassMon.plist exists"
    exit 0
else
    defaults write org.pmbuko.ADPassMon enableKeychainLockCheck -bool true
    defaults write /Users/$3/Library/Preferences/org.pmbuko.ADPassMon enableNotifications -bool true
    defaults write /Users/$3/Library/Preferences/org.pmbuko.ADPassMon expireAge -int 90
    defaults write /Users/$3/Library/Preferences/org.pmbuko.ADPassMon selectedMethod -int 1
    defaults write /Users/$3/Library/Preferences/org.pmbuko.ADPassMon warningDays -int 14
    defaults write org.pmbuko.ADPassMon keychainPolicy "As a reminder, please choose a password that is at least 8 characters with one number, letter, and special character that is not a previous password."
    defaults write /Users/$3/Library/Preferences/org.pmbuko.ADPassMon selectedBehaviour -int 2
    defaults write org.pmbuko.ADPassMon passwordCheckInterval -int "6"
    defaults write /Users/$3/Library/Preferences/org.pmbuko.ADPassMon prefsLocked -bool true
    chown $3 /Users/$3/Library/Preferences/org.pmbuko.ADPassMon.plist
    echo "Created /Users/$3/Library/Preferences/org.pmbuko.ADPassMon.plist"
fi

osascript -e 'tell application "ADPassMon" to quit'
open -a ADPassMon
