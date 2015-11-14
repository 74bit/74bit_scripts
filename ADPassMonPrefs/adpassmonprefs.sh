#!/bin/bash
#   Lock the preferences
    defaults write /Library/Preferences/org.pmbuko.ADPassMon prefsLocked true
#   Check keychain on startup
    defaults write /Library/Preferences/org.pmbuko.ADPassMon enableKeychainLockCheck -bool true
#   Disable notifications
    defaults write /Library/Preferences/org.pmbuko.ADPassMon enableNotifications -bool false
#   Warning settings
#   defaults write /Library/Preferences/org.pmbuko.ADPassMon warningDays -int 5
    defaults write /Library/Preferences/org.pmbuko.ADPassMon expireAge -int 90
#   Password change settings
    defaults write /Library/Preferences/org.pmbuko.ADPassMon selectedMethod -int 2
    defaults write /Library/Preferences/org.pmbuko.ADPassMon selectedBehaviour -int 1
    defaults write /Library/Preferences/org.pmbuko.ADPassMon keychainPolicy "As a reminder, please choose a password that is at least 8 characters with one number, letter, and special character that is not a previous password."
#   Password check interval (six hours so at least once a day)
    defaults write org.pmbuko.ADPassMon passwordCheckInterval -int "6"
