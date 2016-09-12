#!/bin/bash

pkill conky &
sleep 1

DIR=$(dirname $(readlink -e $0))
HDMIEV=/sys/class/drm/card0-HDMI-A-1/status

# conky
# conky -c /home/dtrip/conk

sleep 1 #time (in s) for the DE to start; use ~20 for Gnome or KDE, less for Xfce/LXDE etc
# conky -c $DIR/rings & # the main conky with rings

if [ $(cat $HDMIEV | grep -Ec "^connected") -eq 1 ]; then
    conky -c ~/conky/.conkyrc-d -x -1300 -o yes
else
    conky -c ~/conky/.conkyrc
fi


# conky -c $DIR/conkyrc1
# conky -c $DIR/conkyrc2
#
# conky -c $DIR/conkyrc &
# sleep 1 #time for the main conky to start; needed so that the smaller ones draw above not below (probably can be lower, but we still have to wait 5s for the rings to avoid segfaults)
# conky -c $DIR/cpu &
# conky -c $DIR/mem &
# conky -c $DIR/notes &
# conky -c $DIR/clock &
# conky -c $DIR/syslog
