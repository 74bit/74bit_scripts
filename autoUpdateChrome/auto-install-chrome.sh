#!/bin/bash

# This script will download and install Google Chrome on a fresh installation of Mac OS X.
# Usage: curl -fkL gist.github.com/raw/4364590/install-chrome.sh | sh

DOWNLOAD_URL="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
DMG_PATH="/tmp/Google Chrome.dmg"
DMG_VOLUME_PATH="/Volumes/Google Chrome/"
APP_NAME="Google Chrome.app"
APP_PATH="/Applications/$APP_NAME"
APP_PROCESS_NAME="Google Chrome"
APP_INFO_PLIST="Contents/Info.plist"

if pgrep "$APP_PROCESS_NAME" &>/dev/null; then
  echo 'Error - Chrome is currently running!'
else
  curl --retry 3 -L "$DOWNLOAD_URL" -o "$DMG_PATH"
  hdiutil attach -nobrowse -quiet "$DMG_PATH"
  version=$(defaults read "$DMG_VOLUME_PATH/$APP_NAME/$APP_INFO_PLIST" CFBundleShortVersionString)
  printf "Installing $APP_PROCESS_NAME version %s" "$version"
  rm "$DMG_PATH"
  ditto -rsrc "$DMG_VOLUME_PATH/$APP_NAME" "$APP_PATH"
  hdiutil detach -quiet "$DMG_VOLUME_PATH"
  rm "$DMG_PATH"
fi
