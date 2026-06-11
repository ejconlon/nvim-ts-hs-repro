# Neovim Haskell Tree-sitter Crash Repro

Opening `Main.hs` with Haskell tree-sitter highlighting enabled causes Neovim to abort with:

```text
corrupted size vs. prev_size
SIGABRT, status 134
```

## Confirmed

- Reproduces with the main Neovim config after re-enabling the Haskell parser.
- Reproduces with the standalone config in `nvim-repro/init.lua`.
- Does not require `haskell-tools.nvim` or HLS.
- Does not require `rainbow-delimiters.nvim`.
- The minimized trigger is in `Main.hs`.
- The crash happens in an attached TUI while opening the file, before normal interaction is needed.

## Triggering Syntax

The minimized trigger is in `Main.hs`. It is an explicitly exported type plus multiple Haddock comments attached to constructors.

Observed during reduction:

- Removing the export list avoids the crash.
- Exporting an unrelated name avoids the crash.
- Removing the Haddock constructor comments avoids the crash.
- A single short constructor Haddock comment was not enough to crash.
- `deriving stock` is not required.

## Minimal Repro

The standalone config uses only:

- `lazy.nvim`
- `romus204/tree-sitter-manager.nvim`
- Haskell parser installation
- `vim.treesitter.start()` for Haskell buffers

Run from this directory:

```sh
./setup.sh
./repro.sh
```

Equivalent full command:

```sh
root=$(CDPATH= cd -- "$(dirname -- "./repro.sh")" && pwd)

env \
  XDG_CONFIG_HOME="$root/nvim-repro" \
  XDG_DATA_HOME="$root/nvim-repro/data" \
  XDG_STATE_HOME="$root/nvim-repro/state" \
  XDG_CACHE_HOME="$root/nvim-repro/cache" \
  nvim -u "$root/nvim-repro/init.lua" "$root/Main.hs"
```

## Likely Cause

This points to a native Neovim/tree-sitter issue rather than a dotfiles issue.

Most likely candidates:

- Neovim's built-in tree-sitter highlighter corrupting memory for this Haskell file/query case.
- The compiled Haskell tree-sitter parser corrupting memory while parsing `Main.hs`.
- An interaction between the Haskell parser, Haskell highlight queries, and Neovim's highlighter.

## Next Steps

1. Test parser-only usage without starting the highlighter.
2. Test `vim.treesitter.start()` with Haskell highlight queries removed or replaced.
3. Test the Haskell parser with an external tree-sitter CLI if available.
4. Try further reducing the comment lengths to find the smallest exact threshold.
5. If parser-only is stable but highlighting crashes, report to Neovim with this minimal repro.
6. If parser-only crashes, report against the Haskell tree-sitter parser first.
