@@ -1,15 +1,20 @@
#!/bin/bash
# v1.0 / Logan Fink / 74bit / 28 April 2015
# v1.0.1 cleanup on aisle 5
# This puts log files on the current users desktop so they can attach it to tickets
#Variables
CURRENT_USER_NAME=$(find /dev/console -ls | awk '{print $5}')

if [[ "$CURRENT_USER_NAME" -ne "" && -d "/Users/$CURRENT_USER_NAME/Desktop" ]]; then
  logOutputDirectory="/Users/$CURRENT_USER_NAME/Desktop/"
else
  logOutputDirectory="/Users/Shared/"
fi

dateStamp=$(date +%Y\.%m\.%d-%H%M)
logZipName="$dateStamp-logs.zip"
logOutputDirectory="/Users/$CURRENT_USER_NAME/Desktop/"

#
#if [[ "$CURRENT_USER_NAME" -ne "" && -d "/Users/$CURRENT_USER_NAME/Desktop" ]]; then
#  logOutputDirectory="/Users/$CURRENT_USER_NAME/Desktop/"
#  echo "i got the username"
#else
#  logOutputDirectory="/Users/Shared/"
#  echo "i cant figure out the username"
#fi

zip -r "$logOutputDirectory$logZipName" /Library/Logs/DiagnosticReports/ /var/log/ -x '*.zip' '*.gz'
