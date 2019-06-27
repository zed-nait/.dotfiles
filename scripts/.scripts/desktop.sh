#!/usr/bin/env bash
primaryOutput=($(xrandr | awk '/ connected / && $3 ~ /primary/ {printf("%s ",$1);}'))

notActiveOutput=($(xrandr | awk '/ connected / && $3 !~ /primary/ {printf("%s ",$1);}'))

if [ "$notActiveOutput" ]; then
  xrandr --output $primaryOutput --off --output $notActiveOutput --auto --primary

  sleep 1.0

 	pkill -USR1 -x sxhkd && $HOME/.config/bspwm/bspwmrc

	sleep 1.0

  bspc wm -r

  setxkbmap -option caps:escape -layout us,ru -option grp:win_space_toggle

  sh $HOME/.fehbg


fi
