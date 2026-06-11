#!/usr/bin/env sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

env \
  XDG_CONFIG_HOME="$root/nvim-repro" \
  XDG_DATA_HOME="$root/nvim-repro/data" \
  XDG_STATE_HOME="$root/nvim-repro/state" \
  XDG_CACHE_HOME="$root/nvim-repro/cache" \
  nvim --headless -u "$root/nvim-repro/init.lua" \
    '+Lazy! sync' \
    '+lua local installer = require("tree-sitter-manager.installer"); installer.install("haskell"); vim.wait(120000, function() local s = installer.status.haskell; return s and not s.installing end, 100)' \
    '+qa'
