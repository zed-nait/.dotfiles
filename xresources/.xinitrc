xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output DP2 --off --output HDMI1 --off --output HDMI2 --off --output VGA1 --off --output VIRTUAL1 --off

xrdb $HOME/.Xresources

setxkbmap -option caps:escape -layout us,ru -option grp:win_space_toggle

udiskie -A &
dunst -c $HOME/.config/dunst/dunstrc &
xss-lock -- xsecurelock &

sh $HOME/.fehbg
polybar default -r &

sxhkd &
exec bspwm
