#!/usr/sbin/env bash

status=$(warp-cli status 2>&1)

if [[ "$status" =~ "Connected" ]]; then
    echo '{"text": "󱇱  WARP", "tooltip": "Cloudflare WARP: Connected", "class": "connected"}'
elif [[ "$status" =~ "Connecting" ]]; then
    echo '{"text": "  WARP", "tooltip": "Cloudflare WARP: Connecting...", "class": "connecting"}'
else
    echo '{"text": " WARP", "tooltip": "Cloudflare WARP: Disconnected", "class": "disconnected"}'
fi
