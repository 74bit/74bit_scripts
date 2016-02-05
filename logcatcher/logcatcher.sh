@@ -1,15 +1,20 @@
#!/bin/bash
# v1.0 / Logan Fink / 74bit / 28 April 2015
# v1.0.1 cleanup on aisle 5
# v1.1 cleanup on aisle 6 ... changed the method for getting the user
# This puts log files on the current users desktop so they can attach it to tickets
#Variables
currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

if [[ "$currentUser" -ne "" && -d "/Users/$CURRENT_USER_NAME/Desktop" ]]; then
  logOutputDirectory="/Users/$currentUser/Desktop/"
else
  logOutputDirectory="/Users/Shared/"
fi

dateStamp=$(date +%Y\.%m\.%d-%H%M)
logZipName="$dateStamp-logs.zip"
logOutputDirectory="/Users/$currentUser/Desktop/"

#
#if [[ "$currentUser" -ne "" && -d "/Users/$currentUser/Desktop" ]]; then
#  logOutputDirectory="/Users/$currentUser/Desktop/"
#  echo "i got the username"
#else
#  logOutputDirectory="/Users/Shared/"
#  echo "i cant figure out the username"
#fi

zip -r "$logOutputDirectory$logZipName" /Library/Logs/DiagnosticReports/ /var/log/ -x '*.zip' '*.gz'
