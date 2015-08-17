#! /bin/bash


# Before doing anything, kill any running dzen2:
kill_counter=$((0))
while [ "$(ps -C dzen2 | grep dzen2 | awk '{print $1}')" ]; do
        kill -9 $(ps -C dzen2 | grep dzen2 | awk '{print $1}') 2>/dev/null
        kill_counter=$((kill_counter+1)); sleep 1
        if [ $kill_counter -ge 5 ]; then
                echo "dzen2 error: unkillable zombies; cannot start new dzen2." 1>&2 && exit 1
        fi
done

# Pre execution: see if 'stop' was passed as $1 and if so
# don't restart dzen2; just exit instead:
[ "$1" = 'stop' ] && exit 0
# END OF FUNCTIONS
# script execution begins here:

# Define colors and spacers etc..:
TX1='#778899'     # blue
TX2='#fffffa'     # light grey text
GRY='#909090'     # dark grey text
BAR='#000000'     # blue
GRN='#65A765'     # light green (normal)
YEL='#FFFFBF'     # light yellow (caution)
RED='#FF0000'     # light red/pink (warning)
WHT='#FFFFFF'     # white
BLK='#000000'     # black
SEP="^p(4)^fg(#555555)^r(4x24)^p(4)"      # item separator block/line
SLEEP=3           # update interval (whole seconds, no decimals!)
CHAR=$((17))      # pixel width of characters of font used
# zero some vars for the CPU load reader:
LASTTOTALCPU0=0; LASTIDLECPU0=0
LASTTOTALCPU1=0; LASTIDLECPU1=0



# endless loop: DZEN on output xinerama-0
while true; do

        sleep $SLEEP

        CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage) "%"}')
        DATE=$(date '+%d-%m-%Y %H:%M')
        MEM=$(awk '/MemTotal:/{total=$2} /MemFree:/{free=$2} END { print int(free*100/total)"%"; }' /proc/meminfo)
        UPDATES=$(aptitude search "~U" | wc -l)
        ROOTFS=$(df -h | grep rootfs | awk '{ print $5 }')
        HOMEFS=$(df -h | grep sda4 | awk '{ print $5 }')

        # echo the string that gets printed on the Dzen2 bar:
        # orig line used for non-dock dzen2:

        echo "// CPU ^fg($TX2)$CPU | ^fg()MEM ^fg($TX2)$MEM | ^fg()Updates ^fg($TX2)$UPDATES | ^fg()/rootfs ^fg($TX2)$ROOTFS | ^fg()/home ^fg($TX2)$HOMEFS | ^fg()Date ^fg($TX2)$DATE ^fg()\\\\"
        # $(get_date)^pa(;4) $(get_mem)^pa(;4) $(disk_space) $(interfaces)"


done | dzen2 -bg $BAR -ta c -fg $TX1 -h 20 -u -p -y 780 &
