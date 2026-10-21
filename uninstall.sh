#!/usr/bin/env bash
# ==============================================================================
#  Fastfetch Waifu Vault - Uninstaller
# ==============================================================================
set -e

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "${RED}[*] Uninstalling Fastfetch Waifu Vault...${NC}"

rm -rf "$HOME/.config/fastfetch/images_nsfw"
rm -rf "$HOME/.config/fastfetch/waifu_cards"
rm -rf "$HOME/.config/fastfetch/manifests_nsfw"
rm -f "$HOME/.config/fastfetch/characters.json"
rm -f "$HOME/.local/bin/nsfw"
rm -f "/tmp/.fastfetch_nsfw_mode_$(id -u)"

if [ -f "$HOME/.config/fastfetch/config.jsonc.orig" ]; then
    mv -f "$HOME/.config/fastfetch/config.jsonc.orig" "$HOME/.config/fastfetch/config.jsonc"
fi

if [ -f "$HOME/.local/bin/fastfetch" ]; then
    rm -f "$HOME/.local/bin/fastfetch"
fi

echo -e "${GREEN}[✓] Successfully restored previous fastfetch configuration.${NC}"
