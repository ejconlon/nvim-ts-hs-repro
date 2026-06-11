#!/usr/bin/env sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

env \
  XDG_CONFIG_HOME="$root/nvim-repro" \
  XDG_DATA_HOME="$root/nvim-repro/data" \
  XDG_STATE_HOME="$root/nvim-repro/state" \
  XDG_CACHE_HOME="$root/nvim-repro/cache" \
  nvim -u "$root/nvim-repro/init.lua" "$root/Main.hs"
