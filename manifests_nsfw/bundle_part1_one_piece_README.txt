FASTFETCH - BATCH 01 (50 transparent PNG cutouts)
Characters (Naruto, adult): Tsunade, Mei Terumi, Temari, Anko Mitarashi
All PNG, RGBA, background removed, max 800px, sorted by series/character.

Use one image in fastfetch config.jsonc:
  "logo": { "type": "file", "source": "/path/to/tsunade/tsunade_001.png" }

Random image every run (example wrapper):
  fastfetch --logo-type file --logo "$(find ~/fastfetch-waifus -name '*.png' | shuf -n1)"
Sources: see manifest.json (Danbooru post + original source for each file).
