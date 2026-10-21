#!/usr/bin/env bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  CINEMATIC TERMINAL STARTUP
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

FASTFETCH="fastfetch"

COLS=$(tput cols 2>/dev/null || echo 80)

divider() {
  local color="${1:-\033[2m}"
  local char="${2:-─}"
  local w=$((COLS - 4))
  printf "${color}  "
  printf '%0.s'"$char" $(seq 1 $w)
  printf "\033[0m\n"
}

# Print fastfetch system info immediately (generates dynamic theme)
if command -v "$FASTFETCH" &>/dev/null; then
  "$FASTFETCH" 2>/dev/null
fi

# Load active character theme colors
if [ -f "$HOME/.config/fastfetch/theme_color.env" ]; then
  source "$HOME/.config/fastfetch/theme_color.env"
fi

printf "\n"
divider "\033[38;2;${THEME_R:-217};${THEME_G:-70};${THEME_B:-239}m\033[2m" "─"

QUOTES=(
  "  hack the planet 🌍"
  "  knowledge is power ⚡"
  "  stay curious, stay dangerous 🔥"
  "  the quieter you become, the more you can hear 🎧"
  "  offensive security starts with understanding 🛡️"
  "  root is just a state of mind 💀"
)

RAND_QUOTE="${QUOTES[$RANDOM % ${#QUOTES[@]}]}"
printf "\033[1;38;2;${THEME_R:-217};${THEME_G:-70};${THEME_B:-239}m%s\033[0m\n\n" "$RAND_QUOTE"
