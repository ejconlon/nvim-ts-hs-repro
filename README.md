# Neovim Haskell Tree-sitter Crash Repro

Opening `Main.hs` with Haskell tree-sitter highlighting enabled aborts Neovim:

```text
corrupted size vs. prev_size
SIGABRT, status 134
```

## Reproduce

Initialize the parser submodule, build the parser, then open the repro file:

```sh
git submodule update --init --recursive
./setup.sh
./repro.sh
```

`repro.sh` runs Neovim with `--clean`, isolated `XDG_*` paths, and the minimal config in `init.lua`.

## Docker

The Docker repro must run with an interactive TTY. `docker.sh` builds the image and runs `docker run --rm -it ...`:

```sh
./docker.sh
```

Expected output includes `corrupted size vs. prev_size` and exit status 134.

## Minimal Setup

This repro uses only:

- `tree-sitter-haskell` as a git submodule
- `tree-sitter build` to produce `build/parser/haskell.so`
- local queries from `queries/haskell/`
- `vim.treesitter.start()` for Haskell buffers

No plugin manager, LSP, HLS, or other Neovim plugins are involved.

## Trigger

The minimized Haskell source is in `Main.hs`.

The relevant shape is an explicitly exported type with Haddock comments attached to data constructors. Removing the export list or removing those constructor Haddock comments avoids the crash.

## Notes

- Building the parser with `tree-sitter build` reproduces the crash.
- Building the same parser revision through the grammar Makefile did not reproduce it during testing.
- Parser creation/parsing without starting tree-sitter highlighting was stable in earlier isolation.
- Emptying both `highlights` and `injections` queries was stable.
