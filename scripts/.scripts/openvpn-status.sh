vpnStatus=($(pgrep -a openvpn$ | head -n 1 | awk '{print $4 }'))

if [ "$vpnStatus" ]; then
  printf $vpnStatus
else
  printf 'disconnected'
fi
