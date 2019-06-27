#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch default
polybar -c $HOME/.config/polybar/config default &
