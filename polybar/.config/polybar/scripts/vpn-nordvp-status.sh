#!/bin/sh

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
    nordvpn status | grep IP | tr -d ' ' | cut -d ':' -f2
else
    echo "disconnected"
fi
