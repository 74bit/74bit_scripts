#!/bin/sh
#disables sleep
#systemsetup -setcomputersleep 15

#http://hints.macworld.com/article.php?story=20040330161158532
#https://jamfnation.jamfsoftware.com/discussion.html?id=11807
#Make the directory for the flat file
#I could add an if/then in here
mkdir /Library/jamf/
#This gets the IDLE time for variable
IDLE=$((`ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/ !{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'` / 1000000000))
#Writes the variable to flatfile
#Next version to delete this file at the beginning of the script so it doesn't grow over time.
#I made it this way to test... there should be two lines first one is idle when the script ran
#Second should be super close when the if statement starts
echo $IDLE >> /Library/jamf/flatfile
#This is in seconds
if [ "$IDLE" -ge "3600" ] ;
  then
  echo $IDLE >> /Library/jamf/flatfile
  osascript -e 'tell application "System Events" to log out'
  pause 90
  killall loginwindow
fi
exit 0
