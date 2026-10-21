#!/usr/bin/env bash
# ==============================================================================
#  Fastfetch Waifu Vault - One-Click Installer
# ==============================================================================
set -e

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/fastfetch"
BIN_DIR="$HOME/.local/bin"

echo -e "${CYAN}╭──────────────────────────────────────────────────────────╮${NC}"
echo -e "${CYAN}│  🌸 Fastfetch Waifu Vault - Automated Installation      │${NC}"
echo -e "${CYAN}╰──────────────────────────────────────────────────────────╯${NC}\n"

# 1. Dependency checks
echo -e "${YELLOW}[*] Checking system dependencies...${NC}"

if ! command -v fastfetch &>/dev/null; then
    echo -e "${RED}[!] fastfetch is not installed!${NC}"
    echo -e "    Please install fastfetch first: https://github.com/fastfetch-cli/fastfetch"
    exit 1
fi

if ! command -v python3 &>/dev/null; then
    echo -e "${RED}[!] python3 is required but not installed.${NC}"
    exit 1
fi

if ! python3 -c "from PIL import Image" &>/dev/null; then
    echo -e "${YELLOW}[!] Pillow (PIL) is not installed. Installing Pillow via pip...${NC}"
    python3 -m pip install --user pillow || {
        echo -e "${RED}[!] Failed to install Pillow. Please install Pillow manually:${NC}"
        echo -e "    Fedora/RHEL:   sudo dnf install python3-pillow"
        echo -e "    Arch Linux:    sudo pacman -S python-pillow"
        echo -e "    Ubuntu/Debian: sudo apt install python3-pil"
        exit 1
    }
fi
echo -e "${GREEN}[✓] Dependencies verified!${NC}\n"

# 2. Setup directories
echo -e "${YELLOW}[*] Preparing target directories...${NC}"
mkdir -p "$CONFIG_DIR"
mkdir -p "$BIN_DIR"

if [ -f "$CONFIG_DIR/config.jsonc" ] && [ ! -f "$CONFIG_DIR/config.jsonc.orig" ]; then
    echo -e "${CYAN}[i] Backing up existing config.jsonc to config.jsonc.orig${NC}"
    cp "$CONFIG_DIR/config.jsonc" "$CONFIG_DIR/config.jsonc.orig"
fi

# 3. Copy configuration and database
echo -e "${YELLOW}[*] Installing configuration and database...${NC}"
cp -f "$SCRIPT_DIR/config/config.jsonc" "$CONFIG_DIR/"
cp -f "$SCRIPT_DIR/config/characters.json" "$CONFIG_DIR/"
cp -f "$SCRIPT_DIR/config/themes.json" "$CONFIG_DIR/"

if [ -f "$SCRIPT_DIR/config/startup.sh" ]; then
    mkdir -p "$HOME/.config/zsh"
    cp -f "$SCRIPT_DIR/config/startup.sh" "$HOME/.config/zsh/startup.sh"
    chmod +x "$HOME/.config/zsh/startup.sh"
fi

# 4. Copy cutouts & cards
echo -e "${YELLOW}[*] Installing transparent waifu cutouts and metadata cards...${NC}"
mkdir -p "$CONFIG_DIR/images_nsfw"
cp -rf "$SCRIPT_DIR/images_nsfw/"* "$CONFIG_DIR/images_nsfw/"

mkdir -p "$CONFIG_DIR/waifu_cards"
cp -rf "$SCRIPT_DIR/waifu_cards/"* "$CONFIG_DIR/waifu_cards/"

mkdir -p "$CONFIG_DIR/manifests_nsfw"
cp -rf "$SCRIPT_DIR/manifests_nsfw/"* "$CONFIG_DIR/manifests_nsfw/"

# 5. Install scripts to ~/.local/bin
echo -e "${YELLOW}[*] Installing CLI commands (fastfetch, nsfw)...${NC}"
cp -f "$SCRIPT_DIR/bin/fastfetch" "$BIN_DIR/fastfetch"
chmod +x "$BIN_DIR/fastfetch"

cp -f "$SCRIPT_DIR/bin/nsfw" "$BIN_DIR/nsfw"
chmod +x "$BIN_DIR/nsfw"

if [ -f "$SCRIPT_DIR/bin/randomfetch.sh" ]; then
    cp -f "$SCRIPT_DIR/bin/randomfetch.sh" "$CONFIG_DIR/randomfetch.sh"
    chmod +x "$CONFIG_DIR/randomfetch.sh"
fi

# 6. Check PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo -e "${YELLOW}[!] Notice: ~/.local/bin is not in your current PATH.${NC}"
    echo -e "    Add it by appending this to your ~/.bashrc or ~/.zshrc:"
    echo -e "    ${CYAN}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}\n"
fi

echo -e "${GREEN}╭──────────────────────────────────────────────────────────╮${NC}"
echo -e "${GREEN}│  🎉 Installation Complete! Fastfetch Waifu Vault Ready!  │${NC}"
echo -e "${GREEN}╰──────────────────────────────────────────────────────────╯${NC}\n"
echo -e "${YELLOW}[!] ACTIVATION REQUIRED:${NC}"
echo -e "    Run ${CYAN}nsfw${NC} in your terminal to enable Waifu Mode!"
echo -e ""
echo -e "Commands available:"
echo -e "  • ${CYAN}nsfw${NC}        : Activate / Toggle Waifu Mode ON & OFF"
echo -e "  • ${CYAN}fastfetch${NC}   : Run fastfetch with dynamic theme & waifu card"
echo -e "  • Cutouts:   ${CYAN}~/.config/fastfetch/images_nsfw${NC}\n"
