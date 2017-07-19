#! /bin/bash
#
# These things are run when an Openbox X Session is started.
# You may place a similar script in $HOME/.config/openbox/autostart
# to run user-specific things.
#

dzen() {
    RC="$HOME/.conkyrc"
    FG="white"
    BG="#000"
    ALIGN="right"
    WIDTH="$1"
    HEIGHT="20"
    FONT="-*-terminus-medium-*-*-*-18-*-*-*-*-*-*-*"

    conky -d -c $RC | dzen2 -fg $FG \
			    -bg $BG \
			    -ta $ALIGN \
			    -w $WIDTH \
			    -h $HEIGHT \
			    -fn $FONT &
}


screens() {
    FIRST="eDP-1"
    SECOND="HDMI-1"
    THIRD="HDMI-2"
    NUMBER=$(xrandr | grep "$SECOND connected" | wc -l)

    if [ "$NUMBER" -eq 1 ]; then
        xrandr --output DP-1 --off \
               --output "$SECOND" --mode 1920x1080 --pos 3840x0 --rotate normal \
               --output "$FIRST" --primary --mode 1920x1080 --pos 0x0 --rotate normal \
               --output "$THIRD" --mode 1920x1080 --pos 1920x0 --rotate
	sleep 1s
    else
	xrandr --output "$FIRST" \
	       --mode 1920x1080
    fi
}

autostart() {
    urxvtd &
    parcellite &
    volumeicon &
    screens &
    nm-applet &
    compton -b &
    nitrogen --restore &
}

autostart
