#!/bin/bash

I3CONFIG_LINK=$HOME/.config/i3/config
I3CONFIG_SINGLE=$HOME/.config/i3/single
I3CONFIG_MULTI=$HOME/.config/i3/multi


while [ true ]; do
    sleep 10
    CPATH=$(readlink $I3CONFIG_LINK)
    # check if we are on a dock
    if (lsusb | grep "Dell Computer Corp. internal USB Hub of E-Port Replicator"); then
        if [ $CPATH != $I3CONFIG_MULTI ]; then
            ln -sf $I3CONFIG_MULTI $I3CONFIG_LINK
            i3-msg restart
        fi
    else
        if [ $CPATH != $I3CONFIG_SINGLE ]; then
            ln -sf $I3CONFIG_SINGLE $I3CONFIG_LINK
            i3-msg restart
        fi
    fi
done
