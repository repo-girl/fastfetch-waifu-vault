#!/bin/bash
# Picks a random waifu image, caches her info card for fastfetch, prints the image path.
# Usage:  fastfetch --logo-type file --logo "$(~/pick-waifu.sh)"
DIR="${WAIFU_DIR:-$HOME/fastfetch-waifus}"
IMG=$(find "$DIR" -name '*.png' | shuf -n1)
mkdir -p "$HOME/.cache"
CARD="$(dirname "$IMG")/info.md"
if [ -f "$CARD" ]; then cp "$CARD" "$HOME/.cache/waifu-card.md"; else echo "# Unknown waifu" > "$HOME/.cache/waifu-card.md"; fi
echo "$IMG"
