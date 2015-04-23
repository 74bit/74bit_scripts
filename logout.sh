#!/bin/sh
#disables sleep
systemsetup -setcomputersleep Never

#http://hints.macworld.com/article.php?story=20040330161158532
echo $((`ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/ !{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'` / 1000000000))
IDLE="$((`ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/ !{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'` / 1000000000))"
if [ "$IDLE" -ge "60
  " ] ;
  then
  osascript -e 'tell application "System Events" to log out'
  pause 90
  killall loginwindow
fi
