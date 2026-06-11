#!/usr/bin/env sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

env \
  XDG_CONFIG_HOME="$root/xdg/config" \
  XDG_DATA_HOME="$root/xdg/data" \
  XDG_STATE_HOME="$root/xdg/state" \
  XDG_CACHE_HOME="$root/xdg/cache" \
  nvim --clean -u "$root/init.lua" "$root/Main.hs"
