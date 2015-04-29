#!/bin/bash
# Forces SMB1 and disables named streams
NSMB_GLOBAL_CONFIGURATION="/etc/nsmb.conf"
NSMB_CONFIGURATION="/Library/Preferences/nsmb.conf"
if [ -f "$NSMB_GLOBAL_CONFIGURATION" ]; then
    rm "$NSMB_GLOBAL_CONFIGURATION"
fi

if [ -f "$NSMB_CONFIGURATION" ]; then
    rm "$NSMB_CONFIGURATION"
fi

for USER_HOME in /Users/*
  do
    USER_UID=$(basename "${USER_HOME}")
    if [ ! "${USER_UID}" = "Shared" ]; then
        if [ -f "/Users/$USER_UID$NSMB_CONFIGURATION" ]; then
            rm "/Users/$USER_UID$NSMB_CONFIGURATION"
        fi
    fi
done

printf "[default]\nsmb_neg=smb1_only\nstreams=no" > /etc/nsmb.conf
