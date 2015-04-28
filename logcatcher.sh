#!/bin/bash
# v1.0 / Logan Fink / 74bit / 28 April 2015
# This puts log files on the current users desktop so they can attach it to tickets
CURRENT_USER_NAME=$(find /dev/console -ls | awk '{print $5}')

if [[ "$CURRENT_USER_NAME" -ne "" && -d "/Users/$CURRENT_USER_NAME/Desktop" ]]; then
  logOutputDirectory="/Users/$CURRENT_USER_NAME/Desktop/"
else
  logOutputDirectory="/Users/Shared/"
fi

dateStamp=$(date +%Y\.%m\.%d-%H%M)
logZipName="$dateStamp-logs.zip"

zip -r "$logOutputDirectory$logZipName" /Library/Logs/DiagnosticReports/ /var/log/ -x '*.zip' '*.gz'
