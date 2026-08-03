#!/usr/bin/env bash

IMG_DIR="$HOME/.config/.assets/images"
IMG_PATH="$IMG_DIR/cover.png"
URL_FILE="$IMG_DIR/last_url.txt"
CURRENT_BG="$IMG_DIR/current_bg.png"

# Set a fallback image for when Spotify is closed
FALLBACK="$HOME/.config/.assets/images/arch_wallpaper_rosepine.png" 

mkdir -p "$IMG_DIR"

# Get the current art URL from playerctl
art_url=$(playerctl -p spotify metadata --format '{{mpris:artUrl}}' 2>/dev/null)

# 1. If nothing is playing or no art is found, use the fallback
if [ -z "$art_url" ]; then
    # Only update the files if the state actually changed
    if [ ! -f "$URL_FILE" ] || [ "$(cat "$URL_FILE")" != "fallback" ]; then
        echo "fallback" > "$URL_FILE"
        ln -sf "$FALLBACK" "$CURRENT_BG"
    fi
    echo "$CURRENT_BG"
    exit 0
fi

# 2. If it's a web URL
if [[ "$art_url" == http* ]]; then
    # Only download if the song changed
    if [ ! -f "$URL_FILE" ] || [ "$(cat "$URL_FILE")" != "$art_url" ]; then
        curl -s "$art_url" -o "$IMG_PATH"
        echo "$art_url" > "$URL_FILE"
        ln -sf "$IMG_PATH" "$CURRENT_BG"
    fi
    echo "$CURRENT_BG"
    exit 0
fi

echo ""
