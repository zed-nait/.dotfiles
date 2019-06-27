#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumedunst.sh up
# $ ./volumedunst.sh down
# $ ./volumedunst.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
  amixer get $1 | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer get $1 | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

iconPath="/usr/share/icons/Papirus-Dark/symbolic/status"

function send_notification {
  if [ $1 == 'Capture' ] ; then 
    iconSound="$iconPath/audio-input-microphone-high-symbolic.svg"
    iconMuted="$iconPath/audio-input-microphone-muted-symbolic.svg"
    textSound="unmute"
  else
    iconSound="$iconPath/audio-volume-high-symbolic.svg"
    iconMuted="$iconPath/audio-volume-muted-symbolic.svg"

    volume=$(get_volume $1)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq --separator="━" 0 "$((volume / 5))" | sed 's/[0-9]//g')
    textSound="  $bar"
  fi

  if is_mute $1 ; then
    dunstify -i $iconMuted -r 2593 -u normal "mute"
  else
    dunstify -i $iconSound -r 2593 -u normal $textSound
  fi
}

case $1 in
  volume_up)
    # set the volume on (if it was muted)
    amixer -D pulse set Master on > /dev/null
    # up the volume (+ 5%)
    amixer -D pulse sset Master 1%+ > /dev/null
    send_notification Master
    ;;
  volume_down)
    amixer -D pulse set Master on > /dev/null
    amixer -D pulse sset Master 1%- > /dev/null
    send_notification Master
    ;;
  volume_mute)
    # toggle mute
    amixer -D pulse set Master 1+ toggle > /dev/null
    send_notification Master
    ;;
  capture_mute)
    amixer -D pulse set Capture toggle > /dev/null
    send_notification Capture
    ;;
esac
