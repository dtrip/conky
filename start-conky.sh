#!/bin/bash

pkill conky &
sleep 3

DIR=$(dirname $(readlink -e $0))

# conky
# conky -c /home/dtrip/conk

sleep 1 #time (in s) for the DE to start; use ~20 for Gnome or KDE, less for Xfce/LXDE etc
# conky -c $DIR/rings & # the main conky with rings

conky -c ~/conky/.conkyrc


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
