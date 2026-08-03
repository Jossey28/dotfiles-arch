#!/usr/sbin/env bash

STATUS=$(warp-cli status | grep -i "Status update:" | awk '{print $3}')
if [ "$STATUS" = "Connected" ]; then
  warp-cli disconnect
  echo "WARP disconnected."
else
  warp-cli connect
  echo "WARP connected."
fi

sleep 0.5 

pkill -SIGRTMIN+8 waybar

sleep 2 

pkill -SIGRTMIN+8 waybar
