#!/bin/bash
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool TRUE
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdateRestartRequired -bool TRUE
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool TRUE
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool TRUE
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool TRUE
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool TRUE
