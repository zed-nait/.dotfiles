#!/bin/bash
xrdb $HOME/.Xresources

setxkbmap -option caps:escape -layout us,ru -option grp:win_space_toggle
xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 0.4 
xmodmap -e “pointer = 1 25 3 4 5 6 7 8 9”

xsetroot -cursor_name left_ptr
xsetroot -solid '#B2B2B2'

udiskie -A &
dunst -c $HOME/.config/dunst/dunstrc &
xss-lock -- xsecurelock &

polybar default -r &

sxhkd &
exec bspwm
#sxhkd -c $HOME/.config/berry/sxhkdrc &
#exec berry -c $HOME/.config/berry/autostart
