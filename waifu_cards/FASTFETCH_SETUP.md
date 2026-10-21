# Waifu info cards for fastfetch

## Install
1. Unzip this package into your home folder — the `fastfetch-waifus/` tree merges
   with your bundle, putting an `info.md` in every character folder, next to her images.
2. `mv pick-waifu.sh ~/ && chmod +x ~/pick-waifu.sh`

## Show the card in fastfetch
Add this module to your fastfetch `config.jsonc` (inside "modules"):

```jsonc
{
    "type": "command",
    "key": "Waifu",
    "text": "tail -n +3 ~/.cache/waifu-card.md | sed 's/\\*\\*//g'"
}
```

Then run fastfetch through the picker so the logo and the card always match:

```bash
fastfetch --logo-type file --logo "$(~/pick-waifu.sh)"
```

The picker chooses a random PNG and caches that character's card;
the command module prints the card under your system info.
