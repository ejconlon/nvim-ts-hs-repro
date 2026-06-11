#!/usr/bin/env sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

mkdir -p "$root/build/parser" "$root/build/queries/haskell"
tree-sitter build -o "$root/build/parser/haskell.so" "$root/vendor/tree-sitter-haskell"
cp "$root/vendor/tree-sitter-haskell/queries/"*.scm "$root/build/queries/haskell/"
cp "$root/queries/haskell/"*.scm "$root/build/queries/haskell/"
